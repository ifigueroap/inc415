#lang racket

(require rackunit)

;; Archivo -> Package Manager -> Install -> "quickcheck"
(require quickcheck)
(require rackunit/quickcheck)

;;
;; Defina sus funciones en este archivo. No modifique el contenido de los tests!
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (my-member v l)
  (cond
    [(empty? l) #f]
    [else (or (equal? v (first l)) (my-member v (rest l)))]))

(module+ test
  
  (define (member-check n l)    
    (if (not (equal? (member n l) #f)) #t #f))  
  
  (check-false (my-member "a" '()))
  (check-false (my-member 1 '()))
  (check-false (my-member '(1 2 3) '()))
  (check-true (my-member "a" '(1 2 "a")))
  (check-true (my-member "a" '(1 "a" 2)))  
  (check-true (my-member '(1 2 3) '(() (1 2 3) (1))))
  (check-property (property ([l (arbitrary-list arbitrary-integer)]
                             [n arbitrary-integer])
                            (equal? (my-member n l) (member-check n l)))))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (my-length l) #f)  

(module+ test
  (check-equal? (my-length '()) 0)
  (check-equal? (my-length '(1)) 1)
  (check-equal? (my-length '("a" "b" '())) 3)
  (check-equal? (my-length '(1 (2 3 (4 5)) 5 (7 8))) 4)
  (check-property (property ([l (arbitrary-list arbitrary-natural)])
                            (= (my-length l) (length l)))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (my-filter p l) #f)

(module+ test
  
  (check-equal? (my-filter odd? '()) '())
  (check-equal? (my-filter even? '()) '())
  (check-equal? (my-filter odd? '(1 2 3 4 5 6 7 8 9 10)) '(1 3 5 7 9))
  (check-equal? (my-filter even? '(1 2 3 4 5 6 7 8 9 10)) '(2 4 6 8 10))
  (check-equal? (my-filter list? '(1 (2) (3 4) 5 6 (7) () 8 (9 10))) '((2) (3 4) (7) () (9 10)))
  (check-property (property ([l (arbitrary-list arbitrary-integer)]
                             [pred (choose-one-of (list odd? even? zero? positive? negative?))])
                            (equal? (filter pred l) (my-filter pred l)))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; mejor retornar #f si el elemento no esta, independiente de si k > largo l

(define (my-list-ref k l) #f)

(module+ test
  (check-exn exn:fail? (lambda () (my-list-ref 1 '())))
  (check-exn exn:fail? (lambda () (my-list-ref 2 '())))
  (check-exn exn:fail? (lambda () (my-list-ref 10 '())))
  (check-equal? (my-list-ref 1 '(1)) 1)
  (check-equal? (my-list-ref 1 '(1 2)) 1)
  (check-equal? (my-list-ref 1 '(1 2 3)) 1)  
  (check-equal? (my-list-ref 2 '(1 2)) 2)
  (check-equal? (my-list-ref 2 '(1 2 3)) 2)
  (check-property
   (property ([l (arbitrary-list arbitrary-boolean)]
              [k arbitrary-natural])
             (==> (and (>= k 1) (<= k (length l)))
                  (equal? (append (take l (- k 1))
                                  (list (my-list-ref k l))
                                  (drop l k))
                          l)))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (list-max l) #f)  

(module+ test
  (check-exn exn:fail? (lambda () (list-max '())))
  (check-equal? (list-max '(1 2 3)) 3)
  (check-equal? (list-max '(3 2 1)) 3)
  (check-equal? (list-max '(1 1 1)) 1)
  (check-equal? (list-max '(-3 -2 -1)) -1)
  (check-property
   (property ([l (arbitrary-list arbitrary-integer)])
             (==> (not (empty? l))
                  (let ([max-l (list-max l)])
                    (andmap (lambda (x) (<= x max-l)) l))))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (list-min l) #f)
  
(module+ test
  (check-exn exn:fail? (lambda () (list-min '())))
  (check-equal? (list-min '(1 2 3)) 1)
  (check-equal? (list-min '(3 2 1)) 1)
  (check-equal? (list-min '(1 1 1)) 1)
  (check-equal? (list-min '(-3 -2 -1)) -3)
  (check-property
   (property ([l (arbitrary-list arbitrary-integer)])
             (==> (not (empty? l))
                  (let ([min-l (list-min l)])
                    (andmap (lambda (x) (>= x min-l)) l))))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (my-reverse l) #f)  

(module+ test
  (check-equal? (my-reverse '()) '())
  (check-equal? (my-reverse '(1)) '(1))
  (check-equal? (my-reverse '(1 2)) '(2 1))
  (check-equal? (my-reverse '("a" "b" "c" "d" "e"))
                '("e" "d" "c" "b" "a"))
  (check-equal? (my-reverse '("a" (2 "c") 3 ("d") 5))
                '(5 ("d") 3 (2 "c") "a"))  
  (check-property
   (property ([l (arbitrary-list arbitrary-printable-ascii-string)])
             (equal? (my-reverse (my-reverse l)) l)))
  (check-property
   (property ([l (arbitrary-list arbitrary-printable-ascii-string)])
             (equal? (my-reverse l) (reverse l)))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (my-take n l) #f)  

(module+ test
  (check-exn exn:fail? (lambda () (my-take 1 '())))
  (check-exn exn:fail? (lambda () (my-take 3 '(1 2))))
  (check-exn exn:fail? (lambda () (my-take 4 '(1 2))))
  (check-equal? (my-take 0 '()) '())
  (check-equal? (my-take 0 '(1)) '())
  (check-equal? (my-take 0 '(1 2 3 4 5 6 7)) '())    
  (check-equal? (my-take 2 '(1 2)) '(1 2))
  (check-equal? (my-take 1 '(1 2 3 4 5 6 7)) '(1))
  (check-equal? (my-take 2 '(1 2 3 4 5 6 7)) '(1 2))
  (check-equal? (my-take 7 '(1 2 3 4 5 6 7)) '(1 2 3 4 5 6 7))
  (check-equal? (my-take 3 '(1 #f (1 #f (a b)) 0 0)) '(1 #f (1 #f (a b))))
  
  (check-property
   (property ([l (arbitrary-list arbitrary-boolean)])
             (equal? (my-take 0 l) '())))
  
  (check-property
   (property ([l (arbitrary-list arbitrary-boolean)])
             (equal? (my-take (length l) l) l)))
  
  (check-property
   (property ([l (arbitrary-list arbitrary-boolean)]
              [k arbitrary-natural])
             (==> (and (>= k 0) (<= k (length l)))
                  (equal? (append (my-take k l) (drop l k)) l)))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (my-drop n l) #f)

(module+ test
  (check-exn exn:fail? (lambda () (my-drop 1 '())))
  (check-exn exn:fail? (lambda () (my-drop 3 '(1 2))))
  (check-exn exn:fail? (lambda () (my-drop 4 '(1 2))))
  (check-equal? (my-drop 0 '()) '())
  (check-equal? (my-drop 0 '(1)) '(1))
  (check-equal? (my-drop 0 '(1 2 3 4 5 6 7)) '(1 2 3 4 5 6 7))
  (check-equal? (my-drop 2 '(1 2)) '())
  (check-equal? (my-drop 1 '(1 2 3 4 5 6 7)) '(2 3 4 5 6 7))
  (check-equal? (my-drop 2 '(1 2 3 4 5 6 7)) '(3 4 5 6 7))
  (check-equal? (my-drop 7 '(1 2 3 4 5 6 7)) '())
  (check-equal? (my-drop 3 '(1 #f (1 #f (a b)) 0 0)) '(0 0))
  
  (check-property
   (property ([l (arbitrary-list arbitrary-boolean)])
             (equal? (my-drop 0 l) l)))
  
  (check-property
   (property ([l (arbitrary-list arbitrary-boolean)])
             (equal? (my-drop (length l) l) '())))
  
  (check-property
   (property ([l (arbitrary-list arbitrary-boolean)]
              [k arbitrary-natural])
             (==> (and (>= k 0) (<= k (length l)))
                  (equal? (append (take l k) (my-drop k l)) l)))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (rango l a b) #f)  

(module+ test
  (check-exn exn:fail? (lambda () (rango '() 1 2)))
  (check-exn exn:fail? (lambda () (rango '(1) 1 2)))
  (check-exn exn:fail? (lambda () (rango '(1) 2 3)))
  (check-exn exn:fail? (lambda () (rango '(1 2 3 4) 2 5)))
  (check-equal? (rango '(1) 1 1) '(1))
  (check-equal? (rango '(1 2) 1 1) '(1))
  (check-equal? (rango '(1 2) 1 2) '(1 2))
  (check-equal? (rango '(1 2 3 4) 2 4) '(2 3 4))
  
  (check-property
   (property ([l (arbitrary-list arbitrary-boolean)]              
              [k arbitrary-natural])
             (==> (and (>= k 1) (< k (length l)))
                  (equal? l (append (rango l 1 k)
                                    (rango l (+ k 1) (length l))))))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (my-append l1 l2) #f)  

(module+ test
  (check-equal? (my-append '() '()) '())
  (check-equal? (my-append '(1) '()) '(1))
  (check-equal? (my-append '() '(1)) '(1))
  (check-equal? (my-append '(1) '(2)) '(1 2))
  (check-equal? (my-append '(1) '(2 3)) '(1 2 3))
  (check-equal? (my-append '(1 2) '(3 4 5)) '(1 2 3 4 5))
  
  (check-property
   (property ([l1 (arbitrary-list arbitrary-integer)]
              [l2 (arbitrary-list arbitrary-boolean)])
             (equal? (my-append l1 l2) (reverse (my-append (reverse l2)
                                                           (reverse l1))))))
  
  (check-property
   (property ([l (arbitrary-list arbitrary-printable-ascii-string)]
              [k arbitrary-natural])
             (==> (and (>= k 0) (<= k (length l)))
                  (equal? l (my-append (take l k) (drop l k)))))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (list-sub l) #f)  

(module+ test
  (check-equal? (list-sub '()) 0)
  (check-equal? (list-sub '(1)) (- 1 0))
  (check-equal? (list-sub '(1 2)) (- 1 (- 2 0)))
  (check-equal? (list-sub '(1 2 3)) (- 1 (- 2 (- 3 0)))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (list-add l) #f)
  
(module+ test
  
  (check-equal? (list-add '()) 0)
  (check-equal? (list-add '(1)) (+ 1 0))
  (check-equal? (list-add '(1 2)) (+ 1 (+ 2 0)))
  (check-equal? (list-add '(1 2 3)) (+ 1 (+ 2 (+ 3 0))))
  
  (check-property
   (property ([l (arbitrary-list arbitrary-integer)]
              [k arbitrary-natural])
             (==> (and (>= k 1) (<= k (length l)))
                  (= (list-add l) (+ (list-add (take l k))
                                     (list-add (drop l k))))))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (list-mult l) #f)  

(module+ test
  (check-equal? (list-mult '()) 1)
  (check-equal? (list-mult '(1)) (* 1 1))
  (check-equal? (list-mult '(1 2)) (* 1 (* 2 1)))
  (check-equal? (list-mult '(1 2 3)) (* 1 (* 2 (* 3 1))))
  
  (check-property
   (property ([l (arbitrary-list arbitrary-integer)]
              [k arbitrary-natural])
             (==> (and (>= k 1) (<= k (length l)))
                  (= (list-mult l) (* (list-mult (take l k))
                                      (list-mult (drop l k))))))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (my-fold f l v) #f)

(module+ test
  
  (check-property   
   (property ([l (arbitrary-list arbitrary-integer)])             
             (equal? (my-fold + l 0)
                     (foldr + 0 l))))
  
  (check-property   
   (property ([l (arbitrary-list arbitrary-integer)])             
             (equal? (my-fold * l 1)
                     (foldr * 1 l))))
  
  (check-property   
   (property ([l (arbitrary-list arbitrary-integer)])             
             (equal? (my-fold - l 0)
                     (foldr - 0 l)))))




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (list-square l) #f)

(module+ test
  (check-equal? (list-square '()) '())
  (check-equal? (list-square '(1)) '(1))
  (check-equal? (list-square '(2)) '(4))
  (check-equal? (list-square '(3)) '(9))
  (check-equal? (list-square '(1 2 3)) '(1 4 9))
  
  (check-property
   (property ([l (arbitrary-list arbitrary-integer)]
              [k arbitrary-natural])
             (==> (and (>= k 1) (<= k (length l)))
                  (equal? (list-square l)
                          (append (list-square (take l k))
                                  (list-square (drop l k)))))))
  
  (check-property
   (property ([l (arbitrary-list arbitrary-integer)])
             (equal? (list-square l) (map sqr l)))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (list-halve l) #f)  

(module+ test
  (check-equal? (list-halve '()) '())
  (check-equal? (list-halve '(1)) (list (/ 1 2)))
  (check-equal? (list-halve '(2)) (list (/ 2 2)))
  (check-equal? (list-halve '(3)) (list (/ 3 2)))
  (check-equal? (list-halve '(1 2 3)) (list (/ 1 2) (/ 2 2) (/ 3 2)))
  
  (check-property
   (property ([l (arbitrary-list arbitrary-integer)]
              [k arbitrary-natural])
             (==> (and (>= k 1) (<= k (length l)))
                  (equal? (list-halve l)
                          (append (list-halve (take l k))
                                  (list-halve (drop l k)))))))
  
  (check-property
   (property ([l (arbitrary-list arbitrary-integer)])
             (equal? (list-halve l) (map (lambda (x) (/ x 2)) l)))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (my-map f l) #f)  

(module+ test
  
  (check-property
   (property ([l (arbitrary-list arbitrary-integer)])
             (equal? (map sqr l) (my-map sqr l))))
  
  (check-property
   (property ([l (arbitrary-list arbitrary-integer)])
             (let ([halve (lambda (x) (/ x 2))])
               (equal? (map halve l) (my-map halve l))))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (my-flatten l) #f)
  
(module+ test
  (check-equal? (my-flatten '()) '())
  (check-equal? (my-flatten '( () )) '())
  (check-equal? (my-flatten '( ( () ) () )) '())
  (check-equal? (my-flatten '(1 2 3 4 5)) '(1 2 3 4 5))
  (check-equal? (my-flatten '((1) (2) (3) (4) (5))) '(1 2 3 4 5))
  (check-equal? (my-flatten '(1 (2 3) (4) 5 (6 (7 (8))))) '(1 2 3 4 5 6 7 8))
  (check-property
   (property ([l (arbitrary-list (arbitrary-list arbitrary-integer))])
             (equal? (my-flatten l) (flatten l)))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (deep-reverse l) #f)  

(module+ test
  (check-equal? (deep-reverse '()) '())
  (check-equal? (deep-reverse '( () )) '( () ))
  (check-equal? (deep-reverse '( ( () ) () )) '( () ( () )))
  (check-equal? (deep-reverse '(1 2 3 4 5)) '(5 4 3 2 1))
  (check-equal? (deep-reverse '((1) (2) (3) (4) (5))) '((5) (4) (3) (2) (1)))
  (check-equal? (deep-reverse '(1 (2 3) (4) 5 (6 (7 (8)))))
                '((((8) 7) 6) 5 (4) (3 2) 1))
  (check-property
   (property ([l (arbitrary-list (arbitrary-list arbitrary-boolean))])
             (equal? (deep-reverse (deep-reverse l)) l)))
  
  (check-property
   (property ([l (arbitrary-list (arbitrary-list arbitrary-integer))])
             (equal? (flatten (deep-reverse l)) (reverse (flatten l)))))) 
