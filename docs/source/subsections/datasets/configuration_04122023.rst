=============
Configuration
=============

:Date: 4/12/23

1 Configuring the Giotto Environment
====================================

Giotto contains several functions that contain wrappers to Python code
and thus requires an environment containing Python. Utilizing the
functionality of the
`reticulate <https://rstudio.github.io/reticulate/>`_ package,
Giotto contains a function which sets up a miniconda environment and
installs the required Python packages within that environment. Once this
function, `installGiottoEnvironment <../md_rst/installGiottoEnvironment.html>`_,
has been run, Giotto will automatically default to utilizing this
environment.

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

The function
`installGiottoEnvironment <../md_rst/installGiottoEnvironment.html>`_
two particular arguments that are most useful for reinstallation, if
necessary:

-  **force_miniconda**: force reinstallation of miniconda, default is
   FALSE
-  **force_environment**: force reinstallation of the Giotto
   environment, default is FALSE

**Note that, by default,**
`installGiottoEnvironment <../md_rst/installGiottoEnvironment.html>`_
**installs a specific version of Python and each required package. At
the time of this tutorial’s creation, the following versions are
utilized:**

-  `Python <https://www.python.org/>`_ 3.10.2
-  `pandas <https://pandas.pydata.org/>`_ 1.5.1
-  `networkx <https://networkx.org/>`_ 2.8.8
-  `python-igraph <https://igraph.org/python/>`_ 0.10.2
-  `leidenalg <https://leidenalg.readthedocs.io/en/latest/>`_
   0.9.0
-  `python-louvain <https://python-louvain.readthedocs.io/en/latest/>`_
   0.16
-  `python.app <https://github.com/conda-forge/python.app-feedstock>`_
   (Mac only) 1.4
-  `scikit-learn <https://scikit-learn.org/stable/>`_ 1.1.3
-  `smfishHmrf <https://pypi.org/project/smfishHmrf/>`_ 1.3.3

3 Customizing the Giotto Installation
=====================================

If different versions of Python or packages are necessary for a
workflow, Giotto may be installed accordingly. Ensure that all required
packages, which have been listed above, are accounted for when
installing. Simply specify the desired version numbers for each package
within a vector, and provide that vector to the *packages_to_install*
argument within **installGiottoEnvironment**.

Note that machine type is not relevant when providing
*packages_to_install* to **installGiottoEnvironment**; this function
will identify the OS in use and install/not install packages
(i.e. python.app) accordingly.

.. container:: cell

   .. code:: r

      ### Note that the following code has been provided to indicate how to install
      ### Giotto with customized Python and Python package versions. It has been 
      ### intentionally commented out so that it will not run and overwrite the 
      ### default versions unless deliberately edited.

      ### new_pkg_versions <- c('pandas==1.4.4',
      ###                       'networkx==2.6.3',
      ###                       'python-igraph==0.9.6',
      ###                       'leidenalg==0.8.7',
      ###                       'python-louvain==0.15',
      ###                       'scikit-learn==0.24.2',
      ###                       'python.app==2')
      ### 
      ### ############################
      ### # If altering the original Giotto Installation is not desired, DO NOT
      ### # run the following command as written.
      ### ############################
      ### installGiottoEnvironment(packages_to_install = new_pkg_versions,
      ###                          python_version = '3.8') # Default is 3.10.2

4 Advanced: Using a non-default Conda Environment with Giotto
=============================================================

If using `reticulate's <https://rstudio.github.io/reticulate/>`_
default miniconda path to create an environment is undesirable, the
Giotto environment may be created within an existing anaconda/miniconda
environment by specifying the ``mini_install_path`` argument:

.. container:: cell

   .. code:: r

      installGiottoEnvironment(mini_install_path = "C:/my/conda/lives/here")

If not provided, it is chosen by
`reticulate::install_miniconda() <https://rstudio.github.io/reticulate/reference/conda-tools.html#finding-conda-1>`_.
Please note the required input format: 
   - **Correct format:** mini_install_path = “C:/my/conda/lives/here” OR “C:\\my\\conda\\lives\\here” 
   - **INCORRECT formats:** mini_install_path = “C:/my/conda/lives/here/” AND “C:\\my\\conda\\lives\\here\\”

Unexpected behavior could arise if ``force_miniconda`` is set to
``TRUE`` when ``mini_install_path`` is specified and encompasses a
non-reticulate environment, as this prompts a reticulate miniconda
installation.

**Note that the installation of all aforementioned packages is necessary
for the full functionality of Giotto**. A .yml file is provided in the
repository for convenience of alternative installation methods. If the
desired environment is not named “giotto_env”, Giotto will be unable to
automatically detect the conda environment, so it must be specified
within a workflow. To use a specific, non-default named Conda
environment, the path to a system-specific python executable within that
environment must be provided to `createGiottoInstructions <../md_rst/createGiottoInstructions.html>`_.
This will direct reticulate to activate and utilize that environment
within that R session. See
`How to Create a Giotto Object <./getting_started_gobject.html>`_  for
more details.

5 Package Accessibility
=======================

Giotto makes use of the following Python packages (and their respective
dependencies) for full functionality:

-  `pandas <https://pandas.pydata.org/>`_
-  `networkx <https://networkx.org/>`_
-  `python-igraph <https://igraph.org/python/>`_
-  `leidenalg <https://leidenalg.readthedocs.io/en/latest/>`_
-  `python-louvain <https://python-louvain.readthedocs.io/en/latest/>`_
-  `python.app <https://github.com/conda-forge/python.app-feedstock>`_
   (Mac only)
