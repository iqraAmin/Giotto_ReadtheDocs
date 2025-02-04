Add feature metadata
--------------------

.. link-button:: https://github.com/drieslab/Giotto/tree/suite/R/auxiliary_giotto.R#L3471
		:type: url
		:text: View Source Code
		:classes: btn-outline-primary btn-block

Last Updated: |today|

Description
~~~~~~~~~~~

Adds feature metadata to the giotto object

Usage
~~~~~

::

   addFeatMetadata(
     gobject,
     feat_type = NULL,
     spat_unit = NULL,
     new_metadata,
     by_column = F,
     column_feat_ID = NULL
   )

Arguments
~~~~~~~~~

+-----------------------------------+-----------------------------------+
| ``gobject``                       | giotto object                     |
+-----------------------------------+-----------------------------------+
| ``feat_type``                     | feature type                      |
+-----------------------------------+-----------------------------------+
| ``spat_unit``                     | spatial unit                      |
+-----------------------------------+-----------------------------------+
| ``new_metadata``                  | new metadata to use               |
+-----------------------------------+-----------------------------------+
| ``by_column``                     | merge metadata based on *feat_ID* |
|                                   | column in ``fDataDT``             |
+-----------------------------------+-----------------------------------+
| ``column_feat_ID``                | column name of new metadata to    |
|                                   | use if by_column = TRUE           |
+-----------------------------------+-----------------------------------+

Details
~~~~~~~

| You can add additional feature metadata in two manners:
| 1. Provide a data.table or data.frame with feature annotations in the
  same order as the *feat_ID* column in fDataDT(gobject)
| 2. Provide a data.table or data.frame with feature annotations and
  specify which column contains the feature IDs, these feature IDs need
  to match with the *feat_ID* column in fDataDT(gobject)

Value
~~~~~

giotto object
