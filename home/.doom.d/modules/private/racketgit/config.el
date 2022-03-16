;;; lang/racket/config.el -*- lexical-binding: t; -*-

(after! projectile
  (add-to-list 'projectile-project-root-files "info.rkt"))

;;
;;; Packages

(use-package! racket-mode
  :mode "\\.rkt\\'"  ; give it precedence over :lang scheme
  :config
  (remove-hook! 'racket-mode-hook #'racket-unicode-input-method-enable)
  (add-hook! 'racket-mode-hook
             #'paren-face-mode
             #'racket-xp-mode)
)
