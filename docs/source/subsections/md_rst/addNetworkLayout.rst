addNetworkLayout
----------------

.. link-button:: https://github.com/drieslab/Giotto/tree/suite/R/NN_network.R#L256
		:type: url
		:text: View Source Code
		:classes: btn-outline-primary btn-block

Last Updated: |today|

Description
~~~~~~~~~~~

Add a network layout for a selected nearest neighbor network

Usage
~~~~~

::

   addNetworkLayout(
     gobject,
     spat_unit = NULL,
     feat_type = NULL,
     nn_network_to_use = "sNN",
     network_name = "sNN.pca",
     layout_type = c("drl"),
     options_list = NULL,
     layout_name = "layout",
     return_gobject = TRUE
   )

Arguments
~~~~~~~~~

+-----------------------------------+-----------------------------------+
| ``gobject``                       | giotto object                     |
+-----------------------------------+-----------------------------------+
| ``spat_unit``                     | spatial unit                      |
+-----------------------------------+-----------------------------------+
| ``feat_type``                     | feature type                      |
+-----------------------------------+-----------------------------------+
| ``nn_network_to_use``             | kNN or sNN                        |
+-----------------------------------+-----------------------------------+
| ``network_name``                  | name of NN network to be used     |
+-----------------------------------+-----------------------------------+
| ``layout_type``                   | layout algorithm to use           |
+-----------------------------------+-----------------------------------+
| ``options_list``                  | list of options for selected      |
|                                   | layout                            |
+-----------------------------------+-----------------------------------+
| ``layout_name``                   | name for layout                   |
+-----------------------------------+-----------------------------------+
| ``return_gobject``                | boolean: return giotto object     |
|                                   | (default = TRUE)                  |
+-----------------------------------+-----------------------------------+

Details
~~~~~~~

This function creates layout coordinates based on the provided kNN or
sNN. Currently only the force-directed graph layout "drl", see
``layout_with_drl``, is implemented. This provides an alternative to
tSNE or UMAP based visualizations.

Value
~~~~~

giotto object with updated layout for selected NN network
