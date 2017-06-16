#lang scheme

;Exercise 2.47. Here are two possible constructors for frames:

(define (make-frame-1 origin edge1 edge2)
  (list origin edge1 edge2)) ;(1 2 3)

(define (make-frame-2 origin edge1 edge2)
  (cons origin (cons edge1 edge2))) ;(1 2 . 3)

;For each constructor supply the
;appropriate selectors to produce an implementation for frames.

;origin-frame
(define (origin-frame-1 frame)
  (car frame))

(define (origin-frame-2 frame)
  (car frame))

;edge1-frame
(define (edge1-frame-1 frame)
  (cadr frame))

(define (edge1-frame-2 frame)
  (cadr frame))

;edge2-frame
(define (edge2-frame-1 frame)
  (caddr frame)) ;Using list - take car of cdr cdr (edge2, ())

(define (edge2-frame-2 frame)
  (cddr frame)) ;Using pairs cdr to last element

;Testing - use integers instead of vectors
(define f1 (make-frame-1 1 2 3))
(define f2 (make-frame-2 1 2 3))
