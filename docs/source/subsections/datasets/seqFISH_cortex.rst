=============================
SeqFish+ Mouse Cortex Example
=============================

:Date: 2022-09-16

Start Giotto
============

.. container:: cell

   .. code:: r
      
      # Ensure Giotto Suite is installed.
      if(!"Giotto" %in% installed.packages()) {
        devtools::install_github("drieslab/Giotto@suite")
      }

      # Ensure GiottoData, a small, helper module for tutorials, is installed.
      if(!"GiottoData" %in% installed.packages()) {
        devtools::install_github("drieslab/GiottoData")
      }
      library(Giotto)
      # Ensure the Python environment for Giotto has been installed.
      genv_exists = checkGiottoEnvironment()
      if(!genv_exists){
        # The following command need only be run once to install the Giotto environment.
        installGiottoEnvironment()
      }

Dataset Explanation
===================

Several fields - containing 100’s of cells - in the mouse cortex and
subventricular zone were imaged for seqFISH+. The coordinates of the
cells within each field are independent of each other, so in order to
visualize and process all cells together imaging fields will be stitched
together by providing x and y-offset values specific to each field.
These offset values are known or estimates based on the original raw
image: 

.. image:: /images/images_pkgdown/SeqFish_mouse_cortex/cortex_svz_location_fields.png
   :width: 50.0%

Download Data
=============

.. container:: cell

   .. code:: r
      
      library(GiottoData)

      my_working_dir = '/path/to/directory/'
      getSpatialDataset(dataset = 'seqfish_SS_cortex', directory = my_working_dir, method = 'wget')

Part 1. Giotto Instructions and Preparation
===========================================

.. container:: cell

   .. code:: r

      #  set Giotto instructions
      instrs = createGiottoInstructions(save_plot = FALSE, 
                                        show_plot = TRUE,
                                        save_dir = my_working_dir, 
                                        python_path = NULL)

      # create giotto object from provided paths ####
      expr_path = paste0(my_working_dir, "cortex_svz_expression.txt")
      loc_path = paste0(my_working_dir, "cortex_svz_centroids_coord.txt")
      meta_path = paste0(my_working_dir, "cortex_svz_centroids_annot.txt")
      #This dataset contains multiple field of views which need to be stitched together
      # first merge location and additional metadata
      SS_locations = data.table::fread(loc_path)
      cortex_fields = data.table::fread(meta_path)
      SS_loc_annot = data.table::merge.data.table(SS_locations, cortex_fields, by = 'ID')
      SS_loc_annot[, ID := factor(ID, levels = paste0('cell_',1:913))]
      data.table::setorder(SS_loc_annot, ID)
      # create file with offset information
      my_offset_file = data.table::data.table(field = c(0, 1, 2, 3, 4, 5, 6),
                                              x_offset = c(0, 1654.97, 1750.75, 1674.35, 675.5, 2048, 675),
                                              y_offset = c(0, 0, 0, 0, -1438.02, -1438.02, 0))
      # create a stitch file
      stitch_file = stitchFieldCoordinates(location_file = SS_loc_annot,
                                           offset_file = my_offset_file,
                                           cumulate_offset_x = T,
                                           cumulate_offset_y = F,
                                           field_col = 'FOV',
                                           reverse_final_x = F,
                                           reverse_final_y = T)
      stitch_file = stitch_file[,.(ID, X_final, Y_final)]
      stitch_file$ID <- as.character(stitch_file$ID)
      my_offset_file = my_offset_file[,.(field, x_offset_final, y_offset_final)]

Part 2: Create Giotto object & process data
===========================================

