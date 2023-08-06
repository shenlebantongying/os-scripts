(use-package spell-fu
  :straight t)

(add-hook 'spell-fu-mode-hook
  (lambda ()
    (spell-fu-dictionary-add
     (spell-fu-get-personal-dictionary "personal" "~/.emacs.d/spell-personal.txt"))))
