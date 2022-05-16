;; -*- lexical-binding: t -*-

;; [Globally critical things]
(defconst IS-MAC     (eq system-type 'darwin))
(defconst IS-LINUX   (eq system-type 'gnu/linux))

(when IS-MAC
  (dolist (dir '("/Applications/Racket v8.5/bin/racket"))
    (add-to-list 'exec-path dir)))

;; Setup straight and use-package
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


(setq make-backup-files nil)


(setq inhibit-startup-screen t)
(setq initial-scratch-message nil)
(defalias 'yes-or-no-p 'y-or-n-p)

(setq vc-follow-symlinks nil)


(use-package corfu
  :straight t
  :init
  (setq corfu-auto t
      corfu-quit-no-match 'separator)
  (global-corfu-mode))

(use-package modus-themes
  :straight t
  :ensure
  :init
)

(load-theme 'modus-operandi t)

;; [ Personal config ]

(tool-bar-mode -1)
(menu-bar-mode)
(global-display-line-numbers-mode)


(setq initial-frame-alist '((width . 100) (height . 50)))
(setq-default cursor-type 'bar)

(recentf-mode 1)
(setq recentf-max-saved-items 100)
(global-set-key (kbd "s-r") 'consult-recent-file)

(when IS-MAC
  (set-face-attribute 'default nil :font "Ubuntu Mono" :height 150)
  (setq mac-function-modifier 'hyper)
)

;; [Clean up]
  (when (get-buffer "*straight-process*")
    (kill-buffer "*straight-process*"))
