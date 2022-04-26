;;; term/eshell/autoload/eshell.el -*- lexical-binding: t; -*-

;;;###autoload
(defun +eshell/quit-or-delete-char (arg)
  "Delete a character (ahead of the cursor) or quit eshell if there's nothing to
delete."
  (interactive "p")
  (if (and (eolp) (looking-back eshell-prompt-regexp nil))
      (progn (eshell-life-is-too-much) (delete-frame))
    (delete-char arg)))
