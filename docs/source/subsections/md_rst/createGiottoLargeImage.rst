createGiottoLargeImage
----------------------

.. link-button:: https://github.com/drieslab/Giotto/tree/suite/R/images.R#L254
		:type: url
		:text: View Source Code
		:classes: btn-outline-primary btn-block

Last Updated: |today|

Description
~~~~~~~~~~~

Creates a large giotto image that can be added to a Giotto subcellular
object. Generates deep copy of SpatRaster

Usage
~~~~~

::

   createGiottoLargeImage(
     raster_object,
     name = "image",
     negative_y = TRUE,
     extent = NULL,
     use_rast_ext = FALSE,
     image_transformations = NULL,
     xmax_bound = NULL,
     xmin_bound = NULL,
     ymax_bound = NULL,
     ymin_bound = NULL,
     scale_factor = 1,
     verbose = TRUE
   )

Arguments
~~~~~~~~~

+-----------------------------------+-----------------------------------+
| ``raster_object``                 | terra SpatRaster image object     |
+-----------------------------------+-----------------------------------+
| ``name``                          | name for the image                |
+-----------------------------------+-----------------------------------+
| ``negative_y``                    | Map image to negative y spatial   |
|                                   | values if TRUE. Meaning that      |
|                                   | origin is in upper left instead   |
|                                   | of lower left.                    |
+-----------------------------------+-----------------------------------+
| ``extent``                        | SpatExtent object to assign       |
|                                   | spatial extent. Takes priority    |
|                                   | unless use_rast_ext is TRUE.      |
+-----------------------------------+-----------------------------------+
| ``use_rast_ext``                  | Use extent from input raster      |
|                                   | object                            |
+-----------------------------------+-----------------------------------+
| ``image_transformations``         | vector of sequential image        |
|                                   | transformations - under           |
|                                   | construction                      |
+-----------------------------------+-----------------------------------+
| ``xmax_bound, xmin_bound, ymax_bo | assign min and max x and y values |
| u nd, ymin_bound``                | for image spatial placement       |
+-----------------------------------+-----------------------------------+
| ``scale_factor``                  | scaling of image dimensions       |
|                                   | relative to spatial coordinates   |
+-----------------------------------+-----------------------------------+
| ``verbose``                       | be verbose                        |
+-----------------------------------+-----------------------------------+

Value
~~~~~

a giottoLargeImage object
