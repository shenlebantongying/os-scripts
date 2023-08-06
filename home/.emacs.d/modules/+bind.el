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

(global-set-key (kbd "s-x") 'execute-extended-command)

(global-set-key (kbd "s-c") 'kill-ring-save)
(global-set-key (kbd "s-v") 'yank)
(global-set-key (kbd "s-z") 'undo)
(global-set-key (kbd "s-Z") 'undo-redo)
(global-set-key (kbd "s-k") 'kill-this-buffer)
(global-set-key (kbd "s-n") 'make-frame)

(global-set-key (kbd "C-s-l") 'indent-region)

(defun +kill-to-linebegin ()
  "Kill from point to beginning of line."
  (interactive)
  (kill-line 0))

(global-set-key (kbd "C-<backspace>") '+kill-to-linebegin)

(global-set-key (kbd "s-[") 'previous-buffer)
(global-set-key (kbd "s-]") 'next-buffer)

(use-package move-text
  :straight t
  :defer t
  :init
  (move-text-default-bindings))
