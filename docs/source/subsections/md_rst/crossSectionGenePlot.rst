crossSectionGenePlot
--------------------

.. link-button:: https://github.com/drieslab/Giotto/tree/suite/R/cross_section.R#L579
		:type: url
		:text: View Source Code
		:classes: btn-outline-primary btn-block

Last Updated: |today|

Description
~~~~~~~~~~~

Visualize cells and gene expression in a virtual cross section according
to spatial coordinates

Usage
~~~~~

::

   crossSectionGenePlot(
     gobject = NULL,
     spat_loc_name = "raw",
     crossSection_obj = NULL,
     name = NULL,
     spatial_network_name = "Delaunay_network",
     default_save_name = "crossSectionGenePlot",
     ...
   )

Arguments
~~~~~~~~~

+-----------------------------------+-----------------------------------+
| ``gobject``                       | giotto object                     |
+-----------------------------------+-----------------------------------+
| ``spat_loc_name``                 | name of spatial locations         |
+-----------------------------------+-----------------------------------+
| ``crossSection_obj``              | crossSection object               |
+-----------------------------------+-----------------------------------+
| ``name``                          | name of virtual cross section to  |
|                                   | use                               |
+-----------------------------------+-----------------------------------+
| ``spatial_network_name``          | name of spatial network to use    |
+-----------------------------------+-----------------------------------+
| ``default_save_name``             | default save name for saving,     |
|                                   | don't change, change save_name in |
|                                   | save_param                        |
+-----------------------------------+-----------------------------------+
| ``...``                           | parameters for spatGenePlot2D     |
+-----------------------------------+-----------------------------------+

Details
~~~~~~~

Description of parameters.

Value
~~~~~

ggplot

See Also
~~~~~~~~

``spatGenePlot3D`` and ``spatGenePlot2D``
