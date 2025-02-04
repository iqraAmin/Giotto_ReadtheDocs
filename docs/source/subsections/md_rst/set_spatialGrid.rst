Set spatial grid
----------------

.. link-button:: https://github.com/drieslab/Giotto/tree/suite/R/accessors.R#L1775
		:type: url
		:text: View Source Code
		:classes: btn-outline-primary btn-block

Last Updated: |today|

Description
~~~~~~~~~~~

Function to set a spatial grid

Usage
~~~~~

::

   set_spatialGrid(
     gobject,
     spatial_grid,
     spat_unit = NULL,
     feat_type = NULL,
     name = NULL,
     verbose = TRUE,
     set_defaults = TRUE
   )

Arguments
~~~~~~~~~

+-----------------------------------+-----------------------------------+
| ``gobject``                       | giotto object                     |
+-----------------------------------+-----------------------------------+
| ``spatial_grid``                  | spatial grid object               |
+-----------------------------------+-----------------------------------+
| ``spat_unit``                     | spatial unit (e.g. "cell")        |
+-----------------------------------+-----------------------------------+
| ``feat_type``                     | feature type (e.g. "rna", "dna",  |
|                                   | "protein")                        |
+-----------------------------------+-----------------------------------+
| ``name``                          | name of spatial grid              |
+-----------------------------------+-----------------------------------+
| ``verbose``                       | be verbose                        |
+-----------------------------------+-----------------------------------+
| ``set_defaults``                  | set default spat_unit and         |
|                                   | feat_type. Change to FALSE only   |
|                                   | when expression and spat_info are |
|                                   | not expected to exist.            |
+-----------------------------------+-----------------------------------+

Value
~~~~~

giotto object

See Also
~~~~~~~~

Other spatial grid data accessor functions: ``get_spatialGrid()``

Other functions to set data in giotto object: ``get_cell_id()``,
``get_feat_id()``, ``set_NearestNetwork()``, ``set_cell_id()``,
``set_cell_metadata()``, ``set_dimReduction()``,
``set_expression_values()``, ``set_feat_id()``, ``set_feature_info()``,
``set_feature_metadata()``, ``set_giottoImage()``,
``set_polygon_info()``, ``set_spatialNetwork()``,
``set_spatial_enrichment()``, ``set_spatial_locations()``