.. container:: cell

   .. code:: r

      # create Giotto object
      SS_seqfish <- createGiottoObject(expression = expr_path,
                                       spatial_locs = stitch_file,
                                       offset_file = my_offset_file,
                                       instructions = instrs)
      # add additional annotation if wanted
      SS_seqfish = addCellMetadata(SS_seqfish,
                                   new_metadata = cortex_fields,
                                   by_column = T,
                                   column_cell_ID = 'ID')
      # subset data to the cortex field of views
      cell_metadata = pDataDT(SS_seqfish)
      cortex_cell_ids = cell_metadata[FOV %in% 0:4]$cell_ID
      SS_seqfish = subsetGiotto(SS_seqfish, cell_ids = cortex_cell_ids)
      # filter
      SS_seqfish <- filterGiotto(gobject = SS_seqfish,
                                 expression_threshold = 1,
                                 feat_det_in_min_cells = 10,
                                 min_det_feats_per_cell = 10,
                                 expression_values = c('raw'),
                                 verbose = T)
      # normalize
      SS_seqfish <- normalizeGiotto(gobject = SS_seqfish, scalefactor = 6000, verbose = T)
      # add gene & cell statistics
      SS_seqfish <- addStatistics(gobject = SS_seqfish)
      # adjust expression matrix for technical or known variables
      SS_seqfish <- adjustGiottoMatrix(gobject = SS_seqfish, expression_values = c('normalized'),
                                       covariate_columns = c('nr_feats', 'total_expr'),
                                       return_gobject = TRUE,
                                       update_slot = c('custom'))
      # visualize
      spatPlot(gobject = SS_seqfish)

.. image:: /images/images_pkgdown/SeqFish_mouse_cortex/0-spatPlot2D.png
   :width: 50.0%

Part 3: Dimension Reduction
===========================

.. container:: cell

   .. code:: r

      ## highly variable features (HVF)
      SS_seqfish <- calculateHVF(gobject = SS_seqfish)

.. image:: /images/images_pkgdown/SeqFish_mouse_cortex/1-HVFplot.png
   :width: 50.0%

.. container:: cell

   .. code:: r

      ## select genes based on highly variable features and gene statistics, both found in feature (gene) metadata
      gene_metadata = fDataDT(SS_seqfish)
      featgenes = gene_metadata[hvf == 'yes' & perc_cells > 4 & mean_expr_det > 0.5]$feat_ID
      ## run PCA on expression values (default)
      SS_seqfish <- runPCA(gobject = SS_seqfish, genes_to_use = featgenes, scale_unit = F, center = F)
      screePlot(SS_seqfish)

.. image:: /images/images_pkgdown/SeqFish_mouse_cortex/2-screePlot.png
   :width: 50.0%

.. container:: cell

   .. code:: r

      plotPCA(gobject = SS_seqfish)

.. image:: /images/images_pkgdown/SeqFish_mouse_cortex/3-PCA.png
   :width: 50.0%

.. container:: cell

   .. code:: r

      SS_seqfish <- runUMAP(SS_seqfish, dimensions_to_use = 1:15, n_threads = 10)
      plotUMAP(gobject = SS_seqfish)

.. image:: /images/images_pkgdown/SeqFish_mouse_cortex/4-UMAP.png
   :width: 50.0%

.. container:: cell

   .. code:: r

      SS_seqfish <- runtSNE(SS_seqfish, dimensions_to_use = 1:15)
      plotTSNE(gobject = SS_seqfish)

.. image:: /images/images_pkgdown/SeqFish_mouse_cortex/5-tSNE.png
   :width: 50.0%

Part 4: Cluster
===============

.. container:: cell

   .. code:: r

      ## sNN network (default)
      SS_seqfish <- createNearestNetwork(gobject = SS_seqfish,
                                         dimensions_to_use = 1:15,
                                         k = 15)
      ## Leiden clustering
      SS_seqfish <- doLeidenCluster(gobject = SS_seqfish,
                                    resolution = 0.4,
                                    n_iterations = 1000)
      plotUMAP(gobject = SS_seqfish,
               cell_color = 'leiden_clus',
               show_NN_network = T,
               point_size = 2.5)

.. image:: /images/images_pkgdown/SeqFish_mouse_cortex/6-UMAP.png
   :width: 50.0%

.. container:: cell

   .. code:: r

      ## Leiden subclustering for specified clusters
      SS_seqfish = doLeidenSubCluster(gobject = SS_seqfish, 
                                      cluster_column = 'leiden_clus',
                                      resolution = 0.2, k_neighbors = 10,
                                      pca_param = list(expression_values = 'normalized', scale_unit = F),
                                      nn_param = list(dimensions_to_use = 1:5),
                                      selected_clusters = c(5, 6, 7),
                                      name = 'sub_leiden_clus_select')
      ## set colors for clusters
      subleiden_order = c( 1.1, 2.1, 3.1, 4.1, 5.1, 5.2, 
                           6.1, 6.2, 7.1,  7.2, 8.1, 9.1)
      subleiden_colors = Giotto:::getDistinctColors(length(subleiden_order)) 
      names(subleiden_colors) = subleiden_order
      plotUMAP(gobject = SS_seqfish,
               cell_color = 'sub_leiden_clus_select', cell_color_code = subleiden_colors,
               show_NN_network = T, point_size = 2.5, show_center_label = F, 
               legend_text = 12, legend_symbol_size = 3)

