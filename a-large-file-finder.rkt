#!/usr/bin/env racket
#lang racket

; find the largest file with in a dir
; usage: a-large-file-finder.rkt <path>

; TODO: add option to ignore hidden file?
; TDOO: stop using `fold-files` because it cannot do find file concurrently

(define (filesize->readable nbytes)
  (if (= nbytes 0)
      "0 B"
      (let* ([units '("B" "KiB" "MiB" "GiB" "TiB" "PiB" "EiB" "ZiB" "YiB")]
             [i (exact-floor (log nbytes 1024))]
             [s (exact->inexact (/ nbytes (expt 1024 i)))])
        (format "~a ~a" (~r s #:precision 2) (list-ref units i)))))

(define parent-dir
  (command-line
   #:args (pname)
   (path->complete-path(expand-user-path pname))))

(for-each
 (λ (arg)
   (printf "~a ~a\n" (filesize->readable (second arg)) (first arg)))
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
   parent-dir)
  #:key second
  <))
