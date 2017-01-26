#lang scheme

;The Monte Carlo method consists of choosing sample experiments at random from a large set
;and making deductions on the basis of the
;probabilities estimated from tabulating the results of those experiments.

;PI can be estimated using the fact that 6/PI^2 is the probability that two random integers
;will have no factors in common, meaning a GCD of 1. (Cesaro's Theorem)

;We can devise an experiment in which two random integers are chosen and a test is performed to determine
;if their GCD is 1.

;To obtain our approximation of PI we repeat this experiment a large number of times, the fraction of times
;that the test is passed  gives us our estimate of 6/PI^2 and from this we can obtain an approximation of PI.

;Original estimate-pi procedure using the cesare test
;(define (estimate-pi trials)
;  (sqrt (/ 6 (monte-carlo trials cesaro-test))))
;
;(define (cesaro-test)
;  (= (gcd (rand) (rand)) 1))

;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

;Exercise 3.5 - Implement Monte Carlo integration as a procedure estimate-integral
;that takes as arguments a predicate P, upper and
;lower bounds x1, x2, y1, and y2 for the rectangle, and the
;number of trials to perform in order to produce the estimate.

;Consider computing the area of a region of space described
;by a predicate P(x , y) that is true for points (x , y)
;in the region and false for points not in the region.

;For example, the region contained within a circle of radius 3
;centered at (5, 7) is described by the predicate that tests
;whether (x - 5)^2 + (y - 7)^2 < 3^2.

;Note: Circle Equation (x-h)^2 + (y-k)^2 = r^2
;Where (h,k) is the center of the circle and r is the radius

;So if a point lies within the circle, then (x-h)^2 + (y-k)^2 <= r^2

;Area of a circle is given by: A = PI * r^2

;To estimate the area of the region described by such a predicate,
;begin by choosing a rectangle that contains the region.

;For example, a rectangle with diagonally opposite corners at (2, 4) and (8, 10)
;contains the circle above.

;e desired integral is the area of that portion of the rectangle that lies in the region.

;We can estimate the integral by picking, at random, points (x ; y)
;that lie in the rectangle, and testing P(x ; y) for each point
;to determine whether the point lies in the region.

;If we try this with many points, then the fraction of points that fall
;in the region should give an estimate of the proportion of
;the rectangle that lies in the region.

;Hence, multiplying this fraction by the area of the entire rectangle should produce
;an estimate of the integral.

;PI can then be approximated by dividing the area by r^2

;Your procedure should use the same monte-carlo procedure that was used to estimate PI.

;Use your estimate-integral to produce an estimate of PI by measuring the
;area of a unit circle.

;Monte-Carlo procedure repeats an experiment a given no. of times
;and returns the ratio of passes/attempts
(define (monte-carlo trials experiment)
  (define (iter trials-remaining trials-passed)
    (cond ((= trials-remaining 0)
           (/ trials-passed trials))
          ((experiment)
           (iter (- trials-remaining 1)
                 (+ trials-passed 1)))
          (else
           
           (iter (- trials-remaining 1)
                 trials-passed))))
  (iter trials 0))


(define (random-in-range low high)
(let ((range (- high low)))
(+ low (random range))))

;Lets start by creating a procedure which generates a predicate
;make-circle-predicate takes as arguments a circle center and radius
;The returned predicate will test whether a supplied point (x,y) lies within the defined circle

;(x-h)^2 + (y-k)^2 = r^2
(define (make-circle-predicate center-x center-y radius)
  (let* ((h center-x)
         (k center-y)
         (r radius))
  ;Return a lambda which takes in an x,y and checks it against the local values
  (lambda (x y) (<= (+ (expt (- x h) 2) (expt (- y k) 2)) (expt r 2)))))

;Passes our experiment and no. trials to perform to monte carlo procedure
;Expect back an approximate of the proportion of the rectangle that lies in the region
;Multiplying this by the area of the rectangle should produce an approximate integral
(define (estimate-integral P trials x1 x2 y1 y2)
  (monte-carlo trials (circle-point-test x1 x2 y1 y2 P)))
  
;Our experiment to repeat needs to generate a random point within the given range and test it against the predicate
(define (circle-point-test x1 x2 y1 y2 P)
  (let ((rect-x1 x1)
        (rect-x2 x2)
        (rect-y1 y1)
        (rect-y2 y2)
        (predicate P))
  (lambda () (P (random-in-range x1 x2) (random-in-range y1 y2)))))

;(define (cesaro-test)
;  (= (gcd (rand) (rand)) 1))

;Original estimate-pi procedure using the cesaoe test
;(define (estimate-pi trials)
;  (sqrt (/ 6 (monte-carlo trials cesaro-test))))

;Estimate PI from the returned integral
;estimate-pi takes in a circle center and radius
(define (estimate-pi circle-x circle-y circle-r trials)
  ;Create predicate, calculate r^2 and determine bounding rectangle points
  (let* ((P (make-circle-predicate circle-x circle-y circle-r))        
        (r2 (* circle-r circle-r))
        (x1 (abs(- circle-r circle-x)))
        (x2 (abs(+ circle-r circle-x)))
        (y1 (abs(- circle-r circle-y)))
        (y2 (abs(+ circle-r circle-y)))
        (area (* (abs (- x1 x2)) (abs (- y1 y2)))))
    (/ (* (estimate-integral P trials x1 x2 y1 y2) area) r2)))

;Testing -  (5,7) centered circle, with a radius of two - 1000 trials

;> (estimate-pi 5 7 3 1000)
;#e2.956
;> (estimate-pi 5 7 3 1000)
;#e3.112
;> (estimate-pi 5 7 3 1000)
;#e2.976

;Not great approximations, reading up on this - could be an issue with the random function
;Using integers instead of floats
