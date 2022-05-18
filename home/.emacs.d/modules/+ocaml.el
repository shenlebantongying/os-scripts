;;; -*- lexical-binding: t; -*-

(use-package tuareg
  :straight t
  :defer t)

(use-package merlin
  :straight t
  :defer t)

(use-package dune
  :straight t
  :defer t)

(add-hook 'tuareg-mode-hook #'merlin-mode)
