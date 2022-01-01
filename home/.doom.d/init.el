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
       (company +childframe)         ; the ultimate code completion backend
       (vertico +icons)        ; a search engine for love and life

       :ui
       doom              ; what makes DOOM look the way it does
       hl-todo           ; highlight TODO/FIXME/NOTE/DEPRECATED/HACK/REVIEW
       modeline          ; snazzy, Atom-inspired modeline, plus API
       ophints           ; highlight the region an operation acts on
       (popup +defaults)   ; tame sudden yet inevitable temporary windows
       tabs              ; a tab bar for Emacs
       neotree
       vc-gutter         ; vcs diff in the fringe
       vi-tilde-fringe   ; fringe tildes to mark beyond EOB
       (window-select +switch-window)     ; visually switch windows
       zen               ; distraction-free coding or writing

       :editor
       ;parinfer -> good mode, but not everyone follow the indentation standard.
       snippets

       :emacs
       (dired +icons)             ; making dired pretty [functional]
       electric          ; smarter, keyword-based electric-indent
       ibuffer         ; interactive buffer management
       undo              ; persistent, smarter undo for your inevitable mistakes

       :term
       vterm             ; the best terminal emulation in Emacs

       :checkers
       syntax              ; tasing you for every semicolon you forget
       ;spell ; tasing you for misspelling mispelling

       :tools
       (eval +overlay)     ; run code, run (also, repls)
       lookup              ; navigate your code and its documentation
       (lsp +peek)

       :os
       (:if IS-MAC macos)  ; improve compatibility with macOS
                           ;
       :lang
       (cc +lsp)
       clojure
       common-lisp       ; if you've seen one lisp, you've seen them all
       coq               ; proofs-as-programs
       emacs-lisp        ; drown in parentheses
       erlang            ; an elegant language for a more civilized age
       (latex +latexmk
              +cdlatex)  ; writing papers in Emacs has never been so fun
       markdown          ; writing docs for people to ignore
       (org +pandoc)     ; organize your plain life in plain text
       (scheme +chez 
               +guile
               +chibi)    ; a fully conniving family of lisps
       (sh +fish)         ; she sells {ba,z,fi}sh shells on the C xor
       python
       sml
       ocaml
       (racket +xp)

       :email

       :app

       :config
       (default +bindings +smartparens))
