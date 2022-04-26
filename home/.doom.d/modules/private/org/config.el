;;; -*- lexical-binding: t; -*-

(use-package! org
  :init
  :defer-incrementally
  org org-agenda
  :config
  (setq org-agenda-files (directory-files-recursively "~/ac/" "\\.org$"))
  (setq org-todo-keywords
        '((sequence "TODO" "|" "DONE")
          (sequence "WORD" "|" "MEMORIZED")))

)

(use-package! ox-pandoc
  :when (executable-find "pandoc")
  :after ox
  :init
  (add-to-list 'org-export-backends 'pandoc)
)


(use-package! ob-racket
  :after org
  :config
  (add-hook 'ob-racket-pre-runtime-library-load-hook
	      #'ob-racket-raco-make-runtime-library))

(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (racket . t)))
