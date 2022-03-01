;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(load! "+prog")

(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)
(setq tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60))

(setq initial-frame-alist '((width . 110) (height . 40)))

(set-fringe-mode 0)
(menu-bar-mode)
(setq tab-bar-separator " ")
(setq-default frame-title-format "%f")
(menu-bar-left-scroll-bar)

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
  (tool-bar-mode)
  (setq doom-font (font-spec :family "Ubuntu Mono" :size 18.0)))
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
 "M-s-b" #'ibuffer
 "s-w" #'ace-window
 "s-f" #'consult-line
 "s-c" #'kill-ring-save
 "s-v" #'yank
 "s-r" #'consult-recent-file
 "s-z" #'undo
 "s-Z" #'undo-fu-only-redo
 ;; org
 "s-l" #'org-preview-latex-fragment
 )

 (global-unset-key (kbd "C-z"))

;; Scheme

(setq geiser-smart-tab-mode t)
(after! geiser
  (setq geiser-guile-binary (let ((guile-exec (executable-find "guile3")))
                              (if guile-exec guile-exec (executable-find "guile"))))
  (setq geiser-chez-binary  (executable-find "chez")))

(after! python
  (setq python-shell-interpreter "ipython3"))

;; No tabs are needed
;; (use-package centaur-tabs
;;   ;; :init
;;   ;; (setq centaur-tabs-enable-key-bindings t)
;;   :config
;;   (setq centaur-tabs-height 5)
;;   (setq centaur-tabs-set-icons nil)
;;   (setq centaur-tabs-set-bar nil)
;;   (setq x-underline-at-descent-line t)
;;   :bind
;;   ("<C-s-left>" . centaur-tabs-backward)
;;   ("<C-s-right>" . centaur-tabs-forward)
;;   ("s-1" . centaur-tabs-select-visible-tab)
;;   ("s-2" . centaur-tabs-select-visible-tab)
;;   ("s-3" . centaur-tabs-select-visible-tab)
;;   ("s-4" . centaur-tabs-select-visible-tab)
;;   ("s-5" . centaur-tabs-select-visible-tab)
;;   ("s-6" . centaur-tabs-select-visible-tab)
;;   ("s-7" . centaur-tabs-select-visible-tab)
;;   ("s-8" . centaur-tabs-select-visible-tab)
;;   ("s-9" . centaur-tabs-select-visible-tab)
;; )

(setq org-directory "~/workbench-universe/")

;; racket

(add-hook 'racket-mode-hook #'racket-unicode-input-method-enable)

;; as recommended by
(use-package paredit
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


(use-package goggles
  :hook ((prog-mode text-mode racket-mode) . goggles-mode)
  :config
  (setq-default goggles-pulse t))

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

(setq! show-paren-style 'parenthesis)
(with-eval-after-load "modus-themes"
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
   '(rainbow-delimiters-depth-1-face ((t (:foreground "#145c33"))))
   '(proof-tactics-name-face ((t (:foreground "black"))))
   '(coq-solve-tactics-face ((t (:foreground "black"))))
  ;; '(show-paren-match ((t (:background "red1" :foreground "black"))))
   '(show-paren-match-expression ((t (:background "LightGoldenrod"))))
))

(use-package! modues-themes
  :defer nil
  :config
  (setq modus-themes-hl-line '(accented)))

(with-eval-after-load "paren-face"
  (set-face-attribute 'parenthesis nil :foreground "thistle4"))

(after! scheme
  (remove-hook 'scheme-mode-hook #'rainbow-delimiters-mode)
  (add-hook 'scheme-mode-hook #'paren-face-mode))
(after! geiser
  (remove-hook 'geiser-mode-hook #'rainbow-delimiters-mode))

;; when `emacs -nw`
(unless (display-graphic-p)
    (set-display-table-slot standard-display-table
                        'vertical-border
                        (make-glyph-code ?│))
    (xterm-mouse-mode 1))
(setq which-key-idle-delay 0.1)

(use-package doom-modeline
  :config
  (setq doom-modeline-height 1)
  (setq doom-modeline-icon nil)
)

(with-eval-after-load 'company-coq
  (add-to-list 'company-coq-disabled-features 'prettify-symbols))

;; proof-general
(use-package proof-general
  :custom
  (proof-three-window-mode-policy 'hybird))

(use-package company-coq
  :init
   (setq company-coq-disabled-features '(hello company-defaults code-folding)))

(after! coq-mode
  (tool-bar-mode 1))

(use-package! tempel
  :init
  (setq tempel-file (expand-file-name "templates" doom-private-dir)))
