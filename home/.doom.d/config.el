;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)
(setq tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60))

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

(after! centaur-tabs
  (setq centaur-tabs-height 10)
  (setq centaur-tabs-set-icons nil)
  (setq centaur-tabs-set-bar 'under)
  (setq x-underline-at-descent-line t)
)

(after! doom-modeline
  (setq doom-modeline-height 1)
  (setq doom-modeline-icon nil))

(setq org-directory "~/workbench-universe/")

;(use-package! dashboard
;  :hook
;  ((after-init . dashboard-setup-startup-hook))
;  :config
; ;; (setq dashboard-filter-agenda-entry 'dashboard-filter-agenda-by-todo)
;  :custom
;  (dashboard-startup-banner nil)
;  (dashboard-center-content t)
;  (dashboard-set-file-icons t)
;  (dashboard-set-heading-icons t)
;  (dashboard-items '((recents  . 10)
;                     (projects . 10)
;                     ;;(agenda . 6)
;                     ))
; )

;; racket

(add-hook 'racket-mode-hook #'racket-unicode-input-method-enable)

;; as recommended by 
(use-package paredit
  :ensure t
  :config
  (dolist (m '(
               racket-mode-hook
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


;; (defun efs/display-startup-time ()
;;   (message
;;    "Emacs loaded in %s with %d garbage collections."
;;    (format
;;     "%.2f seconds"
;;     (float-time
;;      (time-subtract after-init-time before-init-time)))
;;    gcs-done))

;; (add-hook 'emacs-startup-hook #'efs/display-startup-time)

(use-package goggles
  :hook ((prog-mode text-mode) . goggles-mode)
  :config
  (setq-default goggles-pulse t)) ;; set to nil to disable pulsing

;; Minad

(use-package corfu
  ;; Optional customizations
  :custom
  ;; (corfu-cycle t)                ;; Enable cycling for `corfu-next/previous'
  (corfu-auto t)                 ;; Enable auto completion
  ;; (corfu-commit-predicate nil)   ;; Do not commit selected candidates on next input
  ;; (corfu-quit-at-boundary t)     ;; Automatically quit at word boundary
  ;; (corfu-quit-no-match t)        ;; Automatically quit if there is no match
  ;; (corfu-preview-current nil)    ;; Disable current candidate preview
  ;; (corfu-preselect-first nil)    ;; Disable candidate preselection
  (corfu-echo-documentation t) ;; Disable documentation in the echo area
  ;; (corfu-scroll-margin 5)        ;; Use scroll margin

  ;; You may want to enable Corfu only for certain modes.
  ;; :hook ((prog-mode . corfu-mode)
  ;;        (shell-mode . corfu-mode)
  ;;        (eshell-mode . corfu-mode))

  ;; Recommended: Enable Corfu globally.
  ;; This is recommended since dabbrev can be used globally (M-/).
  :init
  (corfu-global-mode))

;; Optionally use the `orderless' completion style. See `+orderless-dispatch'
;; in the Consult wiki for an advanced Orderless style dispatcher.
;; Enable `partial-completion' for files to allow path expansion.
;; You may prefer to use `initials' instead of `partial-completion'.
(use-package orderless
  :init
  ;; Configure a custom style dispatcher (see the Consult wiki)
  ;; (setq orderless-style-dispatchers '(+orderless-dispatch)
  ;;       orderless-component-separator #'orderless-escapable-split-on-space)
  (setq completion-styles '(orderless)
        completion-category-defaults nil
        completion-category-overrides '((file (styles . (partial-completion))))))

;; Use dabbrev with Corfu!
(use-package dabbrev
  ;; Swap M-/ and C-M-/
  :bind (("M-/" . dabbrev-completion)
         ("C-M-/" . dabbrev-expand)))

;; A few more useful configurations...
(use-package emacs
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

  (use-package corfu
  :init
  (corfu-global-mode))

;; Add extensions
(use-package cape
  ;; Bind dedicated completion commands
  :bind (("C-c p p" . completion-at-point) ;; capf
         ("C-c p t" . complete-tag)        ;; etags
         ("C-c p d" . cape-dabbrev)        ;; or dabbrev-completion
         ("C-c p f" . cape-file)
         ("C-c p k" . cape-keyword)
         ("C-c p s" . cape-symbol)
         ("C-c p a" . cape-abbrev)
         ("C-c p i" . cape-ispell)
         ("C-c p l" . cape-line)
         ("C-c p w" . cape-dict)
         ("C-c p \\" . cape-tex)
         ("C-c p &" . cape-sgml)
         ("C-c p r" . cape-rfc1345))
  :init
  ;; Add `completion-at-point-functions', used by `completion-at-point'.
  (add-to-list 'completion-at-point-functions #'cape-file)
  (add-to-list 'completion-at-point-functions #'cape-tex)
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-keyword)
  ;;(add-to-list 'completion-at-point-functions #'cape-sgml)
  ;;(add-to-list 'completion-at-point-functions #'cape-rfc1345)
  ;;(add-to-list 'completion-at-point-functions #'cape-abbrev)
  (add-to-list 'completion-at-point-functions #'cape-ispell)
  ;;(add-to-list 'completion-at-point-functions #'cape-dict)
  (add-to-list 'completion-at-point-functions #'cape-symbol)
  ;;(add-to-list 'completion-at-point-functions #'cape-line)
)

(defun insert-current-date () (interactive)
 (isert (shell-command-to-string "date +%Y-%m-%d")))
