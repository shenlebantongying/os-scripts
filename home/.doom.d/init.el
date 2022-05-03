;;; init.el -*- lexical-binding: t; -*-

;; This file controls what Doom modules are enabled and what order they load
;; in. Remember to run 'doom sync' after modifying it!

;; NOTE Press 'SPC h d h' (or 'C-h d h' for non-vim users) to access Doom's
;;      documentation. There you'll find a "Module Index" link where you'll find
;;      a comprehensive list of Doom's modules and what flags they support.

;; NOTE Move your cursor over a module's name (or its flags) and press 'K' (or
;;      'C-c c k' for non-vim users) to view its documentation. This works on
;;      flags as well (those symbols that start with a plus).
;;
;;      Alternatively, press 'gd' (or 'C-c c d') on a module to browse its
;;      directory (for easy access to its source code).

(doom! :input

       :completion
       (vertico +icons)        ; a search engine for love and life

       :ui
       ;;doom              ; what makes DOOM look the way it does
       hl-todo           ; highlight TODO/FIXME/NOTE/DEPRECATED/HACK/REVIEW
       (popup +defaults)   ; tame sudden yet inevitable temporary windows
       ;;tabs              ; a tab bar for Emacs
       window-select     ; visually switch windows
       zen               ; distraction-free coding or writing
       minimap

       :editor
       ;parinfer -> good mode, but not everyone follow the indentation standard.
       snippets

       :emacs
       (dired +icons)             ; making dired pretty [functional]
       electric          ; smarter, keyword-based electric-indent
       (ibuffer +icons)         ; interactive buffer management
       undo              ; persistent, smarter undo for your inevitable mistakes

       :term

       :checkers
       ;;syntax         ; Somehow uselss, because if you don't
                        ;understand the language, syntax check cannot save u
       spell ; tasing you for misspelling mispelling

       :tools
       (eval +overlay)     ; run code, run (also, repls)
       lookup              ; navigate your code and its documentation

       :os
       (:if IS-MAC macos)  ; improve compatibility with macOS
                           ;
       :lang
       cc
       go
       clojure
       common-lisp       ; if you've seen one lisp, you've seen them all
       emacs-lisp        ; drown in parentheses
       erlang            ; an elegant language for a more civilized age
       markdown          ; writing docs for people to ignore
       (scheme +chez
               +guile
               +chibi
               +mit
               +chicken
               +gambit)    ; a fully conniving family of lisps
       (sh +fish)         ; she sells {ba,z,fi}sh shells on the C xor
       python
       sml
       ocaml
       lua
       haskell

       :private
       magit
       racketgit
       proofgeneral
       ;;dashboard
       org
       (corfu +icons)
       ;; eshell => the experience is not worth
       syntax
       (auctex +latexmk)  ; writing papers in Emacs has never been so fun


       :email

       :app

       :config
       (default +smartparens))
