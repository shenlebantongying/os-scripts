;; -*- lexical-binding: t -*-


;; [ Global ]
(defconst IS-MAC   (eq system-type 'darwin))
(defconst IS-LINUX (eq system-type 'gnu/linux))

(cond
 (IS-MAC (setopt ns-right-command-modifier 'control
                 mac-function-modifier 'hyper)

         (set-face-attribute 'default nil :font "SF Mono" :height 125)

         (dolist (dir '("/Applications/Racket v8.15/bin/"
                        "/opt/homebrew/bin/"
                        "/Library/TeX/texbin/"
                        "/Users/slbtty/.opam/5.3.0/bin/"
                        "/usr/local/smlnj/bin/"))
           (add-to-list 'exec-path dir)))
 (IS-LINUX
  (set-face-attribute 'default nil :font "Cascadia Mono" :height 110)))


;; [ package manger slop + scripts ]

(mapc (lambda (n) (load (expand-file-name n user-emacs-directory)))
      '("+pkg-mgr-slop.el"
        "+progn.el"))


;; [ Fix default Emacs ]

(load-theme 'modus-operandi-tinted)

(setq-default
 frame-title-format "%f"
 line-spacing 0
 compile-command ""
 truncate-lines t
 indent-tabs-mode nil
 tab-width 4
 )


(setopt
 initial-scratch-message nil
 inhibit-startup-screen t

 make-backup-files nil
 vc-follow-symlinks t
 switch-to-buffer-obey-display-actions t
 )

(defalias 'yes-or-no-p 'y-or-n-p)


;; [ Universal Modes ]

;; built-in
(tool-bar-mode -1)
(scroll-bar-mode -1)
(when IS-LINUX (menu-bar-mode -1))
(blink-cursor-mode -1)

(global-display-line-numbers-mode)

(save-place-mode)
(savehist-mode)
(recentf-mode)
(global-auto-revert-mode)
(which-key-mode)

(delete-selection-mode)

(editorconfig-mode)

(use-package ansi-color :ensure nil :hook (compilation-filter . ansi-color-compilation-filter)) 

;; external

(use-package jinx :init (global-jinx-mode))
(use-package minions :init (minions-mode))
(use-package zoom :init (zoom-mode))

(use-package hl-todo
  :hook (prog-mode . hl-todo-mode)
  :custom
  (hl-todo-keyword-faces
   `(("TODO" font-lock-constant-face bold)
     ("FIXME" error bold)
     ("HACK" warning bold)
     ("NOTE" success bold)
     ("BUG" error bold))))


;; [ Minad ]

;; icomplete-mode is very similar
(use-package vertico :init (vertico-mode)) 
(use-package marginalia :init (marginalia-mode))

(use-package corfu :init (global-corfu-mode)
  :custom
  (corfu-auto t)
  (corfu-quit-no-match 'separator))

(use-package cape
  :config
  (add-to-list 'completion-at-point-functions #'cape-file)
  (add-to-list 'completion-at-point-functions #'cape-keyword)
  )

(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles partial-completion)))))


(use-package consult
  :bind (("s-r" . consult-recent-file)
         ("s-f" . consult-line)
         ("s-b" . consult-buffer)))


;; Packages

(use-package move-text :init (move-text-default-bindings))
(use-package transpose-frame)


;; [ Major/Language Modes ]
(use-package paredit :hook (scheme-mode . enable-paredit-mode))
(use-package markdown-mode :hook (markdown-mode . visual-line-mode))
(use-package lua-mode)
(use-package transient)
(use-package magit)

(use-package kdl-mode)

(setopt treesit-language-source-alist
    '((https://github.com/tree-sitter-grammars/tree-sitter-kdl))
)

(use-package auctex)

(when IS-MAC
  (add-to-list 'load-path "/opt/homebrew/share/emacs/site-lisp/asymptote")
  (require 'asy-mode))


;; [ Key Binds ]

(mapc
 #'keymap-global-unset
 '(
   "C-<mouse-4>"
   "C-<mouse-5>"
   "C-<wheel-down>"
   "C-<wheel-up>"
   "C-z"
   "M-z"
   ))

;; M-x describe-personal-keybindings
(bind-keys
 ("C-S-p" . execute-extended-command)
 ("C-<tab>" . tab-to-tab-stop)

 ("s-x" . kill-region)
 ("s-c" . kill-ring-save)
 ("s-v" . yank)
 ("s-z" . undo)
 ("s-Z" . undo-redo)
 ("s-k" . kill-buffer-and-window)
 ("s-n" . make-frame)
 ("s-d" . dired)
 ("s-[" . previous-buffer)
 ("s-]" . next-buffer)

 ("<f1>" . delete-other-windows)
 ("<f2>" . execute-extended-command)
 ("<f3>" . other-window)
 ("<f4>" . split-window-right)
 ("<f5>" . compile)
 ("<f6>" . +invoke-compile-selection)

 ("C-<backspace>" . +kill-to-linebegin)
 ("C-`" . +terminal-here)
 )

(bind-keys
 :map minibuffer-local-map
 ("M-x" . exit-minibuffer))


