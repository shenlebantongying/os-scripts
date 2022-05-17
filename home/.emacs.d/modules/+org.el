;;; -*- lexical-binding: t; -*-

(use-package org
  :init
  (add-hook 'org-mode-hook #'visual-line-mode)
  :defer
  :config
  (setq org-link-descriptive nil)
  (setq org-agenda-files (directory-files-recursively "~/ac/" "\\.org$"))
  (setq org-todo-keywords
        '((sequence "TODO" "|" "DONE")
          (sequence "WORD" "|" "MEMORIZED"))))
