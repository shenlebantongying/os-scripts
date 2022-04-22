;;; -*- lexical-binding: t; -*-

(use-package! org
  :defer-incrementally
  org org-agenda
  :config
  (setq org-agenda-files (directory-files-recursively "~/ac/" "\\.org$"))
  (setq org-todo-keywords
        '((sequence "TODO" "|" "DONE")
          (sequence "WORD" "|" "MEMORIZED"))))

(use-package! ox-pandoc
  :when (executable-find "pandoc")
  :after ox
  :init
  (add-to-list 'org-export-backends 'pandoc)
)
