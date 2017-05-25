#lang scheme

;Implement a representation for rectangles in a plane
;Create procedures that compute the perimeter and area of a given rectangle

;A rectangle can be seen as an origin point (p1) and a height and width
;These values allow any of the other 3 points to be determined along with the area and perimeter

;Implement two variations of rectangle ensuring both can be used by same the area / perimeter procedures

;Constructor
(define (make-rect p h w)
  (cons p (cons h w))) ;Bundle into a list -> point, height, width

(define (make-rect-points p1 p2)
  ;Given two points need to calculate height/width
  ;Height = abs y diff
  ;Width = abs x diff
  (let ((height
         (abs(- (y-point p1) (y-point p2))))
        (width
         (abs (- (x-point p1) (x-point p2)))))
    (cons p1 (cons height width))))

;Selectors
(define (origin-point-rect r)
  (car r))

(define (height-rect r)
  (car (cdr r)))

(define (width-rect r)
  (cdr (cdr r)))

;Procedures
(define (area-rect r)
  (* (height-rect r) (width-rect r)))

(define (perim-rect r)
  (+ (* 2 (height-rect r))
     (* 2 (width-rect r))))


        



;Point
(define (make-point x y)
  (cons x y))

(define (x-point p)
  (car p))

(define (y-point p)
  (cdr p))

;Procedure to print points
(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ",")
  (display (y-point p))
  (display ")"))


    
        


  
