#!/usr/bin/env racket
#lang racket

; find the largest file with in a dir
; usage: a-large-file-finder.rkt <path>

; TODO: add option to ignore hidden file?
; TDOO: stop using `fold-files` because it cannot do find file concurrently

(define parent-dir
  (command-line
   #:args (pname)
   (expand-user-path pname)))

(for-each
 (λ (arg)
   (printf "~a ~a\n" (second arg) (first arg)))
 (sort
  (fold-files
   (λ (fpath type acc)
     (cond
       [(string-prefix? (path->string fpath) ".")
        acc]
       [(equal? type 'file)
        (cons (list fpath (file-size fpath)) acc)]
       [(equal? type 'dir)
        acc]
       [(equal? type 'link)
        acc]))
   '()
   (current-directory))
  #:key second
  <))