.. image:: /images/images_pkgdown/SeqFish_mouse_cortex/10-UMAP.png
   :width: 50.0%

.. container:: cell

   .. code:: r

      ## show cluster relationships
      showClusterHeatmap(gobject = SS_seqfish, cluster_column = 'sub_leiden_clus_select',
                         row_names_gp = grid::gpar(fontsize = 9), column_names_gp = grid::gpar(fontsize = 9))

.. image:: /images/images_pkgdown/SeqFish_mouse_cortex/11-showClusterHeatmap.png
   :width: 50.0%

The following step requires the installation of {ggdendro}.

.. container:: cell

   .. code:: r

      # install.packages('ggdendro')
      library(ggdendro)
      showClusterDendrogram(SS_seqfish, h = 0.5, rotate = T, cluster_column = 'sub_leiden_clus_select')

.. image:: /images/images_pkgdown/SeqFish_mouse_cortex/12-showClusterDendrogram.png
   :width: 50.0%

Part 5: Visualize Spatial and Expression Space
==============================================

.. container:: cell

   .. code:: r

      # expression and spatial
      spatDimPlot(gobject = SS_seqfish, cell_color = 'sub_leiden_clus_select', 
                  cell_color_code = subleiden_colors,
                  dim_point_size = 2, spat_point_size = 2)

.. image:: /images/images_pkgdown/SeqFish_mouse_cortex/13-spatDimPlot2D.png
   :width: 50.0%

.. container:: cell

   .. code:: r

      # selected groups and provide new colors
      groups_of_interest = c(6.1, 6.2, 7.1, 7.2)
      group_colors = c('red', 'green', 'blue', 'purple'); names(group_colors) = groups_of_interest
      spatDimPlot(gobject = SS_seqfish, cell_color = 'sub_leiden_clus_select', 
                  dim_point_size = 2, spat_point_size = 2,
                  select_cell_groups = groups_of_interest, cell_color_code = group_colors)

.. image:: /images/images_pkgdown/SeqFish_mouse_cortex/14-spatDimPlot2D.png
   :width: 50.0%

Part 6: Cell Type Marker Gene Detection
=======================================

.. container:: cell

   .. code:: r

      ## gini 
      gini_markers_subclusters = findMarkers_one_vs_all(gobject = SS_seqfish,
                                                        method = 'gini',
                                                        expression_values = 'normalized',
                                                        cluster_column = 'sub_leiden_clus_select',
                                                        min_feats = 20,
                                                        min_expr_gini_score = 0.5,
                                                        min_det_gini_score = 0.5)
      topgenes_gini = gini_markers_subclusters[, head(.SD, 2), by = 'cluster']
      ## violin plot
      violinPlot(SS_seqfish, feats = unique(topgenes_gini$feats), cluster_column = 'sub_leiden_clus_select',
                 strip_text = 8, strip_position = 'right', cluster_custom_order = unique(topgenes_gini$cluster))

.. image:: /images/images_pkgdown/SeqFish_mouse_cortex/15-violinPlot.png
   :width: 50.0%

.. container:: cell

   .. code:: r

      # cluster heatmap
      topgenes_gini2 = gini_markers_subclusters[, head(.SD, 6), by = 'cluster']
      plotMetaDataHeatmap(SS_seqfish, selected_feats = unique(topgenes_gini2$feats), 
                          custom_feat_order = unique(topgenes_gini2$feats),
                          custom_cluster_order = unique(topgenes_gini2$cluster),
                          metadata_cols = c('sub_leiden_clus_select'), x_text_size = 10, y_text_size = 10)

.. image:: /images/images_pkgdown/SeqFish_mouse_cortex/16-plotMetaDataHeatmap.png
   :width: 50.0%

Part 7: Cell Type Annotation
============================

