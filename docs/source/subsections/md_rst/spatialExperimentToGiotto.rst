=========================
spatialExperimentToGiotto
=========================

:Date: 1/19/23

https://github.com/drieslab/Giotto/tree/suite/R/interoperability.R#L1475

=============================

Utility function to convert a SpatialExperiment object to a Giotto
object

Description
-----------

Utility function to convert a SpatialExperiment object to a Giotto
object

Usage
-----

.. code:: r

   spatialExperimentToGiotto(
     spe,
     nn_network = NULL,
     sp_network = NULL,
     verbose = TRUE
   )

Arguments
---------

+-------------------------------+--------------------------------------+
| Argument                      | Description                          |
+===============================+======================================+
| ``spe``                       | Input SpatialExperiment object to    |
|                               | convert to a Giotto object.          |
+-------------------------------+--------------------------------------+
| ``nn_network``                | Specify the name of the nearest      |
|                               | neighbour network(s) in the input    |
|                               | SpatialExperiment object. Default    |
|                               | ``NULL`` will use all existing       |
|                               | networks.                            |
+-------------------------------+--------------------------------------+
| ``sp_network``                | Specify the name of the spatial      |
|                               | network(s) in the input              |
|                               | SpatialExperiment object. Default    |
|                               | ``NULL`` will use all existing       |
|                               | networks.                            |
+-------------------------------+--------------------------------------+
| ``verbose``                   | A boolean value specifying if        |
|                               | progress messages should be          |
|                               | displayed or not. Default ``TRUE`` . |
+-------------------------------+--------------------------------------+

Value
-----

Giotto object

Examples
--------

.. code:: r

   library(SpatialExperiment)
   example(read10xVisium, echo = FALSE)
   spatialExperimentToGiotto(spe)
