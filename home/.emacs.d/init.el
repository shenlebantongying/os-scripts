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

;; [ Personal Appearance Change]

(global-hl-line-mode)

(use-package modus-themes
  :straight t
  :ensure
  :init
  (setq modus-themes-hl-line '(accented))
  (setq modus-themes-mode-line '(3d))

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
   '(org-block ((t (:background "#f8f8f8" :extend t))))
   '(org-block-begin-line ((t (:background "#f8f8f8" :extend t))))
   '(org-verbatim ((t (:background "#f8f8f8"))))
   )
)

(load-theme 'modus-operandi t)

(tool-bar-mode -1)
(menu-bar-mode)
(global-display-line-numbers-mode)

(setq initial-frame-alist '((width . 100) (height . 50)))
(setq-default cursor-type 'bar)

(cond 
 (IS-MAC
  (set-face-attribute 'default nil :font "Ubuntu Mono" :height 150)
  (setq mac-function-modifier 'hyper))
 (IS-LINUX
  (set-face-attribute 'default nil :font "Cascadia Code" :height 110))
)

;;; [ Personal Functionality chagne]

(setq make-backup-files nil)

(setq inhibit-startup-screen t)
(setq initial-scratch-message nil)
(defalias 'yes-or-no-p 'y-or-n-p)

(setq vc-follow-symlinks nil)

(recentf-mode 1)
(setq recentf-max-saved-items 100)

(set-default 'truncate-lines t)

;; [ Small Packages]

(use-package corfu
  :straight t
  :init
  (setq corfu-auto t
      corfu-quit-no-match 'separator)
  (global-corfu-mode))


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

;; [ Hacks for `emacs -nw`]
(unless (display-graphic-p)
    (set-display-table-slot standard-display-table
                        'vertical-border
                        (make-glyph-code ?│))
    (xterm-mouse-mode 1))

;; [ Clean up ]
  (when (get-buffer "*straight-process*")
    (kill-buffer "*straight-process*"))