.. container:: cell

   .. code:: r

      ## general cell types
      ## create vector with names
      clusters_cell_types_cortex = c('L6 eNeuron', 'L4 eNeuron', 'L2/3 eNeuron', 'L5 eNeuron', 
                                     'Lhx6 iNeuron', 'Adarb2 iNeuron', 
                                     'endothelial', 'mural',
                                     'OPC','Olig',
                                     'astrocytes', 'microglia')
      names(clusters_cell_types_cortex) = c(1.1, 2.1, 3.1, 4.1,
                                            5.1, 5.2,
                                            6.1, 6.2, 
                                            7.1, 7.2,
                                            8.1, 9.1)
      SS_seqfish = annotateGiotto(gobject = SS_seqfish, annotation_vector = clusters_cell_types_cortex,
                                  cluster_column = 'sub_leiden_clus_select', name = 'cell_types')
      # cell type order and colors
      cell_type_order = c('L6 eNeuron', 'L5 eNeuron', 'L4 eNeuron', 'L2/3 eNeuron',
                          'astrocytes', 'Olig', 'OPC','Adarb2 iNeuron', 'Lhx6 iNeuron',
                          'endothelial', 'mural', 'microglia')
      cell_type_colors = subleiden_colors
      names(cell_type_colors) = clusters_cell_types_cortex[names(subleiden_colors)]
      cell_type_colors = cell_type_colors[cell_type_order]
      ## violin plot
      violinPlot(gobject = SS_seqfish, feats = unique(topgenes_gini$feats),
                 strip_text = 7, strip_position = 'right', 
                 cluster_custom_order = cell_type_order,
                 cluster_column = 'cell_types', color_violin = 'cluster')

.. image:: /images/images_pkgdown/SeqFish_mouse_cortex/17-violinPlot.png
   :width: 50.0%

.. container:: cell

   .. code:: r

      # co-visualization
      spatDimPlot(gobject = SS_seqfish, cell_color = 'cell_types',
                  dim_point_size = 2, spat_point_size = 2, dim_show_cluster_center = F, dim_show_center_label = T)

.. image:: /images/images_pkgdown/SeqFish_mouse_cortex/18-spatDimPlot2D.png
   :width: 50.0%

.. container:: cell

   .. code:: r

      ## heatmap genes vs cells
      gini_markers_subclusters[, cell_types := clusters_cell_types_cortex[cluster] ]
      gini_markers_subclusters[, cell_types := factor(cell_types, cell_type_order)]
      data.table::setorder(gini_markers_subclusters, cell_types)
      plotHeatmap(gobject = SS_seqfish,
                  feats = gini_markers_subclusters[, head(.SD, 3), by = 'cell_types']$feats, 
                  feat_order = 'custom',
                  feat_custom_order = unique(gini_markers_subclusters[, head(.SD, 3), by = 'cluster']$feats),
                  cluster_column = 'cell_types', cluster_order = 'custom',
                  cluster_custom_order = unique(gini_markers_subclusters[, head(.SD, 3), by = 'cell_types']$cell_types), 
                  legend_nrows = 2)

.. image:: /images/images_pkgdown/SeqFish_mouse_cortex/19-plotHeatmap.png
   :width: 50.0%

.. container:: cell

   .. code:: r

      plotHeatmap(gobject = SS_seqfish,
                  cluster_color_code = cell_type_colors,
                  feats = gini_markers_subclusters[, head(.SD, 6), by = 'cell_types']$feats,
                  feat_order = 'custom',
                  feat_label_selection = gini_markers_subclusters[, head(.SD, 2), by = 'cluster']$feats,
                  feat_custom_order = unique(gini_markers_subclusters[, head(.SD, 6), by = 'cluster']$feats),
                  cluster_column = 'cell_types', cluster_order = 'custom',
                  cluster_custom_order = unique(gini_markers_subclusters[, head(.SD, 3), by = 'cell_types']$cell_types), 
                  legend_nrows = 2)

.. image:: /images/images_pkgdown/SeqFish_mouse_cortex/20-plotHeatmap.png
   :width: 50.0%

Part 8: Spatial Grid
====================

.. container:: cell

   .. code:: r

      SS_seqfish <- createSpatialGrid(gobject = SS_seqfish,
                                      sdimx_stepsize = 500,
                                      sdimy_stepsize = 500,
                                      minimum_padding = 50)
      spatPlot(gobject = SS_seqfish, show_grid = T, point_size = 1.5)

