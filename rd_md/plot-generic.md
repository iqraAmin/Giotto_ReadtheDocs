# `plot-generic`

Preview a Giotto spatial object


## Description

S4 generic for previewing Giotto's image and subcellular objects.


## Usage

```r
list(list("plot"), list("giottoImage,missing"))(x, y, ...)
list(list("plot"), list("giottoLargeImage,missing"))(x, y, ...)
list(list("plot"), list("giottoPolygon,missing"))(x, y, ...)
list(list("plot"), list("giottoPoints,missing"))(x, y, point_size = 0.1, feats = NULL, ...)
```


## Arguments

Argument      |Description
------------- |----------------
`x`     |     giotto image, giottoPolygon, or giottoPoints object
`y`     |     Not used.
`list()`     |     additional parameters to pass
`point_size`     |     size of points when plotting giottoPoint
`feats`     |     specific features to plot within giottoPoint object (defaults to NULL, meaning all available features)


