;; -*- lexical-binding: t -*-


;; [ Global ]
(defconst IS-MAC   (eq system-type 'darwin))
(defconst IS-LINUX (eq system-type 'gnu/linux))

(cond
 (IS-MAC (setopt ns-right-command-modifier 'control
                 ns-right-option-modifier 'none
                 mac-function-modifier 'hyper)

         (set-face-attribute 'default nil :font "SF Mono" :height 130)
         ;; Note: compile command execute an non-interactive shell. Path here is unrelated.
         (dolist (dir '("/Applications/Racket v8.15/bin/"
                        "/opt/homebrew/bin/"
                        "/Library/TeX/texbin/"
                        "/Users/slbtty/.opam/5.3.0/bin/"
                        "/usr/local/smlnj/bin/"))
           (add-to-list 'exec-path dir)))
 (IS-LINUX
  (set-face-attribute 'default nil :font "Jetbrains Mono" :height 110)))


;; [ package manger slop + scripts ]

(mapc (lambda (n) (load (expand-file-name n user-emacs-directory)))
      '("+pkg-mgr-slop.el"))


;; [ Fix default Emacs ]

(use-package doric-themes :config (doric-themes-select 'doric-light))

(setq-default
 truncate-lines t
 indent-tabs-mode nil
 tab-width 4
 require-final-newline t 
 )

(setopt
 apropos-do-all t
 backup-by-copying t
 compile-command ""
 custom-file (expand-file-name "custom.el" user-emacs-directory)
 frame-title-format "%f"
 inhibit-startup-screen t
 initial-scratch-message nil
 load-prefer-newer t
 make-backup-files nil
 vc-follow-symlinks t
 visible-bell t
 text-mode-ispell-word-completion nil
 ;; ignore cases
 read-file-name-completion-ignore-case t
 read-buffer-completion-ignore-case t
 completion-ignore-case t
 )

(defalias 'yes-or-no-p 'y-or-n-p)


;; [ Universal Modes ]

;; built-in
(tool-bar-mode -1)
(scroll-bar-mode -1)
(when IS-LINUX (menu-bar-mode -1))
(blink-cursor-mode -1)

(context-menu-mode)
(delete-selection-mode)
(editorconfig-mode)
(global-auto-revert-mode)
(global-display-line-numbers-mode)
(recentf-mode)
(save-place-mode)
(savehist-mode)

(use-package uniquify :ensure nil :config (setq uniquify-buffer-name-style 'forward))
(use-package ansi-color :ensure nil :hook (compilation-filter . ansi-color-compilation-filter)) 

;; external

(use-package jinx :init (global-jinx-mode)
  :config
  (setopt jinx-languages "en_CA fr") ;; by default jinx->enchant->aspell->dicts
  )
(use-package hl-todo
  :hook ((prog-mode text-mode) . hl-todo-mode)
  :custom
  (hl-todo-keyword-faces
   `(("TODO" error bold)
     ("FIXME" error bold)
     ("NOTE" success bold))))

(use-package smartparens
  :hook (prog-mode text-mode markdown-mode)
  :config (require 'smartparens-config))

(use-package minions :init (minions-mode))
(use-package zoom :init (zoom-mode))
(use-package move-text :init (move-text-default-bindings))
(use-package transpose-frame)


;; [ Minad ]

(use-package vertico :init (vertico-mode)
  :custom
  (vertico-cycle t)) 
(use-package marginalia :init (marginalia-mode))
(use-package corfu :init (global-corfu-mode)
  :custom
  (corfu-auto t))
(use-package cape
  :init
  (add-hook 'completion-at-point-functions #'cape-file)
  (add-hook 'completion-at-point-functions #'cape-keyword)
  (add-hook 'completion-at-point-functions #'cape-dabbrev)
  )
(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles partial-completion)))))
(use-package consult
  :bind (("s-r" . consult-recent-file)
         ("s-f" . consult-line)
         ("s-b" . consult-buffer)))



;; [ Major/Language Modes ]

(setopt treesit-language-source-alist
        `(,(when IS-LINUX '(kdl "https://github.com/tree-sitter-grammars/tree-sitter-kdl"))
          (typst "https://github.com/uben0/tree-sitter-typst")))

(use-package markdown-mode :hook (markdown-mode . visual-line-mode))
(use-package lua-mode)
(when IS-LINUX (use-package kdl-mode))
(use-package auctex)
(use-package asy-mode :defer t
  :ensure `(asy-mode :repo ,(cond (IS-MAC  "/opt/homebrew/share/emacs/site-lisp/asymptote") (IS-LINUX "/usr/share/asymptote/"))))
(use-package racket-mode)
(use-package typst-ts-mode :ensure (:type git :host codeberg :repo "meow_king/typst-ts-mode")
  :config (setq typst-ts-indent-offset 2))


;; [ Key Binds ]

(use-package +progn :defer t
  :ensure (+progn :repo "~/.emacs.d/+/"))

(mapc
 #'keymap-global-unset
 '(
   "C-<mouse-4>"
   "C-<mouse-5>"
   "C-<wheel-down>"
   "C-<wheel-up>"
   "C-z"
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
 ("s-[" . previous-buffer)
 ("s-]" . next-buffer)

 ("<f1>" . delete-other-windows)
 ("<f2>" . execute-extended-command)
 ("<f3>" . other-window)
 ("<f4>" . split-window-right)
 ("<f5>" . compile)
 ("<f6>" . +invoke-compile-with-selection)

 ("C-<backspace>" . +kill-to-linebegin)
 ("C-`" . +terminal-here)

 ("M-z" . zap-up-to-char)
 ("C-x C-b" . ibuffer)
 
 :map minibuffer-local-map
 ("M-x" . exit-minibuffer)
 )

;;
(recentf-open-files)

