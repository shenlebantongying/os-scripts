;;; -*- lexical-binding: t; -*-

(use-package tuareg
  :ensure t
  :defer t)

(use-package merlin
  :ensure t
  :defer t)

(use-package dune
  :ensure t
  :defer t)

(add-hook 'tuareg-mode-hook #'merlin-mode)
