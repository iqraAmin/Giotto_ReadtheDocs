====================
Saving your analysis
====================

:Date: last-modified 4/14/23

1 Tutorial explanation
======================

| Giotto objects contain certain objects that act as pointers to the
  data that they reference or pull from. While this can help with
  lowering the amount of memory needed and decrease load times, pointer
  objects do not save and reload properly when using ``saveRDS()`` and
  ``readRDS()``.
| Giotto instead implements the ``saveGiotto()`` and ``loadGiotto()``
  functions that collects all the data attached to the object and saves
  it in a standalone manner. These functions will be demonstrated using
  a small subset of the Vizgen mouse brain dataset that is easily
  available through the **GiottoData** package

2 Start Giotto
==============

.. container:: cell

   .. code:: r

      # Ensure Giotto Suite is installed
      if(!"Giotto" %in% installed.packages()) {
        devtools::install_github("drieslab/Giotto@suite")
      }
      library(Giotto)

      # Ensure Giotto Data is installed
      if(!"GiottoData" %in% installed.packages()) {
        devtools::install_github("drieslab/GiottoData")
      }
      library(GiottoData)

      # Ensure the Python environment for Giotto has been installed
      genv_exists = checkGiottoEnvironment()
      if(!genv_exists){
        # The following command need only be run once to install the Giotto environment
        installGiottoEnvironment()
      }

3 Create a Giotto object
========================

.. container:: cell

   .. code:: r

      vizgen = loadGiottoMini(dataset = 'vizgen')

   .. container:: cell-output cell-output-stdout

      ::

         [1] "/Library/Frameworks/R.framework/Versions/4.2/Resources/library/GiottoData//Mini_datasets/Vizgen/VizgenObject//Features/rna_feature_spatVector.shp"
         [1] "rna"
         [1] "aggregate_spatInfo_spatVector.shp" "z0_spatInfo_spatVector.shp"       
         [3] "z1_spatInfo_spatVector.shp"       
         [1] "aggregate_spatInfo_spatVectorCentroids.shp"
         [2] "z0_spatInfo_spatVectorCentroids.shp"       
         [3] "z1_spatInfo_spatVectorCentroids.shp"       
         [1] "rna_aggregate_spatInfo_spatVectorOverlaps.shp"
         [2] "rna_z0_spatInfo_spatVectorOverlaps.shp"       
         [3] "rna_z1_spatInfo_spatVectorOverlaps.shp"       
         [1] "poly_ID"      "feat_ID"      "feat_ID_uniq" "stack"       
         [1] "poly_ID"      "feat_ID"      "feat_ID_uniq"
         [1] "poly_ID"      "feat_ID"      "feat_ID_uniq"

4 Show Existing Info
====================

Many analyses were first performed on this mini object to fill it out
before it was saved using ``saveGiotto()``. Returning the object gives
an overview of its contents.

.. container:: cell

   .. code:: r

       vizgen

   .. container:: cell-output cell-output-stdout

      ::

         An object of class giotto 
         >Active spat_unit:  z0 
         >Active feat_type:  rna 
         [SUBCELLULAR INFO]
         polygons      : z0 z1 aggregate 
         features      : rna 
         [AGGREGATE INFO]
         expression -----------------------
           [z0][rna] raw
           [z1][rna] raw
           [aggregate][rna] raw normalized scaled pearson
         spatial locations ----------------
           [z0] raw
           [z1] raw
           [aggregate] raw
         spatial networks -----------------
           [aggregate] Delaunay_network kNN_network
         dim reduction --------------------
           [aggregate][rna] pca umap tsne
         nearest neighbor networks --------
           [aggregate][rna] sNN.pca
         attached images ------------------
         giottoLargeImage : 4 items...


         Use objHistory() to see steps and params used

The object also functions as expected. Here we first set the active
spatial unit as ‘aggregate’ and then plot the saved leiden clustering
results.

.. container:: cell

   .. code:: r

       activeSpatUnit(vizgen) = 'aggregate'
       spatPlot2D(vizgen,
                  show_image = TRUE,
                  cell_color = 'leiden_clus',
                  largeImage_name = 'dapi_z0',
                  point_alpha = 0.5)

   .. container:: cell-output-display

      .. image:: 230414_save_giotto_object_George_files/figure-rst/unnamed-chunk-4-1.png

5 Saving the Object
===================

To save the object, most important inputs are the object to be saved, a
directory in which to place the saved object, and the actual folder
within that directory to contain Giotto’s files.

The dir param defaults to the working directory, but here I am
specifying for the object to be saved to a temporary directory.

.. container:: cell

   .. code:: r

      saveGiotto(gobject = vizgen,
                 dir = tempdir(),
                 foldername = 'vizgen')

