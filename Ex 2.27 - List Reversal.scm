#lang scheme

;Ex 2.27 - modify reverse to produce a deep-reverse procedure that takes a list
;as an argument and returns as its value the list with its elements reversed
;and with all sublists deep-reversed


;Very similar to reverse but now need to check whether
;the first element is a pair (sublist)
;if so, reverse the car (pair) and append to reversed cdr
;otherwise append the car (non-pair) to the reversed cdr 

(define (deep-reverse input)
  (cond [(null? input)input] ;Stop at end of a (sub)list
        [(pair? (car input)) ;Is car a pair?
         ;Yes -> reverse both car (sublist) and cdr (rest of list)
         ;Add reversed rest of list to reversed front
         (append (deep-reverse (cdr input)) (list (deep-reverse (car input))))]
        [else
         ;Otherwise -> only reverse cdr (rest of list)
         ;Add reversed rest of list to front
         (append (deep-reverse (cdr input)) (list (car input)))]))
