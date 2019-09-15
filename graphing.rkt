#lang racket
(require 2htdp/image)

(define WIDTH 300)
(define HEIGHT 300)

(define MTS (empty-scene WIDTH HEIGHT))

(define-struct plot (min-x max-x min-y max-y lop))
(define-struct point (x y color))

(define STANDARD (make-plot -10 10 -10 10 empty))
(define Q1 (make-plot -1 10 -1 10 empty))
(define Q2 (make-plot -10 1 -1 10 empty))
(define Q3 (make-plot -10 1 -10 1 empty))
(define Q4 (make-plot -1 10 -10 1 empty))

(define (draw-plot p)
  (local [
          (define x-axis-offset (* (plot-max-y p)
                                   (/ HEIGHT (- (plot-max-y p)
                                                (plot-min-y p)))))
          (define y-axis-offset (* (abs (plot-min-x p))
                                   (/ WIDTH (- (plot-max-x p)
                                               (plot-min-x p)))))
                            
          (define (draw-x-axis p bg)
            (cond
              [(or (> (plot-min-y p) 0)
                   (< (plot-max-y p) 0)) bg]
              [else
               (place-image (rectangle WIDTH 1 "solid" "black")
                            (/ WIDTH 2)
                            x-axis-offset
                            bg)]))

          (define (draw-y-axis p bg)
            (cond
              [(or (> (plot-min-x p) 0)
                   (< (plot-max-x p) 0)) (square 20 "solid" "red")]
              [else
               (place-image (rectangle 1 HEIGHT "solid" "black")
                            y-axis-offset
                            (/ HEIGHT 2)
                            bg)]))
          (define (draw-point pnt p bg)
            (cond
              [(or (> (point-x pnt) (plot-max-x p))
                   (< (point-x pnt) (plot-min-x p))
                   (> (point-y pnt) (plot-max-y p))
                   (< (point-y pnt) (plot-min-y p))) bg]
              [else
               (place-image (circle 2 "solid" (point-color pnt))
                            (+ y-axis-offset (* (point-x pnt) (/ WIDTH (- (plot-max-x p)
                                                                          (plot-min-x p)))))
                            (- x-axis-offset (* (point-y pnt) (/ HEIGHT ( - (plot-max-y p)
                                                                            (plot-min-y p)))))
                            bg)]))]
                            
    (foldl (lambda (pnt bg) (draw-point pnt p bg))
           (draw-x-axis p
                        (draw-y-axis p MTS))
           (plot-lop p))))

(define (add-point pnt p)
  (make-plot
   (plot-min-x p)
   (plot-max-x p)
   (plot-min-y p)
   (plot-max-y p)
   (cons pnt (plot-lop p))))

(define (add-func fn p color start end (step 0.05))
  (local [(define lop (build-list (exact-floor (/ (- end start) step))
                                  (lambda (x)
                                    (make-point (+ (* x step) start)
                                                (fn (+ (* x step) start))
                                                color)
                                    )))]
    (foldl add-point
           p
           lop)))

(define (clear-plot p)
  (make-plot
   (plot-min-x p)
   (plot-max-x p)
   (plot-min-y p)
   (plot-max-y p)
   empty))
