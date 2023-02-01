;; -*- lexical-binding: t -*-
(use-package geiser
  :straight t
  :config
  (setq geiser-guile-binary "guile")
  (setq geiser-chez-binary "chez")
  )

(use-package geiser-guile
  :straight t)

(use-package geiser-chez
  :straight t)
