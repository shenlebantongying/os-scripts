;;; lang/racket/autoload.el -*- lexical-binding: t; -*-

;;;###autoload
(defun racket-fmt ()
  "run formatter on racket buffer"
  (interactive)
  (let ((cur-pos (point)))
    (shell-command-on-region
     ;; beginning and end of buffer
     (point-min)
     (point-max)
     ;; command and parameters
     "raco format"
     ;; output buffer
     (current-buffer)
     ;; replace?
     t
     ;; name of the error buffer
     "*Rackt fmt Error Buffer*"
     ;; show error buffer?
     t))
  (goto-char (point)))
