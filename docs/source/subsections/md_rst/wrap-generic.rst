============
wrap-generic
============

:Date: 1/19/23

``wrap-generic``
================

Wrap giotto terra pointer information

Description
-----------

Extension of wrap methods from terra for Giotto’s terra-based S4
objects. Allows pointer information to be packaged into memory so that
it can be passed over a connection (e.g. nodes on a computer cluster)

Usage
-----

.. code:: r

   list(list("wrap"), list("giottoPolygon"))(x)
   list(list("wrap"), list("giotto"))(x)
   list(list("wrap"), list("giottoPoints"))(x)
   list(list("unwrap"), list("packedGiottoPolygon"))(x)
   list(list("unwrap"), list("packedGiottoPoints"))(x)
   list(list("unwrap"), list("packedGiotto"))(x)

Arguments
---------

======== =============================
Argument Description
======== =============================
``x``    giottoPolygon or giottoPoints
======== =============================
