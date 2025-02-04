# `get_expression_values`

Get expression values


## Description

Function to get expression values from giotto object


## Usage

```r
get_expression_values(gobject, spat_unit = NULL, feat_type = NULL, values)
```


## Arguments

Argument      |Description
------------- |----------------
`gobject`     |     giotto object
`spat_unit`     |     spatial unit (e.g. "cell")
`feat_type`     |     feature type (e.g. "rna", "dna", "protein")
`values`     |     expression values to extract (e.g. "raw", "normalized", "scaled")


## Value

expression matrix


## Seealso

Other expression accessor functions:
 [`set_expression_values`](#setexpressionvalues) 
 
 Other functions to get data from giotto object:
 [`get_NearestNetwork`](#getnearestnetwork) ,
 [`get_dimReduction`](#getdimreduction) ,
 [`get_feature_info`](#getfeatureinfo) ,
 [`get_giottoImage`](#getgiottoimage) ,
 [`get_polygon_info`](#getpolygoninfo) ,
 [`get_spatialGrid`](#getspatialgrid) ,
 [`get_spatialNetwork`](#getspatialnetwork) ,
 [`get_spatial_enrichment`](#getspatialenrichment) ,
 [`get_spatial_locations`](#getspatiallocations)


