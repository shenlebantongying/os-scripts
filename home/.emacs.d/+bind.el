;; -*- lexical-binding: t -*-
(global-unset-key (kbd "C-z"))
(global-unset-key (kbd "C-<wheel-up>"))
(global-unset-key (kbd "C-<mouse-4>"))
(global-unset-key (kbd "C-<wheel-down>"))
(global-unset-key (kbd "C-<mouse-5>"))
(global-unset-key (kbd "M-z"))

(global-set-key (kbd "s-t") 'speedbar)

(when IS-MAC
  (setq ns-right-command-modifier 'meta)
  (setq ns-right-option-modifier 'alt))

(defun +kill-this-buffer-for-real ()
  "The built in one need menu."
  (interactive)
  (kill-buffer (current-buffer)))

(global-set-key (kbd "s-x") 'kill-region)
(global-set-key (kbd "s-c") 'kill-ring-save)
(global-set-key (kbd "s-v") 'yank)
(global-set-key (kbd "s-z") 'undo)
(global-set-key (kbd "s-Z") 'undo-redo)
(global-set-key (kbd "s-k") '+kill-this-buffer-for-real)
(global-set-key (kbd "s-n") 'make-frame)

(global-set-key (kbd "<f1>") 'delete-other-windows)
(global-set-key (kbd "<f2>") 'split-window-right)

(defun +kill-to-linebegin ()
  "Kill from point to beginning of line."
  (interactive)
  (kill-line 0))

(global-set-key (kbd "C-<backspace>") '+kill-to-linebegin)

(global-set-key (kbd "s-[") 'previous-buffer)
(global-set-key (kbd "s-]") 'next-buffer)

(use-package move-text
  :ensure t
  :defer t
  :init
  (move-text-default-bindings))

(defun +terminal-here ()
  "open terminal at the path of current file"
  (interactive)
  (shell-command
   (cond
    ((boundp 'IS-MAC)
     (concat "/Applications/WezTerm.app/Contents/MacOS/wezterm start --new-tab --cwd "
	     (file-name-directory buffer-file-name)
	     "& disown")
     (boundp 'IS-LINUX) (concat "/usr/bin/foot -D " (file-name-directory buffer-file-name) )))))

(global-set-key (kbd "C-`") '+terminal-here)

