;;; ~/.doom.d/+bind.el -*- lexical-binding: t; -*-

(global-unset-key (kbd "C-z"))
(global-unset-key (kbd "C-<wheel-down>"))
(global-unset-key (kbd "C-<wheel-up>"))

;; mac related bindings
(when IS-MAC
  (setq
   mac-function-modifier 'hyper
   mac-right-option-modifier 'alt
  ;; mac-right-option-modifier 'control
   )
  (map!
   ;;"C-<wheel-up>" #'next-line
   ;;"C-<wheel-down>" #'previous-line
   "C-<wheel-left>" #'forward-char
   "C-<wheel-right>" #'backward-char
   )
)

;; generic
(map!
 "RET" #'electric-newline-and-maybe-indent
 "s-o" #'find-file-at-point
 "s-b" #'consult-buffer
 "M-s-b" #'ibuffer
 "s-w" #'ace-window
 "s-f" #'consult-line
 "s-c" #'kill-ring-save
 "s-v" #'yank
 "s-r" #'consult-recent-file
 "s-z" #'undo
 "s-Z" #'undo-fu-only-redo
 "s-[" #'previous-buffer
 "s-]" #'next-buffer
 ;; org
 "s-l" #'org-preview-latex-fragment
 ;; expand-region
 "C-="  #'er/expand-region
 "C--"  #'er/contract-region

 ;; the ^L
 "s-{" #'backward-page
 "s-}" #'forward-page

 ;;

 "s-<mouse-1>" #'mc/add-cursor-on-click
)

(define-key mode-line-buffer-identification-keymap [mode-line mouse-1] 'consult-buffer)
