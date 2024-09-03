;; -*- lexical-binding: t -*-
(use-package geiser
  :ensure t
  :config
  (setq geiser-guile-binary "guile")
  (setq geiser-chez-binary "chez")
  )

(use-package geiser-guile
  :ensure t)

(use-package geiser-chez
  :ensure t)
