;; -*- lexical-binding: t -*-


;; [ Global ]
(defconst IS-MAC   (eq system-type 'darwin))
(defconst IS-LINUX (eq system-type 'gnu/linux))
(defconst IS-WINDOWS (eq system-type 'windows-nt))

(load-theme 'newcomers-presets)

(cond
 (IS-MAC (setopt ns-right-command-modifier 'control
                 ns-right-option-modifier 'none ;; for AltGr
                 mac-function-modifier 'hyper)

         (setenv "ESHELL" "/opt/homebrew/bin/fish")

         (server-start)

         (set-face-attribute 'default nil :font "SF Mono" :height 130)
         ;; Note: compile command execute an non-interactive shell. Path here is unrelated.
         (dolist (dir
                  '("/Applications/Racket v9.2/bin/"
                    "/Library/Developer/CommandLineTools/usr/bin/"
                    "/opt/homebrew/bin/"
                    "/Library/TeX/texbin/"
                    "/Users/slbtty/.opam/5.5.0/bin/"))
           (add-to-list 'exec-path dir))
         (setenv "PATH" (string-join exec-path ":")))

 (IS-LINUX
  (set-face-attribute 'default nil :font "Jetbrains Mono" :height 110))
 (IS-WINDOWS
  (set-face-attribute 'default nil :font "Ubuntu Sans Mono" :height 110)
  ;; Note: this won't override lots of Win- hotkeys
  (setopt w32-pass-lwindow-to-system nil
          w32-lwindow-modifier 'super))
 )


;; [ package manger slop + scripts ]

(mapc (lambda (n) (load (expand-file-name n user-lisp-directory)))
      '("+pkg-mgr-slop.el"))

(elpaca elpaca-use-package (elpaca-use-package-mode))
(setq use-package-always-ensure t)

(use-package compat) ;; corfu dep


;; [ Fix default Emacs ]
(use-package doric-themes :config (doric-themes-select 'doric-light))

(setq-default
 truncate-lines t
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
;(scroll-bar-mode -1)
(when IS-LINUX (menu-bar-mode -1))
(blink-cursor-mode -1)

(global-auto-revert-mode)
(global-display-line-numbers-mode)

(use-package uniquify :ensure nil :config (setq uniquify-buffer-name-style 'forward))
(use-package ansi-color :ensure nil :hook (compilation-filter . ansi-color-compilation-filter))

;; external

(use-package mode-line-bell :init (mode-line-bell-mode))

(when (not IS-WINDOWS)
  (use-package jinx :init (global-jinx-mode)
    :config
    ;; by default jinx->enchant->aspell->dicts
    (setopt jinx-languages "en_CA fr")))

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
(use-package golden-ratio-scroll-screen)
(use-package magit)


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
(use-package consult)



;; [ Major/Language Modes ]

(setopt treesit-language-source-alist
        `(,(when IS-LINUX '(kdl "https://github.com/tree-sitter-grammars/tree-sitter-kdl"))
          (typst "https://github.com/uben0/tree-sitter-typst")))

(use-package markdown-mode :hook (markdown-mode . visual-line-mode))
(use-package lua-mode)
(when IS-LINUX (use-package kdl-mode))

(use-package auctex
  :ensure (auctex :host github :repo "emacsmirror/auctex" :branch "master"))

(let* ((asy-path
        (cond
         (IS-MAC  "/opt/homebrew/share/emacs/site-lisp/asymptote/asy-mode.el")
         (IS-LINUX "/usr/share/asymptote/asy-mode.el")))
       (asy-exists (and asy-path (file-exists-p asy-path))))
  (when asy-exists
    (eval `(use-package asy-mode :defer t
             :ensure (asy-mode :type file :main ,asy-path)))))

;; Racket
(use-package racket-mode)
(use-package typst-ts-mode :ensure (:type git :host codeberg :repo "meow_king/typst-ts-mode")
  :config (setq typst-ts-indent-offset 2))

;; OCaml
(use-package tuareg :defer t)


;; [ Key Binds ]

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

(let ((extra-prefix
       (cond
        (IS-WINDOWS ""))))
  (bind-keys
   :prefix-map my-global-map
   :prefix extra-prefix
   :prefix "C-c"
   ("k" . kill-buffer-and-window)
   ("n" . make-frame)
   ("1" . +set-frame-size-to-120)
   ("r" . consult-recent-file)
   ("l" . consult-line)
   ("b" . consult-buffer)

   ("," . window-layout-transpose)
   ))

(bind-keys
 ("C-<tab>" . tab-to-tab-stop)

 ("s-[" . previous-buffer)
 ("s-]" . next-buffer)
 ("s-<down>" . golden-ratio-scroll-screen-up)
 ("s-<up>" . golden-ratio-scroll-screen-down)

 ("<f1>" . delete-other-windows)

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
(add-hook 'emacs-startup-hook 'delete-other-windows)
