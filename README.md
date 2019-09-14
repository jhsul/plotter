# Plotter

## Plots and Points
This library uses two special types: `plot` and `point`

```lisp
;; lop is a list of points
(define-struct plot (min-x max-x min-y max-y lop))
(define-struct point (x y color))
```

There are a couple pre-defined plots to make life easier:

```lisp
(define STANDARD (make-plot -10 10 -10 10 empty))
(define Q1 (make-plot -1 10 -1 10 empty))
(define Q2 (make-plot -10 1 -1 10 empty))
(define Q3 (make-plot -10 1 -10 1 empty))
(define Q4 (make-plot -1 10 -10 1 empty))
```

