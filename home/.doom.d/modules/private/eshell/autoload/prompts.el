;;; term/eshell/autoload/prompts.el -*- lexical-binding: t; -*-


;;;###autoload
(defun +eshell-default-prompt-fn ()
  "Generate the prompt string for eshell. Use for `eshell-prompt-function'."
  (require 'shrink-path)
  (concat (if (bobp) "" "\n")
          (let ((pwd (eshell/pwd)))
            (propertize (if (equal pwd "~")
                            pwd
                          (abbreviate-file-name (shrink-path-file pwd)))
                        'face '+eshell-prompt-pwd))
          (propertize " λ" 'face (if (zerop eshell-last-command-status) 'success 'error))
          " "))
