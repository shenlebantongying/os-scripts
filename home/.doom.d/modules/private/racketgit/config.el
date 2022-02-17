;;; lang/racket/config.el -*- lexical-binding: t; -*-

(after! projectile
  (add-to-list 'projectile-project-root-files "info.rkt"))


;;
;;; Packages

(use-package! racket-mode
  :mode "\\.rkt\\'"  ; give it precedence over :lang scheme
  :config
  (set-repl-handler! 'racket-mode #'+racket/open-repl)
  (set-lookup-hanet-xp produce error popups, but racket-xp's are
    ;; higher quality so disable flycheck's:
    (when (featurep! :checkers syntax)
      (add-hook! 'racket-xp-mode-hook
        (defun +racket-disable-flycheck-h ()
          (cl-pushnew 'racket flycheck-disabled-checkers)))))

  (unless (or (featurep! :editor parinfer)
              (featurep! :editor lispy))
    (add-hook 'racket-mode-hook #'racket-smart-open-bracket-mode)))
