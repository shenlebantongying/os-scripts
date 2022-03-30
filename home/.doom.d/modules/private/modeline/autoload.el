;;; ui/modeline/autoload/modeline.el -*- lexical-binding: t; -*-

;;;###autoload
(defun +modeline-clear-env-in-all-windows-h (&rest _)
  "Blank out version strings in all buffers."
  (unless (featurep! +light)
    (dolist (buffer (buffer-list))
      (with-current-buffer buffer
        (setq doom-modeline-env--version
              (bound-and-true-p doom-modeline-load-string)))))
  (force-mode-line-update t))