.. image:: /images/images_pkgdown/SeqFish_mouse_cortex/21-spatPlot2D.png
   :width: 50.0%

Part 9: Spatial Network
=======================

.. container:: cell

   .. code:: r

      ## delaunay network: stats + creation
      plotStatDelaunayNetwork(gobject = SS_seqfish, maximum_distance = 400, save_plot = F)
      SS_seqfish = createSpatialNetwork(gobject = SS_seqfish, minimum_k = 2, maximum_distance_delaunay = 400)
      ## create spatial networks based on k and/or distance from centroid
      SS_seqfish <- createSpatialNetwork(gobject = SS_seqfish, method = 'kNN', k = 5, name = 'spatial_network')
      SS_seqfish <- createSpatialNetwork(gobject = SS_seqfish, method = 'kNN', k = 10, name = 'large_network')
      SS_seqfish <- createSpatialNetwork(gobject = SS_seqfish, method = 'kNN', k = 100,
                                         maximum_distance_knn = 200, minimum_k = 2, name = 'distance_network')
      ## visualize different spatial networks on first field (~ layer 1)
      cell_metadata = pDataDT(SS_seqfish)
      field1_ids = cell_metadata[FOV == 0]$cell_ID
      subSS_seqfish = subsetGiotto(SS_seqfish, cell_ids = field1_ids)
      spatPlot(gobject = subSS_seqfish, show_network = T,
               network_color = 'blue', spatial_network_name = 'Delaunay_network',
               point_size = 2.5, cell_color = 'cell_types')

.. image:: /images/images_pkgdown/SeqFish_mouse_cortex/22-spatPlot2D.png
   :width: 50.0%

.. container:: cell

   .. code:: r

      spatPlot(gobject = subSS_seqfish, show_network = T,
               network_color = 'blue', spatial_network_name = 'spatial_network',
               point_size = 2.5, cell_color = 'cell_types')

.. image:: /images/images_pkgdown/SeqFish_mouse_cortex/23-spatPlot2D.png
   :width: 50.0%

.. container:: cell

   .. code:: r

      spatPlot(gobject = subSS_seqfish, show_network = T,
               network_color = 'blue', spatial_network_name = 'large_network',
               point_size = 2.5, cell_color = 'cell_types')

.. image:: /images/images_pkgdown/SeqFish_mouse_cortex/24-spatPlot2D.png
   :width: 50.0%

.. container:: cell

   .. code:: r

      spatPlot(gobject = subSS_seqfish, show_network = T,
               network_color = 'blue', spatial_network_name = 'distance_network',
               point_size = 2.5, cell_color = 'cell_types')

.. image:: /images/images_pkgdown/SeqFish_mouse_cortex/25-spatPlot2D.png
   :width: 50.0%

Part 10: Spatial Genes
======================

Individual spatial genes
------------------------

.. container:: cell

   .. code:: r

      ## 3 new methods to identify spatial genes
      km_spatialfeats = binSpect(SS_seqfish)
      spatGenePlot(SS_seqfish, expression_values = 'scaled', genes = km_spatialfeats[1:4]$feats,
                   point_shape = 'border', point_border_stroke = 0.1,
                   show_network = F, network_color = 'lightgrey', point_size = 2.5, 
                   cow_n_col = 2)

.. image:: /images/images_pkgdown/SeqFish_mouse_cortex/26-spatGenePlot2D.png
   :width: 50.0%

Spatial Genes Co-Expression Modules
-----------------------------------

.. container:: cell

   .. code:: r

      ## spatial co-expression patterns ##
      ext_spatial_genes = km_spatialfeats[1:500]$feats
      ## 1. calculate gene spatial correlation and single-cell correlation 
      ## create spatial correlation object
      spat_cor_netw_DT = detectSpatialCorFeats(SS_seqfish, 
                                               method = 'network',
                                               spatial_network_name = 'Delaunay_network',
                                               subset_feats = ext_spatial_genes)
      ## 2. cluster correlated genes & visualize
      spat_cor_netw_DT = clusterSpatialCorFeats(spat_cor_netw_DT, 
                                                name = 'spat_netw_clus', 
                                                k = 8)
      heatmSpatialCorFeats(SS_seqfish, spatCorObject = spat_cor_netw_DT, use_clus_name = 'spat_netw_clus', 
                           heatmap_legend_param = list(title = NULL))

