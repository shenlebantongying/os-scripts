;;; ~/.doom.d/+prog.el -*- lexical-binding: t; -*-

(defun occur-at-point ()
  "Run occur using the `word-at-point'."
  (interactive)
  (let ((term (thing-at-point 'word t)))
    (occur term)))

(defun insert-current-date ()
  "Insert standard date."
  (interactive)
  (insert (shell-command-to-string "date +%Y-%m-%d")))
