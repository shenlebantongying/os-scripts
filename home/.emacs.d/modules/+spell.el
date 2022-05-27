(use-package spell-fu
  :straight t)

(add-hook 'org-mode-hook
  (lambda ()
    (setq spell-fu-faces-exclude
     '(org-block-begin-line
       org-block-end-line
       org-code
       org-date
       org-drawer org-document-info-keyword
       org-ellipsis
       org-link
       org-meta-line
       org-properties
       org-properties-value
       org-special-keyword
       org-src
       org-tag
       org-verbatim))
    (spell-fu-mode)))

(add-hook 'spell-fu-mode-hook
  (lambda ()
    (spell-fu-dictionary-add
     (spell-fu-get-personal-dictionary "personal" "~/.emacs.d/spell-personal.txt"))))
