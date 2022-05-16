;;; -*- lexical-binding: t; -*-

(use-package org
  :init
  :defer
  :config
  (setq org-link-descriptive nil)
  (setq org-agenda-files (directory-files-recursively "~/ac/" "\\.org$"))
  (setq org-todo-keywords
        '((sequence "TODO" "|" "DONE")
          (sequence "WORD" "|" "MEMORIZED")))

)
