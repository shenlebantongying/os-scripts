;;; -*- lexical-binding: t; -*-

(use-package org
  :init
  (add-hook 'org-mode-hook #'visual-line-mode)
  :defer
  :config
  (setq org-link-descriptive nil)
  (setq org-agenda-files (directory-files-recursively "~/ac/" "\\.org$"))
  (setq org-todo-keywords
        '((sequence "TODO" "|" "DONE")
          (sequence "WORD" "|" "MEMORIZED")))

  ;; hack https://stackoverflow.com/a/65922607/12494649
  (when IS-MAC
    (plist-put org-format-latex-options :scale 3)
    (defun my/overlay-scale-advice (beg end image &optional imagetype)
      (mapc (lambda (ov) (if (equal (overlay-get ov 'org-overlay-type) 'org-latex-overlay)
                             (overlay-put ov
                                          'display
                                          (list 'image :type (or (intern imagetype) 'png) :file image :ascent 'center :scale 0.6))))
            (overlays-at beg)))
    (advice-add 'org--make-preview-overlay :after #'my/overlay-scale-advice))
)

(use-package org-fragtog
  :straight t
  :after (org)
  :init
  (add-hook 'org-mode-hook 'org-fragtog-mode))