.. image:: /images/images_pkgdown/SeqFish_mouse_cortex/27-heatmSpatialCorFeats.png
   :width: 50.0%

.. container:: cell

   .. code:: r

      # 3. rank spatial correlated clusters and show genes for selected clusters
      netw_ranks = rankSpatialCorGroups(SS_seqfish, 
                                        spatCorObject = spat_cor_netw_DT,
                                        use_clus_name = 'spat_netw_clus')
      top_netw_spat_cluster = showSpatialCorFeats(spat_cor_netw_DT, 
                                                  use_clus_name = 'spat_netw_clus',
                                                  selected_clusters = 6,
                                                  show_top_feats = 1)

.. image:: /images/images_pkgdown/SeqFish_mouse_cortex/28-rankSpatialCorGroups.png
   :width: 50.0%

.. container:: cell

   .. code:: r

      # 4. create metagene enrichment score for clusters
      cluster_genes_DT = showSpatialCorFeats(spat_cor_netw_DT, 
                                             use_clus_name = 'spat_netw_clus',
                                             show_top_feats = 1)
      cluster_genes = cluster_genes_DT$clus; names(cluster_genes) = cluster_genes_DT$feat_ID
      SS_seqfish = createMetafeats(SS_seqfish, 
                                   feat_clusters = cluster_genes, 
                                   name = 'cluster_metagene')
      spatCellPlot(SS_seqfish,
                   spat_enr_names = 'cluster_metagene',
                   cell_annotation_values = netw_ranks$clusters,
                   point_size = 1.5, cow_n_col = 3)

.. image:: /images/images_pkgdown/SeqFish_mouse_cortex/29-spatCellPlot2D.png
   :width: 50.0%

Part 11: HMRF Spatial Domains
=============================

.. container:: cell

   .. code:: r

      hmrf_folder = paste0(my_working_dir,'/','11_HMRF/')
      if(!file.exists(hmrf_folder)) dir.create(hmrf_folder, recursive = T)
      my_spatial_genes = km_spatialfeats[1:100]$feats
      # do HMRF with different betas
      HMRF_spatial_genes = doHMRF(gobject = SS_seqfish, 
                                  expression_values = 'scaled',
                                  spatial_genes = my_spatial_genes,
                                  spatial_network_name = 'Delaunay_network',
                                  k = 9,
                                  betas = c(28,2,3), 
                                  output_folder = paste0(hmrf_folder, '/', 'Spatial_genes/SG_top100_k9_scaled'))
      ## view results of HMRF
      for(i in seq(28, 32, by = 2)) {
        viewHMRFresults2D(gobject = SS_seqfish,
                          HMRFoutput = HMRF_spatial_genes,
                          k = 9, betas_to_view = i,
                          point_size = 2)
      }
      ## add HMRF of interest to giotto object
      SS_seqfish = addHMRF(gobject = SS_seqfish,
                           HMRFoutput = HMRF_spatial_genes,
                           k = 9, betas_to_add = c(28),
                           hmrf_name = 'HMRF_2')
      ## visualize
      spatPlot(gobject = SS_seqfish, 
               cell_color = 'HMRF_2_k9_b.28', 
               point_size = 3, 
               coord_fix_ratio = 1)

.. image:: /images/images_pkgdown/SeqFish_mouse_cortex/30-spatPlot2D.png
   :width: 50.0%

Part 12: Cell Neighborhood: Cell-Type/Cell-Type Interactions
============================================================

.. container:: cell

   .. code:: r

      cell_proximities = cellProximityEnrichment(gobject = SS_seqfish,
                                                 cluster_column = 'cell_types',
                                                 spatial_network_name = 'Delaunay_network',
                                                 adjust_method = 'fdr',
                                                 number_of_simulations = 2000)
      ## barplot
      cellProximityBarplot(gobject = SS_seqfish,
                           CPscore = cell_proximities, 
                           min_orig_ints = 5, min_sim_ints = 5)

.. image:: /images/images_pkgdown/SeqFish_mouse_cortex/31-cellProximityBarplot.png
   :width: 50.0%

