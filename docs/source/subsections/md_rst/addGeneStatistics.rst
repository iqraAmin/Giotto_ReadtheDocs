Add gene statistics
-------------------

.. link-button:: https://github.com/drieslab/Giotto/tree/suite/R/auxiliary_giotto.R#L3698
		:type: url
		:text: View Source Code
		:classes: btn-outline-primary btn-block

Last Updated: |today|

Description
~~~~~~~~~~~

adds gene statistics to the giotto object

Usage
~~~~~

::

   addGeneStatistics(
     gobject,
     expression_values = c("normalized", "scaled", "custom"),
     detection_threshold = 0,
     return_gobject = TRUE
   )

Arguments
~~~~~~~~~

+-----------------------------------+-----------------------------------+
| ``gobject``                       | giotto object                     |
+-----------------------------------+-----------------------------------+
| ``expression_values``             | expression values to use          |
+-----------------------------------+-----------------------------------+
| ``detection_threshold``           | detection threshold to consider a |
|                                   | gene detected                     |
+-----------------------------------+-----------------------------------+
| ``return_gobject``                | boolean: return giotto object     |
|                                   | (default = TRUE)                  |
+-----------------------------------+-----------------------------------+

Details
~~~~~~~

This function will add the following statistics to gene metadata:

-  nr_cells: Denotes in how many cells the gene is detected

-  per_cells: Denotes in what percentage of cells the gene is detected

-  total_expr: Shows the total sum of gene expression in all cells

-  mean_expr: Average gene expression in all cells

-  mean_expr_det: Average gene expression in cells with detectable
   levels of the gene

Value
~~~~~

giotto object if return_gobject = TRUE
