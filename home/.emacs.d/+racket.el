;; -*- lexical-binding: t -*-
(use-package racket-mode
  :ensure t
  :mode "\\.rkt\\'"  ; give it precedence over :lang scheme
  :config
  (setq racket-xp-after-change-refresh-delay 3))