.. container:: cell

   .. code:: r

      ## heatmap
      cellProximityHeatmap(gobject = SS_seqfish, 
                           CPscore = cell_proximities, 
                           order_cell_types = T, scale = T,
                           color_breaks = c(-1.5, 0, 1.5), 
                           color_names = c('blue', 'white', 'red'))

.. image:: /images/images_pkgdown/SeqFish_mouse_cortex/32-cellProximityHeatmap.png
   :width: 50.0%

.. container:: cell

   .. code:: r

      ## network
      cellProximityNetwork(gobject = SS_seqfish, 
                           CPscore = cell_proximities, remove_self_edges = T,
                           only_show_enrichment_edges = T)

.. image:: /images/images_pkgdown/SeqFish_mouse_cortex/33-cellProximityNetwork.png
   :width: 50.0%

.. container:: cell

   .. code:: r

      ## network with self-edges
      cellProximityNetwork(gobject = SS_seqfish, CPscore = cell_proximities,
                           remove_self_edges = F, self_loop_strength = 0.3,
                           only_show_enrichment_edges = F,
                           rescale_edge_weights = T,
                           node_size = 8,
                           edge_weight_range_depletion = c(1, 2),
                           edge_weight_range_enrichment = c(2,5))

.. image:: /images/images_pkgdown/SeqFish_mouse_cortex/12_d_network_cell_cell_enrichment_self.png
   :width: 50.0%

.. container:: cell

   .. code:: r

      ## visualization of specific cell types
      # Option 1
      spec_interaction = "astrocytes--Olig"
      cellProximitySpatPlot2D(gobject = SS_seqfish,
                              interaction_name = spec_interaction,
                              show_network = T,
                              cluster_column = 'cell_types',
                              cell_color = 'cell_types',
                              cell_color_code = c(astrocytes = 'lightblue', Olig = 'red'),
                              point_size_select = 4, point_size_other = 2)

.. image:: /images/images_pkgdown/SeqFish_mouse_cortex/34-cellProximitySpatPlot2D.png
   :width: 50.0%

.. container:: cell

   .. code:: r

      # Option 2: create additional metadata
      SS_seqfish = addCellIntMetadata(SS_seqfish, 
                                      spatial_network = 'spatial_network',
                                      cluster_column = 'cell_types',
                                      cell_interaction = spec_interaction,
                                      name = 'astro_olig_ints')
      spatPlot(SS_seqfish, cell_color = 'astro_olig_ints',
               select_cell_groups =  c('other_astrocytes', 'other_Olig', 'select_astrocytes', 'select_Olig'),
               legend_symbol_size = 3)

.. image:: /images/images_pkgdown/SeqFish_mouse_cortex/35-spatPlot2D.png
   :width: 50.0%

Part 13: Cell Neighborhood: Interaction Changed Features
=====================================================

.. container:: cell

   .. code:: r

      library(future)
      ## select top 25th highest expressing genes
      gene_metadata = fDataDT(SS_seqfish)
      plot(gene_metadata$nr_cells, gene_metadata$mean_expr)
      plot(gene_metadata$nr_cells, gene_metadata$mean_expr_det)
      quantile(gene_metadata$mean_expr_det)
      high_expressed_genes = gene_metadata[mean_expr_det > 3.5]$feat_ID
      ## identify genes that are associated with proximity to other cell types
      plan('multisession', workers = 6)
      ICFsForesHighGenes =  findInteractionChangedFeats(gobject = SS_seqfish,
                                    selected_feats = high_expressed_genes,
                                    spatial_network_name = 'Delaunay_network',
                                    cluster_column = 'cell_types',
                                    diff_test = 'permutation',
                                    adjust_method = 'fdr',
                                    nr_permutations = 2000, 
                                    do_parallel = T)
      ## visualize all genes
      plotCellProximityFeats(SS_seqfish, icfObject = ICFscoresHighGenes, 
                             method = 'dotplot')

.. image:: /images/images_pkgdown/SeqFish_mouse_cortex/36-plotCellProximityGenes.png
   :width: 50.0%

