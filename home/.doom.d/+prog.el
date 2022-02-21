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

;; helper
(defun goto-match-paren (arg)
  "Go to the matching  if on (){}[], similar to vi style of % "
  (interactive "p")
  ;; first, check for "outside of bracket" positions expected by forward-sexp, etc.
  (cond ((looking-at "[\[\(\{]") (forward-sexp))
        ((looking-back "[\]\)\}]" 1) (backward-sexp))
        ;; now, try to succeed from inside of a bracket
        ((looking-at "[\]\)\}]") (forward-char) (backward-sexp))
        ((looking-back "[\[\(\{]" 1) (backward-char) (forward-sexp))
        (t nil)))

(defun select-match-parens ()
  (interactive)
  (set-mark (point))
  (goto-match-paren 1))

(defun insert-geiser-implementation (choice)
  "insert the string that indicating which scheme are using."
  (interactive
   (let ((completion-ignore-case t))
     (list (completing-read "Choose: "
                          (seq-map (lambda (x) `(,x . ,x)) geiser-active-implementations) nil t))))
  (insert ";; -*- geiser-scheme-implementation: " choice " -*-"))
