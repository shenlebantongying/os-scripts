;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)
(setq tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60))

(setq initial-frame-alist '( (width . 110) (height . 40)))

(menu-bar-mode)

(menu-bar-left-scroll-bar)
; (tool-bar-mode)

;;(setq +doom-dashboard-functions
;;      '(doom-dashboard-widget-shortmenu))

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "slbtty"
      user-mail-address "shenlebantongying@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

(setq doom-theme 'modus-operandi)
(cond
 (IS-MAC
  (setq doom-font (font-spec :family "JetBrains Mono" :size 14.0)))
 (IS-LINUX
;;(setq doom-font (font-spec :family "Terminus" :weight 'bold :size 14.0)))
  (setq doom-font (font-spec :family "Cascadia Code" :size 13.0)))
)

(setq font-lock-maximum-decoration 1)

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; mac related bindings
(when IS-MAC
  (setq
   mac-function-modifier 'hyper
  ;; mac-right-option-modifier 'control
   )
  (map!
   "H-w" #'previous-line
   "H-s" #'next-line
   "H-a" #'backward-char
   "H-d" #'forward-char
   "H-q" #'backward-word
   "H-e" #'forward-word
   "H-2" #'scroll-down
   "H-x" #'scroll-up
   )
  )

;; generic
(map!
 "RET" #'electric-newline-and-maybe-indent
 "s-o" #'find-file-at-point
 "s-t" #'find-file
 "s-b" #'consult-buffer
 "s-w" #'ace-window
 "s-f" #'consult-line
 "s-c" #'kill-ring-save
 "s-v" #'yank
 "s-r" #'consult-recent-file
 "s-z" #'undo
 "s-Z" #'undo-fu-only-redo
 ;; org
 "s-l" #'org-preview-latex-fragment

 "<f5>" #'+vterm/toggle
 )

 (global-unset-key (kbd "C-z"))

;; override some defaults
;; (use-package! treemacs
;;   :config
;;   (setq treemacs-follow-mode t
;;         treemacs-position 'right))

;; Scheme

(setq geiser-smart-tab-mode t)
(after! geiser
  (setq geiser-guile-binary (executable-find "guile3"))
  (setq geiser-chez-binary  (executable-find "chez")))

(after! python
  (setq python-shell-interpreter "ipython3"))

(use-package centaur-tabs
  :init
  (setq centaur-tabs-enable-key-bindings t)
  :ensure t
  :config
  (setq centaur-tabs-height 5)
  (setq centaur-tabs-set-icons nil)
  (setq centaur-tabs-set-bar 'under)
  (setq x-underline-at-descent-line t)
  (setq centaur-tabs-enable-key-bindings t)
)

(setq org-directory "~/workbench-universe/")


;; racket

(add-hook 'racket-mode-hook #'racket-unicode-input-method-enable)

;; as recommended by
(use-package paredit
  :ensure t
  :config
  (dolist (m '(
               ;racket-mode-hook
               ;emacs-lisp-mode-hook
               ;racket-repl-mode-hook
         ))
    (add-hook m #'paredit-mode))
  (bind-keys :map paredit-mode-map
             ("{"   . paredit-open-curly)
             ("}"   . paredit-close-curly))
  (unless terminal-frame
    (bind-keys :map paredit-mode-map
               ("M-[" . paredit-wrap-square)
               ("M-{" . paredit-wrap-curly))))


(use-package! goggles
  :hook ((prog-mode text-mode) . goggles-mode)
  :config
  (setq-default goggles-pulse t)) ;; set to nil to disable pulsing

;; A few more useful configurations...
(use-package! emacs
  :init
  ;; TAB cycle if there are only few candidates
  (setq completion-cycle-threshold 3)

  ;; Emacs 28: Hide commands in M-x which do not apply to the current mode.
  ;; Corfu commands are hidden, since they are not supposed to be used via M-x.
  ;; (setq read-extended-command-predicate
  ;;       #'command-completion-default-include-p)

  ;; Enable indentation+completion using the TAB key.
  ;; `completion-at-point' is often bound to M-TAB.
  (setq tab-always-indent 'complete))

(defun insert-current-date ()
  "Insert standard date."
  (interactive)
  (isert (shell-command-to-string "date +%Y-%m-%d")))

;; LaTeX related

(after! latex
  (setq font-lock-maximum-decoration t)
)

;; to future, there is a bug about truncate-lines,
;; this is a temporal solution
(add-hook 'LaTeX-mode-hook
          (lambda ()
            (visual-line-mode -1)
            (toggle-truncate-lines 1)))

(custom-set-faces
 '(font-lock-function-name-face ((t (:foreground "black"))))
 '(font-lock-keyword-face ((t (:foreground "black"))))
 '(font-lock-type-face ((t (:foreground "black"))))
 '(font-lock-builtin-face ((t (:foreground "black"))))
 '(font-lock-variable-name-face ((t (:foreground "black"))))
 '(font-lock-constant-face ((t (:foreground "black"))))
 '(font-lock-string-face ((t (:foreground "black"))))
 '(highlight-numbers-number ((t (:foreground "black"))))
 '(font-lock-negation-char-face ((t (:foreground "black"))))
 '(show-paren-match ((t (:background "red1" :foreground "white"))))
)
