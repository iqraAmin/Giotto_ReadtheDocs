showPattern3D
-------------

.. link-button:: https://github.com/drieslab/Giotto/tree/suite/R/spatial_genes.R#L2660
		:type: url
		:text: View Source Code
		:classes: btn-outline-primary btn-block

Last Updated: |today|

Description
~~~~~~~~~~~

show patterns for 3D spatial data

Usage
~~~~~

::

   showPattern3D(
     gobject,
     spatPatObj,
     dimension = 1,
     trim = c(0.02, 0.98),
     background_color = "white",
     grid_border_color = "grey",
     show_legend = T,
     point_size = 1,
     axis_scale = c("cube", "real", "custom"),
     custom_ratio = NULL,
     x_ticks = NULL,
     y_ticks = NULL,
     z_ticks = NULL,
     show_plot = NA,
     return_plot = NA,
     save_plot = NA,
     save_param = list(),
     default_save_name = "showPattern3D"
   )

Arguments
~~~~~~~~~

+-----------------------------------+-----------------------------------+
| ``gobject``                       | giotto object                     |
+-----------------------------------+-----------------------------------+
| ``spatPatObj``                    | Output from detectSpatialPatterns |
+-----------------------------------+-----------------------------------+
| ``dimension``                     | dimension to plot                 |
+-----------------------------------+-----------------------------------+
| ``trim``                          | Trim ends of the PC values.       |
+-----------------------------------+-----------------------------------+
| ``background_color``              | background color for plot         |
+-----------------------------------+-----------------------------------+
| ``grid_border_color``             | color for grid                    |
+-----------------------------------+-----------------------------------+
| ``show_legend``                   | show legend of plot               |
+-----------------------------------+-----------------------------------+
| ``point_size``                    | adjust the point size             |
+-----------------------------------+-----------------------------------+
| ``axis_scale``                    | scale the axis                    |
+-----------------------------------+-----------------------------------+
| ``custom_ratio``                  | cutomize the scale of the axis    |
+-----------------------------------+-----------------------------------+
| ``x_ticks``                       | the tick number of x_axis         |
+-----------------------------------+-----------------------------------+
| ``y_ticks``                       | the tick number of y_axis         |
+-----------------------------------+-----------------------------------+
| ``z_ticks``                       | the tick number of z_axis         |
+-----------------------------------+-----------------------------------+
| ``show_plot``                     | show plot                         |
+-----------------------------------+-----------------------------------+
| ``return_plot``                   | return plot object                |
+-----------------------------------+-----------------------------------+
| ``save_plot``                     | directly save the plot [boolean]  |
+-----------------------------------+-----------------------------------+
| ``save_param``                    | list of saving parameters, see    |
|                                   | ``showSaveParameters``            |
+-----------------------------------+-----------------------------------+
| ``default_save_name``             | default save name for saving,     |
|                                   | don't change, change save_name in |
|                                   | save_param                        |
+-----------------------------------+-----------------------------------+

Value
~~~~~

plotly
