# `list_cell_metadata`

list_cell_metadata


## Description

lists the available cell metadata


## Usage

```r
list_cell_metadata(
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

names and locations of available cell metadata as data.table


