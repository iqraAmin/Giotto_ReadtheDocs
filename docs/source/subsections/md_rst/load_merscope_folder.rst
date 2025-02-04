====================
load_merscope_folder
====================

:Date: 1/19/23

``load_merscope_folder``
========================

Load MERSCOPE data from folder

Description
-----------

Load MERSCOPE data from folder

Usage
-----

.. code:: r

   load_merscope_folder(
     dir_items,
     data_to_use,
     fovs = NULL,
     cores = NA,
     verbose = TRUE
   )
   load_merscope_folder_subcellular(
     dir_items,
     data_to_use,
     cores = NA,
     verbose = TRUE,
     fovs = NULL
   )
   load_merscope_folder_aggregate(
     dir_items,
     data_to_use,
     cores = NA,
     verbose = TRUE
   )

Arguments
---------

+-------------------------------+--------------------------------------+
| Argument                      | Description                          |
+===============================+======================================+
| ``dir_items``                 | list of full filepaths from          |
|                               | ```read_mersco                       |
|                               | pe_folder`` <#readmerscopefolder>`__ |
+-------------------------------+--------------------------------------+
| ``data_to_use``               | which of either the ‘subcellular’ or |
|                               | ‘aggregate’ information to use for   |
|                               | object creation                      |
+-------------------------------+--------------------------------------+
| ``cores``                     | how many cores or threads to use to  |
|                               | read data if paths are provided      |
+-------------------------------+--------------------------------------+
| ``verbose``                   | be verbose when building Giotto      |
|                               | object                               |
+-------------------------------+--------------------------------------+

Value
-----

list of loaded-in MERSCOPE data
