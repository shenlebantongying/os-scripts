;; -*- lexical-binding: t -*-

;; [ Globally critical things ]
(defconst IS-MAC     (eq system-type 'darwin))
(defconst IS-LINUX   (eq system-type 'gnu/linux))

(when IS-MAC
  (dolist (dir '("/Applications/Racket v8.14/bin/"
                 "/opt/homebrew/bin/"
		 "/Library/TeX/texbin/"
		 "/Users/slbtty/.opam/5.2.0/bin/"
		 "/usr/local/smlnj/bin/"))
    (add-to-list 'exec-path dir)))

;; [ elpaca and use-package ]
(defvar elpaca-installer-version 0.7)
(defvar elpaca-directory (expand-file-name "elpaca/" user-emacs-directory))
(defvar elpaca-builds-directory (expand-file-name "builds/" elpaca-directory))
(defvar elpaca-repos-directory (expand-file-name "repos/" elpaca-directory))
(defvar elpaca-order '(elpaca :repo "https://github.com/progfolio/elpaca.git"
                              :ref nil :depth 1
                              :files (:defaults "elpaca-test.el" (:exclude "extensions"))
                              :build (:not elpaca--activate-package)))
(let* ((repo  (expand-file-name "elpaca/" elpaca-repos-directory))
       (build (expand-file-name "elpaca/" elpaca-builds-directory))
       (order (cdr elpaca-order))
       (default-directory repo))
  (add-to-list 'load-path (if (file-exists-p build) build repo))
  (unless (file-exists-p repo)
    (make-directory repo t)
    (when (< emacs-major-version 28) (require 'subr-x))
    (condition-case-unless-debug err
        (if-let ((buffer (pop-to-buffer-same-window "*elpaca-bootstrap*"))
                 ((zerop (apply #'call-process `("git" nil ,buffer t "clone"
                                                 ,@(when-let ((depth (plist-get order :depth)))
                                                     (list (format "--depth=%d" depth) "--no-single-branch"))
                                                 ,(plist-get order :repo) ,repo))))
                 ((zerop (call-process "git" nil buffer t "checkout"
                                       (or (plist-get order :ref) "--"))))
                 (emacs (concat invocation-directory invocation-name))
                 ((zerop (call-process emacs nil buffer nil "-Q" "-L" "." "--batch"
                                       "--eval" "(byte-recompile-directory \".\" 0 'force)")))
                 ((require 'elpaca))
                 ((elpaca-generate-autoloads "elpaca" repo)))
            (progn (message "%s" (buffer-string)) (kill-buffer buffer))
          (error "%s" (with-current-buffer buffer (buffer-string))))
      ((error) (warn "%s" err) (delete-directory repo 'recursive))))
  (unless (require 'elpaca-autoloads nil t)
    (require 'elpaca)
    (elpaca-generate-autoloads "elpaca" repo)
    (load "./elpaca-autoloads")))
(add-hook 'after-init-hook #'elpaca-process-queues)
(elpaca `(,@elpaca-order))

;;

(elpaca elpaca-use-package
  ;; Enable use-package :ensure support for Elpaca.
  (elpaca-use-package-mode))

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

;; [ Small Packages ]
(use-package corfu
  :ensure t
  :init
  (setq corfu-auto t
	corfu-min-width 40
	corfu-quit-no-match 'separator)
  (global-corfu-mode))

(use-package cape
  :ensure t
  :init
  (add-to-list 'completion-at-point-functions #'cape-file)
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-keyword)
  )

(use-package hl-todo
  :ensure t
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
  :ensure t
  :defer t
  :init
  (global-set-key [remap other-window] #'ace-window)
  :config
  (setq aw-scope 'frame
	aw-background t)
  :bind
  (("s-w" . #'ace-window)))

(use-package transpose-frame :ensure t)
(use-package imenu-list :ensure t)


(use-package paredit
  :ensure t
  :init
  (add-hook 'scheme-mode-hook #'enable-paredit-mode)
  )

(use-package minions
  :ensure t
  :init
  (minions-mode))

(use-package sml-mode :ensure t)

(use-package markdown-mode
  :ensure t)

(use-package expand-region
  :ensure t
  :bind
  (("C-=" . #'er/expand-region)))


