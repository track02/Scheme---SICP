#lang scheme

;Huffman Trees

;Leaves are represented as a list consisting of:
;The symbol leaf (string)
;The symbol _at_ the leaf (e.g. A,B,C)
;The weight
(define (make-leaf symbol weight)
  (list 'leaf symbol weight))
(define (leaf? object) ;Check if something is a leaf, i-e car will contain the symbol 'leaf
  (eq? (car object) 'leaf))
(define (symbol-leaf x) (cadr x))
(define (weight-leaf x) (caddr x))


;A general tree will be a list of a left branch, a right bracn, a set of symbols and a weight
;The set of symbols will just be a list of the symbols
;When we make a tree by merging two nodes:
;Weight -> sum of the node weights
;Set of symbols -> union of the sets of symbols for the nodes

;Since sets are represented as lists we can form the union using the append procedure

(define (make-code-tree left right)
  (list left
        right
        (append (symbols left) (symbols right))
        (+ (weight left) (weight right))))

;The following selectors are also required to build a tree this way
;Note that the procedures weight and symbols must perform differently
;depending on whether they are  called with a leaf or a general tree
;These are examples of generic procedures (procedures which can handle more than one kind of data).

(define (left-branch tree) (car tree))
(define (right-branch tree) (cadr tree))

(define (symbols tree)
  (if (leaf? tree)
      (list (symbol-leaf tree))
      (caddr tree)))

(define (weight tree)
  (if (leaf? tree)
      (weight-leaf tree)
      (cadddr tree)))

;The decoding algorithm operates by takening a list of zeroes and ones
;along with a huffman tree

;decode-1 takes two arguments, the list of remaining bits and the current position
;in the tree, it continually moves down the tree choosing the left or right branch
;according to whether the next bit is zero or one (0 -> left branch / 1 -> right branch, see choose-branch)
;When a leaf if reached the symbol at that leaf is returned as the next symbol in the message
;the leaf symbol is cons'ed onto the result of decoding the rest of the message, starting at the root of the tree
;The error check in choose-branch flags up if something is found that isn't a 1 or 0 in the input data

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

;Ex 2.67 - Decode the following message using the defined encoding tree

(define sample-tree
  (make-code-tree (make-leaf 'A 4)
                  (make-code-tree
                   (make-leaf 'B 2)
                   (make-code-tree (make-leaf 'D 1)
                                   (make-leaf 'C 1)))))
(define sample-message '(0 1 1 0 0 1 0 1 0 1 1 1 0))

;Expect ADABBCA

;> (decode sample-message sample-tree)
;(A D A B B C A)
