#lang scheme

;Representation for leaves of a set, a list containing ('leaf symbol weight)
(define (make-leaf symbol weight)
  (list 'leaf symbol weight))

;Tests if an object is a leaf
(define (leaf? object)
  (eq? (car object) 'leaf))

;Retrieve leaf symbol
(define (symbol-leaf x) (cadr x))

;Retrieve leaf weight
(define (weight-leaf x) (caddr x))

;Retrieve left branch from a tree
(define (left-branch tree) (car tree))

;Retrieve right brancch from a tree
(define (right-branch tree) (cadr tree))

;Retrieve symbol (set) from a tree
(define (symbols tree)
  (if (leaf? tree)
      (list (symbol-leaf tree)) ;If leaf, extract single leaf symbol
      (caddr tree))) ;Otherwise symbol-set

;A general tree consists of a left/right branch a set of symbols and a weight
;The set of symbols is just a list of symbols
;When we make a tree by merging two nodes we obtain the weight of the tree as the sum
(define (make-code-tree left right)
  (list left
        right
        (append (symbols left) (symbols right))
        (+ (weight left) (weight right))))

;Retrieve weight of a tree
(define (weight tree)
  (if (leaf? tree)
      (weight-leaf tree) ;If leaf, extract leaf weight
      (cadddr tree))) ;Otherwise tree weight

;Adjoin set, adds object x into set if not already present
(define (adjoin-set x set)
  (cond ((null? set) (list x))
        ((< (weight x) (weight (car set))) (cons x set))
        (else (cons (car set)
                    (adjoin-set x (cdr set))))))

;Takes a list of symbol-frequency pairs ((A 5) (B 2) (C 1) (D 1))
;and constructs an initial ordered set of leaves, ready to be merged according to Huffman Algorithm

;(make-leaf-set '((A 5) (B 2) (C 1) (D 1)))
;((leaf D 1) (leaf C 1) (leaf B 2) (leaf A 5))
(define (make-leaf-set pairs)
  (if (null? pairs)
      '()
      (let ((pair (car pairs)))
        (adjoin-set (make-leaf (car pair)    ;Symbol
                               (cadr pair))  ;Frequency
                    (make-leaf-set (cdr pairs))))))

;Decodes a series of bits using a provided tree
(define (decode bits tree)
  (define (decode-1 bits current-branch)
    (if (null? bits)
        '()
        (let ((next-branch
               (choose-branch (car bits) current-branch)))
          (if (leaf? next-branch)
              (cons (symbol-leaf next-branch)
                    (decode-1 (cdr bits) tree))
              (decode-1 (cdr bits) next-branch)))))
  (decode-1 bits tree))
(define (choose-branch bit branch)
  (cond ((= bit 0) (left-branch branch))
        ((= bit 1) (right-branch branch))
        (else (error "bad bit -- CHOOSE-BRANCH" bit))))



;Ex 2.69 the following procedure takes a list of symbol-frequency pairs and generates
;a Huffman encoding tree

;Complete the successive-merge procedure, using make-code-tree to successively
;merge the smallest weight elements of the set until only one element remains
;which is the desired huffman tree - remember ordered sets are being used

;Successive merge needs to do the following:
;Search the list for the two elements with the smallest weight
;merge these two elements into one (weight is now summed)
;repeat until one element remains

;if sets are ordered we can take the first two and merge
;the result can then be joined back into the cddr (res of the set) using adjoin-set
(define (successive-merge pairs)
  ;If second element is null, we're done
  (if (null? (cdr pairs))
      (car pairs) ;Return first element
      (successive-merge (adjoin-set ;Otherwise join 
                         (make-code-tree (car pairs) (cadr pairs)) ;the merging of the first two elements
                         (cddr pairs))))) ;to the remaining elements

(define (generate-huffman-tree pairs)
  (successive-merge (make-leaf-set pairs)))


(define test-pairs '((A 4) (B 2) (C 1) (D 1)))
(define test-tree (generate-huffman-tree test-pairs))

;Testing - try generate tree using pairs from Ex 2.67
;> (generate-huffman-tree test-pairs)
;((leaf A 4) ((leaf B 2) ((leaf D 1) (leaf C 1) (D C) 2) (B D C) 4) (A B D C) 8)

;Using the tree to decode the mesage 0 1 1 0 0 1 0 1 0 1 1 1 0
;Expect ADABBCA

(define test-message '(0 1 1 0 0 1 0 1 0 1 1 1 0))

;(decode test-message test-tree)
;(A D A B B C A)

