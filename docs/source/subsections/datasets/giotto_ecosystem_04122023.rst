================
Giotto Ecosystem
================

:Date: 4/12/23

1 Explanation
=============

We plan to curate an ecosystem of different, related packages to
modularize Giotto Suite as we extend its functionalities. Here, we
detail some different helper module(s) within the Giotto Ecosystem.

2 GiottoData
============

This package depends on Giotto Suite and leverages various functions
within it for saving and loading Giotto objects. It contains dataset
helper functions ``loadGiottoMini()`` and ``getSpatialDataset()``.
**Note that** ``getSpatialDataset()`` **was moved from Giotto Suite to
GiottoData!**

In addition to dataset helpers, we have created mini Giotto Objects for
testing Giotto Suite’s capabilities rapidly and streamlining the
tutorial experience. GiottoData currently includes two mini Giotto
Objects which are derived from Vizgen and Visium data; more mini Giotto
Objects will be published in the future. Further, we include mini
objects, S4 subobjects of a Giotto Object (i.e. exprObj), in an effort
to make the Giotto Object structure as transparent as possible.

GiottoData may be downloaded in a similar fashion to Giotto Suite:

.. container:: cell

   .. code:: r

      devtools::install_github("drieslab/GiottoData")

The scripts used to create both the mini giotto objects and mini objects
are available in the repository so that we may extend and/or improve
them and that you may utilize them for your own purposes!

2.1 Start Giotto
----------------

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

2.2 Create a Giotto object
--------------------------

.. container:: cell

   .. code:: r

      visium_mini = loadGiottoMini(dataset = 'visium')

3 Session Info
==============

.. container:: cell

   .. code:: r

      sessionInfo()

   .. container:: cell-output cell-output-stdout

      ::

         R version 4.2.2 (2022-10-31 ucrt)
         Platform: x86_64-w64-mingw32/x64 (64-bit)
         Running under: Windows 10 x64 (build 22621)

         Matrix products: default

         locale:
         [1] LC_COLLATE=English_United States.utf8 
         [2] LC_CTYPE=English_United States.utf8   
         [3] LC_MONETARY=English_United States.utf8
         [4] LC_NUMERIC=C                          
         [5] LC_TIME=English_United States.utf8    

         attached base packages:
         [1] stats     graphics  grDevices utils     datasets  methods   base     

         other attached packages:
         [1] GiottoData_0.1.0 Giotto_3.2.1    

         loaded via a namespace (and not attached):
          [1] Rcpp_1.0.10       pillar_1.9.0      compiler_4.2.2    tools_4.2.2      
          [5] digest_0.6.30     jsonlite_1.8.3    evaluate_0.20     lifecycle_1.0.3  
          [9] tibble_3.2.1      gtable_0.3.3      lattice_0.20-45   png_0.1-7        
         [13] pkgconfig_2.0.3   rlang_1.1.0       Matrix_1.5-1      cli_3.4.1        
         [17] rstudioapi_0.14   parallel_4.2.2    yaml_2.3.7        xfun_0.38        
         [21] fastmap_1.1.0     terra_1.7-18      dplyr_1.1.1       knitr_1.42       
         [25] rappdirs_0.3.3    generics_0.1.3    vctrs_0.6.1       grid_4.2.2       
         [29] tidyselect_1.2.0  reticulate_1.26   glue_1.6.2        data.table_1.14.6
         [33] R6_2.5.1          fansi_1.0.4       rmarkdown_2.21    ggplot2_3.4.1    
         [37] magrittr_2.0.3    scales_1.2.1      codetools_0.2-18  htmltools_0.5.4  
         [41] colorspace_2.1-0  utf8_1.2.3        munsell_0.5.0    
