;;; lang/racket/config.el -*- lexical-binding: t; -*-

(after! projectile
  (add-to-list 'projectile-project-root-files "info.rkt"))

;;
;;; Packages

(use-package! racket-mode
  :mode "\\.rkt\\'"  ; give it precedence over :lang scheme
  :config
  (set-repl-handler! 'racket-mode #'+racket/open-repl))
