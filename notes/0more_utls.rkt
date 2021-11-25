#!/usr/bin/env racket
#lang racket

;; sorting 0more_utls.md
;; TODO: highly inefficient
;; TODO: comment can only be in 1 line now.

(define myfile "0more_utls")
(define data (file->lines myfile))

;(sort data string<?)
;
;(for-each (lambda (strl)
;           (when  (string-prefix? strl "#")
;                (print strl)))
;          data)

(define section-names '())
(define sorted-util-names '())
(define temp-list '())

(for ([l data])
  (cond
    [(not (non-empty-string? l)) void]
    [(string-prefix? l "#")
      (begin
        (set! section-names (append section-names (list l)))
        (unless (empty? temp-list)
          (begin (if (empty? sorted-util-names)
                     (set! sorted-util-names (list temp-list))
                     (set! sorted-util-names (append sorted-util-names (list temp-list))))
                 (set! temp-list '()))))]
    [else (set! temp-list (append temp-list (list l)))]
    ))

(define out (open-output-file myfile #:exists 'truncate))

(for ([sortl
       (map (lambda (arg) (sort arg string<?))
            sorted-util-names)]
      [indel section-names])
  (begin
    (displayln indel out)
    (for-each (lambda (arg)
                (displayln arg out))
              sortl)
    )
  )

(displayln "#end" out)
(close-output-port out)