-  `scikit-learn <https://scikit-learn.org/stable/>`_
-  `smfishHmrf <https://pypi.org/project/smfishHmrf/>`_

Here is a brief troubleshooting workflow to investigate if
`reticulate <https://rstudio.github.io/reticulate/>`_ can access
them.

*Note that “community” and “sklearn” are aliases of “python-louvain” and
“scikit-learn”, respectively.*

.. container:: cell

   .. code:: r

      # Creating Giotto Instructions without specifying a Python path will make 
      # reticulate activate the default Giotto environment. 
      default_instrs <- createGiottoInstructions()

      # Extract python path information
      default_python_path <- default_instrs$python_path

      # Make reticulate iteratively check for the packages
      pkg_check <- function(){
      py_pkgs = c('pandas','networkx', 'igraph', 'leidenalg','community','sklearn','python.app')
      py_pkg_error = character()
      test_availability = TRUE

      for (i in py_pkgs){
          if(i == 'python.app' & Sys.info()[['sysname']] != "Darwin"){
          # If the machine OS is not OSX (Mac), break out of the loop
          # Otherwise, also check for python.app
          break
          }
          test_availability <- reticulate::py_module_available(i)
          if(!test_availability) {py_pkg_error <- c(py_pkg_error,i)}
      }

      if(test_availability){
          cat('All Python packages for Giotto are accessible at environment:\n', default_python_path)
      }else{
          for (x in py_pkg_error) cat(x,'was not found within environment:\n',default_python_path,'\n\n')
      }

      return(py_pkg_error)
      }

      pkg_check()

6 Troubleshooting Packages not Found
====================================

.. container:: cell

   .. code:: r

      # Restart the R session, while maintaining workspace variables.
      # If using RStudio, the following command will do exactly that:
      .rs.restartR()

      # Direct reticulate to use Python within the Giotto Environment
      reticulate::use_python(default_python_path)

      # Check if packages exist again. Ensure function from above code block is defined.
      missing_packages <- pkg_check()

      retry_install <- length(missing_packages) > 0

      if(retry_install){

          # Attempt to reinstall all packages.
          pkgs_w_versions <- c('pandas==1.5.1',
                                  'networkx==2.8.8',
                                  'python-igraph==0.10.2',
                                  'leidenalg==0.9.0',
                                  'python-louvain==0.16',
                                  'python.app==1.4',
                                  'scikit-learn==1.1.3')

          python_version = "3.10.2"

          py_pkgs = c('pandas','networkx',
                      'igraph', 'leidenalg',
                      'python-louvain','scikit-learn','python.app')

          if(Sys.info()[['sysname']] != "Darwin"){
              pkgs_w_versions = pkgs_w_versions[!grepl(pattern = 'python.app', x = pkgs_w_versions)]
              py_pkgs = py_pkgs[!grepl(pattern = 'python.app', x = py_pkgs)]
          }

          env_location <- reticulate::py_discover_config()$pythonhome
          partial_path_to_conda <- paste0(reticulate::miniconda_path(),'/envs/giotto_env')

          py_lou = pkgs_w_versions[grepl(pattern = 'python-louvain',x = pkgs_w_versions)]
          pip_packages = c("smfishhmrf", py_lou)
          pkgs_w_versions = pkgs_w_versions[!grepl(pattern = 'python-louvain',x = pkgs_w_versions)]

          if(.Platform[['OS.type']] == 'unix') {

              conda_full_path = paste0(partial_conda_path,'/','bin/conda')

              # Remove all previous installations
              reticulate::conda_remove(envname = env_location,
                                      packages = py_pkgs,
                                      conda = conda_full_path)

              # Reinstall
              reticulate::conda_install(packages = pkgs_w_versions,
                                      envname = env_location,
                                      method = 'conda',
                                      conda = conda_full_path,
                                      python_version = python_version)

              # Reinstall with pip
              reticulate::conda_install(packages = pip_packages,
                                      envname = env_location,
                                      method = 'conda',
                                      conda = conda_full_path,
                                      pip = TRUE,
                                      python_version = python_version)
          }
          else if(.Platform[['OS.type']] == 'windows'){
              conda_full_path = paste0(partial_conda_path,'/','condabin/conda.bat')

              # Remove all previous installations
              reticulate::conda_remove(envname = env_location,
                                      packages = py_pkgs,
                                      conda = conda_full_path)

              # Reinstall
              reticulate::conda_install(packages = pkgs_w_versions,
                                      envname = env_location,
                                      method = 'conda',
                                      conda = conda_full_path,
                                      python_version = python_version,
                                      channel = c('conda-forge', 'vtraag'))

              # Reinstall with pip
              reticulate::conda_install(packages = pip_packages,
                                      envname = env_location,
                                      method = 'conda',
                                      conda = conda_full_path,
                                      pip = TRUE,
                                      python_version = python_version)
          }
      }

If this does not fix the issue at hand, here are some potential action
items:

-  Remove and attempt to reinstall the Giotto environment.

   -  Run
      `removeGiottoEnvironment <../md_rst/removeGiottoEnvironment.html>`_,
      then terminate R.
   -  Open a completely new R session, and run
      `installGiottoEnvironment <../md_rst/installGiottoEnvironment.html>`_

-  Post to an issue to the Giotto GitHub page
   `here <https://github.com/drieslab/Giotto>`_.

   -  Please include the version numbers of R, Giotto, and the OS in use
      at the time of the issue.

7 Session Info
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
