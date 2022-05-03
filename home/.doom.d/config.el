;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
(load! "+prog")
(load! "+bind")
(load! "+feed")

(when IS-LINUX
(add-to-list 'load-path "~/.doom.d/cyclone/")
(require 'geiser-cyclone))

(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)
(setq tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60))

(setq-default fill-column 90)

(advice-add #'doom-highlight-non-default-indentation-h :override #'ignore)

(setq initial-frame-alist '((width . 100) (height . 50)))
(setq-default cursor-type 'bar)

(global-hl-line-mode)

(setq display-line-numbers-type nil)
(menu-bar-mode)
(setq tab-bar-separator " ")
(global-form-feed-mode)
(setq-default frame-title-format "%f")

(setq recentf-max-saved-items 500)

;; Make sure that the packaged version are used
;; and without the overhead of doom emacs
(use-package modus-themes
  :ensure
  :init
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
   '(org-block ((t (:background "#f8f8f8" :extend t))))
   '(org-block-begin-line ((t (:background "#f8f8f8" :extend t))))
   '(org-verbatim ((t (:background "#f8f8f8")))))

  (setq  modus-themes-hl-line '(accented))
  (modus-themes-load-themes)
  :config
  (modus-themes-load-operandi))

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "shenlebantongying"
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


(cond
 (IS-MAC
  (setq doom-font (font-spec :family "Ubuntu Mono" :size 16.0))
  (setq doom-unicode-font (font-spec :family "JuliaMono"))
  (setq terminal-here-mac-terminal-command 'iterm2))

 (IS-LINUX
  ;;(setq doom-font (font-spec :family "Terminus" :weight 'bold :size 14.0)))
  (setq doom-font (font-spec :family "Cascadia Code" :size 12.0))
  (setq doom-unicode-font (font-spec :family "JuliaMono")))
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

;; Scheme

(setq geiser-smart-tab-mode t)
(after! geiser
  (setq geiser-guile-binary (let ((guile-exec (executable-find "guile3")))
                              (if guile-exec guile-exec (executable-find "guile"))))
  (setq geiser-chez-binary  (executable-find "chez")))

(after! python
  (setq python-shell-interpreter "ipython3"))

;; racket

(add-hook 'racket-mode-hook #'racket-unicode-input-method-enable)

(use-package goggles
  :hook ((prog-mode text-mode racket) . goggles-mode)
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

(setq! show-paren-style 'parenthesis)

(with-eval-after-load "paren-face"
  (set-face-attribute 'parenthesis nil :foreground "#00B2B2"))

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
(setq which-key-idle-delay 1000)

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

(use-package! dired-sidebar
  :bind (("s-t" . dired-sidebar-toggle-with-current-directory))
  :commands (dired-sidebar-toggle-sidebar)
  :init
  :config
  (setq dired-sidebar-theme 'none))

(after! dired (dired-launch-enable))

(set-default 'preview-scale-function 1.0)

(use-package doom-modeline
  :ensure t
  :init
  (setq minions-mode-line-lighter "𝄞")
  (minions-mode)
  (doom-modeline-mode 1)
  :config
  (setq doom-modeline-icon  nil)
  (setq doom-modeline-height 1)
  (setq doom-modeline-hud t)
  (setq doom-modeline-minor-modes t)
)

(after! cc-mode
  (remove-hook 'c-mode-common-hook #'rainbow-delimiters-mode))



(use-package! maxima
  :init
  (add-hook 'maxima-mode-hook #'maxima-hook-function)
  (add-hook 'maxima-inferior-mode-hook #'maxima-hook-function)
  (setq
   org-format-latex-options (plist-put org-format-latex-options :scale 2.0)
   maxima-display-maxima-buffer nil)
  :mode ("\\.mac\\'" . maxima-mode)
  :interpreter ("maxima" . maxima-mode))

(use-package graphviz-dot-mode
  :ensure t
  :config
  (setq graphviz-dot-indent-width 4))
