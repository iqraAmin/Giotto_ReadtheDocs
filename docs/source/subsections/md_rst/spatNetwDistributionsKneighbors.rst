spatNetwDistributionsKneighbors
-------------------------------

.. link-button:: https://github.com/drieslab/Giotto/tree/suite/R/spatial_structures.R#L124
		:type: url
		:text: View Source Code
		:classes: btn-outline-primary btn-block

Last Updated: |today|

Description
~~~~~~~~~~~

This function returns a histogram displaying the number of k-neighbors
distribution for each cell

Usage
~~~~~

::

   spatNetwDistributionsKneighbors(
     gobject,
     spat_unit = NULL,
     spatial_network_name = "spatial_network",
     hist_bins = 30,
     show_plot = NA,
     return_plot = NA,
     save_plot = NA,
     save_param = list(),
     default_save_name = "spatNetwDistributionsKneighbors"
   )

Arguments
~~~~~~~~~

+-----------------------------------+-----------------------------------+
| ``gobject``                       | Giotto object                     |
+-----------------------------------+-----------------------------------+
| ``spat_unit``                     | spatial unit                      |
+-----------------------------------+-----------------------------------+
| ``spatial_network_name``          | name of spatial network           |
+-----------------------------------+-----------------------------------+
| ``hist_bins``                     | number of binds to use for the    |
|                                   | histogram                         |
+-----------------------------------+-----------------------------------+
| ``show_plot``                     | show plot                         |
+-----------------------------------+-----------------------------------+
| ``return_plot``                   | return ggplot object              |
+-----------------------------------+-----------------------------------+
| ``save_plot``                     | directly save the plot [boolean]  |
+-----------------------------------+-----------------------------------+
| ``save_param``                    | list of saving parameters from    |
|                                   | ``all_plots_save_function``       |
+-----------------------------------+-----------------------------------+
| ``default_save_name``             | default save name for saving,     |
|                                   | alternatively change save_name in |
|                                   | save_param                        |
+-----------------------------------+-----------------------------------+

Value
~~~~~

ggplot plot