.. container:: cell

   .. code:: r

      ## filter genes
      ICFscoresFilt = filterICF(ICFscoresHighGenes)
      ## visualize subset of interaction changed genes (ICFs)
      ICF_genes = c('Jakmip1', 'Golgb1', 'Dact2', 'Ddx27', 'Abl1', 'Zswim8')
      ICF_genes_types = c('Lhx6 iNeuron', 'Lhx6 iNeuron', 'L4 eNeuron', 'L4 eNeuron', 'astrocytes', 'astrocytes')
      names(ICF_genes) = ICF_genes_types
      plotICF(gobject = SS_seqfish,
              icfObject = ICFscoresHighGenes,
              source_type = 'endothelial',
              source_markers = c('Pltp', 'Cldn5', 'Apcdd1'),
              ICF_feats = ICF_genes)

.. image:: /images/images_pkgdown/SeqFish_mouse_cortex/37-plotICF.png
   :width: 50.0%

Part 14: Cell Neighborhood: Ligand-Receptor Cell-Cell Communication
===================================================================

.. container:: cell

   .. code:: r

      ## LR expression
      ## LR activity changes
      LR_data = data.table::fread(system.file("extdata", "mouse_ligand_receptors.txt", package = 'Giotto'))
      LR_data[, ligand_det := ifelse(LR_data$mouseLigand %in% SS_seqfish@feat_ID$rna, T, F)]
      LR_data[, receptor_det := ifelse(LR_data$mouseReceptor %in% SS_seqfish@feat_ID$rna, T, F)]
      LR_data_det = LR_data[ligand_det == T & receptor_det == T]
      select_ligands = LR_data_det$mouseLigand
      select_receptors = LR_data_det$mouseReceptor
      ## get statistical significance of gene pair expression changes based on expression
      expr_only_scores = exprCellCellcom(gobject = SS_seqfish,
                                         cluster_column = 'cell_types', 
                                         random_iter = 1000,
                                         feat_set_1 = select_ligands,
                                         feat_set_2 = select_receptors, 
                                         verbose = FALSE)
      ## get statistical significance of gene pair expression changes upon cell-cell interaction
      spatial_all_scores = spatCellCellcom(SS_seqfish,
                                           spatial_network_name = 'spatial_network',
                                           cluster_column = 'cell_types', 
                                           random_iter = 1000,
                                           feat_set_1 = select_ligands,
                                           feat_set_2 = select_receptors,
                                           adjust_method = 'fdr',
                                           do_parallel = T,
                                           cores = 4,
                                           verbose = 'a little')
      ## select top LR ##
      selected_spat = spatial_all_scores[p.adj <= 0.01 & abs(log2fc) > 0.25 & lig_nr >= 4 & rec_nr >= 4]
      data.table::setorder(selected_spat, -PI)
      top_LR_ints = unique(selected_spat[order(-abs(PI))]$LR_comb)[1:33]
      top_LR_cell_ints = unique(selected_spat[order(-abs(PI))]$LR_cell_comb)[1:33]
      plotCCcomDotplot(gobject = SS_seqfish,
                       comScores = spatial_all_scores,
                       selected_LR = top_LR_ints,
                       selected_cell_LR = top_LR_cell_ints,
                       cluster_on = 'PI')

.. image:: /images/images_pkgdown/SeqFish_mouse_cortex/38-plotCCcomDotplot.png
   :width: 50.0%

.. container:: cell

   .. code:: r

      ## spatial vs rank ####
      comb_comm = combCCcom(spatialCC = spatial_all_scores,
                            exprCC = expr_only_scores)
      ## highest levels of ligand and receptor prediction
      ## top differential activity levels for ligand receptor pairs
      plotRankSpatvsExpr(gobject = SS_seqfish,
                         comb_comm,
                         expr_rnk_column = 'LR_expr_rnk',
                         spat_rnk_column = 'LR_spat_rnk',
                         midpoint = 10)

.. image:: /images/images_pkgdown/SeqFish_mouse_cortex/39-plotRankSpatvsExpr.png
   :width: 50.0%

.. container:: cell

   .. code:: r

      ## recovery
      plotRecovery(gobject = SS_seqfish,
                   comb_comm,
                   expr_rnk_column = 'LR_expr_rnk',
                   spat_rnk_column = 'LR_spat_rnk',
                   ground_truth = 'spatial')

.. image:: /images/images_pkgdown/SeqFish_mouse_cortex/40-plotRecovery.png
   :width: 50.0%
