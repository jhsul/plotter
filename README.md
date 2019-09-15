# Plotter

## Plots and Points
This program uses two types: `plot` and `point`

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

### `(draw-plot p)`

```lisp
(draw-plot p) → image?
  p : plot? 
```

### `(add-point pnt p)`

```lisp
(add-point pnt p) → plot?
  pnt : point?
  p   : plot? 
```

### `(add-func p fn color start end (step 0.05))`

```lisp
(add-func fn p color start end (step 0.05)) → plot?
  fn    : procedure?
  p     : plot? 
  color : string?
  start : Number?
  end   : Number?
  step  : Number? 
```

### `(clear-plot p)`

```lisp
(clear-plot p) → plot?
  p : point? 
```

## Examples

```lisp
(draw-plot (add-func Q1 (lambda (x) x) "red" -1 10))
```

<p align="center">
	<img src="./examples/3x.png" alt="(* 3 x)">
</p>

```lisp
(define my-plot (make-plot (* -2 pi) (* 2 pi) -1 1 empty))
(draw-plot (add-func sin my-plot "darkgreen" (* -2 pi) (* 2 pi) 0.01))
```

<p align="center">
	<img src="./examples/sinx.png" alt="(sin x">
</p>


