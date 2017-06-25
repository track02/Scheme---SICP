#lang scheme

;Ex 2.55 explain why the following evaluates to quote

(car ''abracadabra)

;The single quotation mark (') is short for (quote ... )
;So the above can be read as:

(car '(quote abracadabra))

;Or as

(car (quote (quote abracadabra)))

;Resulting in car returning quote
;and cdr (abracadabra)

(cdr ''abracadabra)
