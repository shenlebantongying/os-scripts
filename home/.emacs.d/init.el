;; -*- lexical-binding: t -*-

;; [ Globally critical things ]
(defconst IS-MAC     (eq system-type 'darwin))
(defconst IS-LINUX   (eq system-type 'gnu/linux))

(when IS-MAC
  (dolist (dir '("/Applications/Racket v8.5/bin/racket"
		 "/opt/homebrew/opt/python@3.10/bin"
                 "/opt/homebrew/bin"
		 "/Library/TeX/texbin"
		 "/Users/slbtty/.opam/5.1.0/bin/"
		 "/usr/local/smlnj/bin/"
		 "/Applications/Racket v8.5.900/bin/"))
    (add-to-list 'exec-path dir)))

;; [ straight and use-package ]
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(setq native-comp-async-report-warnings-errors nil)

;; [ Load personal modules ]
(mapc 'load (file-expand-wildcards  (concat user-emacs-directory "modules/*.el")))

;; [ Personal Appearance Change ]

(load-theme 'modus-operandi t)

(setq-default frame-title-format "%f")

(tool-bar-mode -1)
(menu-bar-mode)
(set-scroll-bar-mode 'left) 

(setq initial-frame-alist '((width . 100) (height . 50)))

(setq-default line-spacing 0)

(cond 
 (IS-MAC
  (set-face-attribute 'default nil :font "Intel One Mono" :height 130)
  (setq mac-function-modifier 'hyper))
 (IS-LINUX
  (set-face-attribute 'default nil :font "IntelOne Mono" :height 100))
 )

;; [ Personal Functionality chagne ]

(setq make-backup-files nil)

(setq inhibit-startup-screen t)
(setq initial-scratch-message nil)

(defalias 'yes-or-no-p 'y-or-n-p)

(setq vc-follow-symlinks t)

(recentf-mode 1)
(setq recentf-max-saved-items 100)

(set-default 'truncate-lines t)
(blink-cursor-mode 0)

(save-place-mode 1) 			; save curosr position for every file opened
(delete-selection-mode 1)		; writes while the is active will overwrite it

(line-number-mode)
(column-number-mode)

(global-auto-revert-mode)

;; isearch

(use-package isearch
  :ensure nil
  :bind (:map isearch-mode-map
              ([remap isearch-delete-char] . isearch-del-char))
  :custom
  (isearch-lazy-count t)
  (lazy-count-prefix-format "%s/%s "))

;; SpeedBar
(custom-set-variables
 '(speedbar-show-unknown-files t)
 )

;; dired
(setq browse-url-handlers '(("\\`file:" . browse-url-default-browser)))

;; RET 后仅保留一个 dired buffer
(setq dired-kill-when-opening-new-dired-buffer t)

;; [ Small Packages ]
(use-package corfu
  :straight t
  :init
  (setq corfu-auto t
	corfu-min-width 40
	corfu-quit-no-match 'separator)
  (global-corfu-mode))

(use-package cape
  :straight t
  :init
  (add-to-list 'completion-at-point-functions #'cape-file)
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-keyword)
  )

(use-package terminal-here
  :straight t
  :init
  (setq terminal-here-mac-terminal-command 'iterm2)
  (setq terminal-here-linux-terminal-command 'konsole)
  :bind
  (( "C-`" . terminal-here)))

(use-package hl-todo
  :straight t
  :hook (prog-mode . hl-todo-mode)
  :config
  (setq hl-todo-highlight-punctuation ":"
        hl-todo-keyword-faces
        `(
          ("TODO" warning bold)
          ("FIXME" error bold)
          ("HACK" font-lock-constant-face bold)
          ("NOTE" success bold)
          ("BUG" error bold)
          ("XXX" font-lock-constant-face bold))))

(use-package ace-window
  :straight t
  :defer t
  :init
  (global-set-key [remap other-window] #'ace-window)
  :config
  (setq aw-scope 'frame
	aw-background t)
  :bind
  (("s-w" . #'ace-window)))

(straight-use-package 'transpose-frame)
(straight-use-package 'imenu-list)

(use-package smartparens
  :straight t
  :init
  (require 'smartparens-config)
  (add-hook 'emacs-lisp-mode-hook #'smartparens-mode)
  (add-hook 'racket-mode-hook #'smartparens-mode))

(use-package minions
  :straight t
  :init
  (minions-mode))

(straight-use-package 'sml-mode)

(use-package markdown-mode
  :straight t)

(use-package expand-region
  :straight t
   :bind
   (("C-=" . #'er/expand-region)))

;; [ Clean up ]
(when (get-buffer "*straight-process*")
  (kill-buffer "*straight-process*"))