6 Faster Saving with ``qs``
===========================

``saveGiotto()`` defaults to using ``saveRDS()`` for its main files, but
``qs`` implements faster read and write functions for serialization.
Saving using ``qs`` is done by passing the param ``method = 'qs'``.

Note that ``qs`` is an additional package that is not installed by
default with Giotto but it can be installed with
``install.packages(qs)``.

7 Loading the Object
====================

To load the object, only the path to the folder is needed. Additional
params of interest are:

-  ``reconnect_giottoImage`` -instead of reading from the saved images
   in the folder- attempts to reconnect the pointer objects based on
   filepaths that were recorded. This requires that the Giotto object is
   being loaded on the same system it was generated on and that those
   images have not been moved.

-  ``python_path`` allows a new python path to be set during loading.

.. container:: cell

   .. code:: r

      test_vizgen = loadGiotto(path_to_folder = file.path(tempdir(), 'vizgen'))

.. container:: cell

   .. code:: r

      test_vizgen

   .. container:: cell-output cell-output-stdout

      ::

         An object of class giotto 
         >Active spat_unit:  aggregate 
         >Active feat_type:  rna 
         [SUBCELLULAR INFO]
         polygons      : z0 z1 aggregate 
         features      : rna 
         [AGGREGATE INFO]
         expression -----------------------
           [z0][rna] raw
           [z1][rna] raw
           [aggregate][rna] raw normalized scaled pearson
         spatial locations ----------------
           [z0] raw
           [z1] raw
           [aggregate] raw
         spatial networks -----------------
           [aggregate] Delaunay_network kNN_network
         dim reduction --------------------
           [aggregate][rna] pca umap tsne
         nearest neighbor networks --------
           [aggregate][rna] sNN.pca
         attached images ------------------
         giottoLargeImage : 4 items...


         Use objHistory() to see steps and params used

.. container:: cell

   .. code:: r

       activeSpatUnit(test_vizgen) = 'aggregate'
       spatPlot2D(test_vizgen,
                  show_image = TRUE,
                  cell_color = 'leiden_clus',
                  largeImage_name = 'dapi_z0',
                  point_alpha = 0.5)

   .. container:: cell-output-display

      .. image:: 230414_save_giotto_object_George_files/figure-rst/unnamed-chunk-8-1.png

8 Session Info
==============

.. container:: cell

   .. code:: r

      sessionInfo()

   .. container:: cell-output cell-output-stdout

      ::

         R version 4.2.1 (2022-06-23)
         Platform: x86_64-apple-darwin17.0 (64-bit)
         Running under: macOS Big Sur ... 10.16

         Matrix products: default
         BLAS:   /Library/Frameworks/R.framework/Versions/4.2/Resources/lib/libRblas.0.dylib
         LAPACK: /Library/Frameworks/R.framework/Versions/4.2/Resources/lib/libRlapack.dylib

         locale:
         [1] en_US.UTF-8/en_US.UTF-8/en_US.UTF-8/C/en_US.UTF-8/en_US.UTF-8

         attached base packages:
         [1] stats     graphics  grDevices utils     datasets  methods   base     

         other attached packages:
         [1] GiottoData_0.2.1 Giotto_3.2.1    

         loaded via a namespace (and not attached):
          [1] Rcpp_1.0.10        RColorBrewer_1.1-3 pillar_1.9.0       compiler_4.2.1    
          [5] tools_4.2.1        digest_0.6.31      jsonlite_1.8.4     evaluate_0.20     
          [9] lifecycle_1.0.3    tibble_3.2.1       gtable_0.3.3       lattice_0.20-45   
         [13] png_0.1-8          pkgconfig_2.0.3    rlang_1.1.0        igraph_1.4.1      
         [17] Matrix_1.5-3       cli_3.6.1          rstudioapi_0.14    parallel_4.2.1    
         [21] yaml_2.3.7         xfun_0.38          fastmap_1.1.1      terra_1.7-22      
         [25] withr_2.5.0        dplyr_1.1.1        knitr_1.42         generics_0.1.3    
         [29] vctrs_0.6.1        rprojroot_2.0.3    grid_4.2.1         tidyselect_1.2.0  
         [33] here_1.0.1         reticulate_1.28    glue_1.6.2         data.table_1.14.8 
         [37] R6_2.5.1           fansi_1.0.4        rmarkdown_2.21     farver_2.1.1      
         [41] ggplot2_3.4.2      magrittr_2.0.3     scales_1.2.1       codetools_0.2-18  
         [45] htmltools_0.5.5    colorspace_2.1-0   labeling_0.4.2     utf8_1.2.3        
         [49] munsell_0.5.0     
