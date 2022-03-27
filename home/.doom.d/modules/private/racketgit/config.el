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
   (map! :map racket-mode-map
    "H-l" #'racket-insert-lambda
    "H-i" #'racket-fmt
    "H-p" #'racket-cycle-paren-shapes
    "C-k"  #'sp-kill-hybrid-sexp
    "H-t" #'sp-transpose-sexp
    "s-<f1>" #'racket-xp-documentation
    "<prior>" #'sp-up-sexp
    "<next>" #'sp-down-sexp
    "<end>" #'sp-forward-parallel-sexp
    "<home>" #'sp-backward-parallel-sexp))
    (mapcar (lambda (x) (put x 'racket-indent-function 1))
           (list 'run*
                 'fresh
                 'claim))
)

(add-hook
 'racket-mode-hook
 #'(lambda ()
     (face-remap-add-relative 'default :foreground "#222277")
     (face-remap-add-relative 'racket-reader-quoted-symbol-face :foreground "#222277")
     (face-remap-add-relative 'font-lock-variable-name-face :foreground "#222277")
     (face-remap-add-relative 'font-lock-keyword-face :foreground "#222277")
     (face-remap-add-relative 'font-lock-string-face :foreground "#227722")
     (face-remap-add-relative 'font-lock-comment-face :foreground "#772277")
     (face-remap-add-relative 'highlight-numbers-number :foreground "#222277")
     (face-remap-add-relative 'font-lock-constant-face :foreground "#227722")))
