;; -*- lexical-binding: t -*-

;; [ Globally critical things ]
(defconst IS-MAC     (eq system-type 'darwin))
(defconst IS-LINUX   (eq system-type 'gnu/linux))

(when IS-MAC
  (dolist (dir '("/Applications/Racket v8.5/bin/racket"
		 "/opt/homebrew/opt/python@3.10/bin"
                 "/opt/homebrew/bin"
		 "/Library/TeX/texbin"
		 "~/.opam/4.14.0/bin"
		 "/usr/local/smlnj/bin/"))
    (add-to-list 'exec-path dir)))

;; [ straight and use-package ]
(defvar bootstrap-version)
(let ((bootstrap-file			
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)

(mapc 'load (file-expand-wildcards  (concat user-emacs-directory "modules/*.el")))

;; [ Personal Appearance Change ]

(setq font-lock-maximum-decoration
      '((c-mode . 3)
	(t . 1)))

(use-package modus-themes
  :straight t
  :init
  (setq modus-themes-mode-line '(borderless))

  (custom-set-faces
   ;; Org code blocks
   '(org-block ((t (:background "#f8f8f8" :extend t))))
   '(org-block-begin-line ((t (:background "#f8f8f8" :extend t))))
   '(org-verbatim ((t (:background "#f8f8f8"))))

   ;; Comment
   '(font-lock-comment-face ((t (:foreground "MediumOrchid"))))
   )
  )

(load-theme 'modus-operandi t)

(setq-default frame-title-format "%f")

(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode)

(setq initial-frame-alist '((width . 100) (height . 50)))

(cond 
 (IS-MAC
  (set-face-attribute 'default nil :font "SF Mono" :height 130)
  (setq mac-function-modifier 'hyper))
 (IS-LINUX
  (set-face-attribute 'default nil :font "Cascadia Code" :height 110))
 )

;; [ Personal Functionality chagne ]

(setq make-backup-files nil)

(setq inhibit-startup-screen t)
(setq initial-scratch-message nil)

(defun display-startup-echo-area-message ()
  (message
   "Emacs loaded in %s ."
   (format
    "%.2f seconds"
    (float-time
     (time-subtract after-init-time before-init-time)))))

(defalias 'yes-or-no-p 'y-or-n-p)

(setq vc-follow-symlinks t)

(recentf-mode 1)
(setq recentf-max-saved-items 100)

(set-default 'truncate-lines t)
(blink-cursor-mode 0)

(save-place-mode 1) 			; save curosr position for every file opened
(delete-selection-mode 1)		; writes while the region is active will overwrite it


(line-number-mode)
(column-number-mode)

(global-display-line-numbers-mode)

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
;; 直接在dired里按W (browse-url-of-dired-file), 这会直接用外部程序打开。 当然，它不会阻塞Emacs。
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
  :bind
  (( "C-`" . terminal-here)))

(use-package hl-todo
  :straight t
  :hook (prog-mode . hl-todo-mode)
  :config
  (setq hl-todo-highlight-punctuation ":"
        hl-todo-keyword-faces
        `(;; For things that need to be done, just not today.
          ("TODO" warning bold)
          ;; For problems that will become bigger problems later if not
          ;; fixed ASAP.
          ("FIXME" error bold)
          ;; For tidbits that are unconventional and not intended uses of the
          ;; constituent parts, and may break in a future update.
          ("HACK" font-lock-constant-face bold)
          ;; For things that were done hastily and/or hasn't been thoroughly
          ;; tested. It may not even be necessary!
          ("REVIEW" font-lock-keyword-face bold)
          ;; For especially important gotchas with a given implementation,
          ;; directed at another user other than the author.
          ("NOTE" success bold)
          ;; For things that just gotta go and will soon be gone.
          ("DEPRECATED" font-lock-doc-face bold)
          ;; For a known bug that needs a workaround
          ("BUG" error bold)
          ;; For warning about a problematic or misguiding code
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
  (add-hook 'emacs-lisp-mode-hook #'smartparens-mode))

(use-package minions
  :straight t
  :init
  (minions-mode))

(straight-use-package 'sml-mode)

(use-package markdown-mode
  :straight t)

(use-package magit
  :straight t
  :defer t)

(use-package diff-hl
  :straight t
  :init
  (global-diff-hl-mode))

;; [ Hacks for `emacs -nw`]
(unless (display-graphic-p)
  (set-display-table-slot standard-display-table
                          'vertical-border
                          (make-glyph-code ?│))
  (xterm-mouse-mode 1))

;; [ Clean up ]
(when (get-buffer "*straight-process*")
  (kill-buffer "*straight-process*"))
