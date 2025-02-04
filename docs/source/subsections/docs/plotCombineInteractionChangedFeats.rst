plotCombineInteractionChangedFeats
----------------------------------

.. link-button:: https://github.com/drieslab/Giotto/tree/suite/R/spatial_interaction_visuals.R#L1697
		:type: url
		:text: View Source Code
		:classes: btn-outline-primary btn-block

Last Updated: |today|

Description
~~~~~~~~~~~

Create visualization for combined (pairwise) ICF scores

Usage
~~~~~

::

   plotCombineInteractionChangedFeats(
     gobject,
     combIcfObject,
     selected_interactions = NULL,
     selected_feat_to_feat = NULL,
     detail_plot = T,
     simple_plot = F,
     simple_plot_facet = c("interaction", "feats"),
     facet_scales = "fixed",
     facet_ncol = length(selected_feat_to_feat),
     facet_nrow = length(selected_interactions),
     colors = c("#9932CC", "#FF8C00"),
     show_plot = NA,
     return_plot = NA,
     save_plot = NA,
     save_param = list(),
     default_save_name = "plotCombineICF"
   )

Arguments
~~~~~~~~~

+-----------------------------------+-----------------------------------+
| ``gobject``                       | giotto object                     |
+-----------------------------------+-----------------------------------+
| ``combIcfObject``                 | ICFscores, output from            |
|                                   | combineInteractionChangedFeats()  |
+-----------------------------------+-----------------------------------+
| ``selected_interactions``         | interactions to show              |
+-----------------------------------+-----------------------------------+
| ``selected_feat_to_feat``         | pairwise feature combinations to  |
|                                   | show                              |
+-----------------------------------+-----------------------------------+
| ``detail_plot``                   | show detailed info in both        |
|                                   | interacting cell types            |
+-----------------------------------+-----------------------------------+
| ``simple_plot``                   | show a simplified plot            |
+-----------------------------------+-----------------------------------+
| ``simple_plot_facet``             | facet on interactions or feats    |
|                                   | with simple plot                  |
+-----------------------------------+-----------------------------------+
| ``facet_scales``                  | ggplot facet scales paramter      |
+-----------------------------------+-----------------------------------+
| ``facet_ncol``                    | ggplot facet ncol parameter       |
+-----------------------------------+-----------------------------------+
| ``facet_nrow``                    | ggplot facet nrow parameter       |
+-----------------------------------+-----------------------------------+
| ``colors``                        | vector with two colors to use     |
+-----------------------------------+-----------------------------------+
| ``show_plot``                     | show plots                        |
+-----------------------------------+-----------------------------------+
| ``return_plot``                   | return plotting object            |
+-----------------------------------+-----------------------------------+
| ``save_plot``                     | directly save the plot [boolean]  |
+-----------------------------------+-----------------------------------+
| ``save_param``                    | list of saving parameters from    |
|                                   | ``all_plots_save_function``       |
+-----------------------------------+-----------------------------------+
| ``default_save_name``             | default save name for saving,     |
|                                   | don't change, change save_name in |
|                                   | save_param                        |
+-----------------------------------+-----------------------------------+

Value
~~~~~

ggplot
