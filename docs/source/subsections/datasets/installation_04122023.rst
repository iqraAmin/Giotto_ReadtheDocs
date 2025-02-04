============
Installation
============

:Date: 4/12/23

1 Installing Giotto Suite
=========================

Giotto Suite is installed via R **but there are required Python
modules** which **must** be installed in order for Giotto Suite to
function properly. Below are the instructions for both the installation
of the Giotto Suite package and required Python environment.

1.1 Requirements
----------------

-  R (>= 4.0.1)
-  Python (>= 3.6)
-  Windows, MacOS or Linux specific installation tools for `Posit <https://support.posit.co/hc/en-us/articles/200486498-Package-Development-Prerequisites>`_ (previously RStudio)

2 Installation
==============

2.1 Install Giotto Suite
------------------------

.. container:: cell

   .. code:: r

      # Necessary for installation from R
      if(!"devtools" %in% installed.packages()) {
        install.packages("devtools")
      }

      devtools::install_github("drieslab/Giotto@suite")

2.2 Install the Giotto Python Environment
-----------------------------------------

.. container:: cell

   .. code:: r

      library(Giotto)
      installGiottoEnvironment()

3 Try Giotto in the cloud
=========================

You can also run analyses in Giotto on Terra.bio. Take a look on the
`Terra tutorial <https://giottosuite.readthedocs.io/en/latest/subsections/trygiotto/terra.html#terra/>`_.

Encountering errors? Checkout out the
`Troubleshooting page <../errorsfaqsandtips.html>`_ for help.
Alternatively, post to an issue to the Giotto GitHub page
`here <https://github.com/drieslab/Giotto>`_. Please include the
version numbers of R, Giotto, and the OS in use at the time of the
issue.

4 Session Info
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
         [1] Giotto_3.2.1

         loaded via a namespace (and not attached):
          [1] Rcpp_1.0.10       pillar_1.9.0      compiler_4.2.2    tools_4.2.2      
          [5] digest_0.6.30     jsonlite_1.8.3    evaluate_0.20     lifecycle_1.0.3  
          [9] tibble_3.2.1      gtable_0.3.3      lattice_0.20-45   pkgconfig_2.0.3  
         [13] rlang_1.1.0       Matrix_1.5-1      cli_3.4.1         rstudioapi_0.14  
         [17] parallel_4.2.2    yaml_2.3.7        xfun_0.38         fastmap_1.1.0    
         [21] terra_1.7-18      dplyr_1.1.1       knitr_1.42        generics_0.1.3   
         [25] vctrs_0.6.1       grid_4.2.2        tidyselect_1.2.0  glue_1.6.2       
         [29] data.table_1.14.6 R6_2.5.1          fansi_1.0.4       rmarkdown_2.21   
         [33] ggplot2_3.4.1     magrittr_2.0.3    scales_1.2.1      codetools_0.2-18 
         [37] htmltools_0.5.4   colorspace_2.1-0  utf8_1.2.3        munsell_0.5.0    
