# `list_spatial_grids`

list_spatial_grids


## Description

return the available spatial grids that are attached to the Giotto object


## Usage

```r
list_spatial_grids(
  gobject,
  spat_unit = NULL,
  feat_type = NULL,
  return_uniques = FALSE
)
```


## Arguments

Argument      |Description
------------- |----------------
`gobject`     |     giotto object
`spat_unit`     |     spatial unit (e.g. "cell")
`feat_type`     |     feature type (e.g. "rna", "dna", "protein")
`return_uniques`     |     return unique nesting names (ignores if final object exists/is correct class)


## Value

data.table of names and locations of available spatial grids. col order matters


