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
  (setq racket-xp-after-change-refresh-delay 3)
  (when IS-MAC
   (map!
    "H-l" #'racket-insert-lambda
    "H-i" #'racket-fmt
    "H-p" #'racket-cycle-paren-shapes
    "C-k"  #'sp-kill-hybrid-sexp
    "H-t" #'sp-transpose-sexp
    "s-<f1>" #'racket-xp-documentation
    "<prior>" #'sp-up-sexp
    "<next>" #'sp-down-sexp
    "<end>" #'sp-forward-parallel-sexp
    "<home>" #'sp-backward-parallel-sexp)))
