write_giotto_viewer_annotation
------------------------------

Description
~~~~~~~~~~~

write out factor-like annotation data from a giotto object for the
Viewer

Usage
~~~~~

::

   write_giotto_viewer_annotation(
     annotation,
     annot_name = "test",
     output_directory = getwd()
   )

Arguments
~~~~~~~~~

+-----------------------------------+-----------------------------------+
| ``annotation``                    | annotation from the data.table    |
|                                   | from giotto object                |
+-----------------------------------+-----------------------------------+
| ``annot_name``                    | name of the annotation            |
+-----------------------------------+-----------------------------------+
| ``output_directory``              | directory where to save the files |
+-----------------------------------+-----------------------------------+

Value
~~~~~

write a .txt and .annot file for the selection annotation
