;; -*- lexical-binding: t -*-
(global-unset-key (kbd "C-z"))
(global-unset-key (kbd "C-<wheel-down>"))
(global-unset-key (kbd "C-<wheel-up>"))

(global-set-key (kbd "s-r") 'consult-recent-file)
(global-set-key (kbd "s-b") 'consult-buffer)
(global-set-key (kbd "s-f") 'consult-line)
