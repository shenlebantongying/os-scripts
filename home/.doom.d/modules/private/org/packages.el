;; -*- no-byte-compile: t; -*-
(package! ox-pandoc)

;; https://github.com/hasu/emacs-ob-racket
(package! ob-racket
  :recipe ( :host github
            :repo "hasu/emacs-ob-racket"
            :files ("*.el" "*.rkt")))
