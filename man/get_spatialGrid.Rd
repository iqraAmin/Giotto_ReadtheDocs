% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/accessors.R
\name{get_spatialGrid}
\alias{get_spatialGrid}
\title{Get spatial grid}
\usage{
get_spatialGrid(
  gobject,
  spat_unit = NULL,
  feat_type = NULL,
  name = NULL,
  return_grid_Obj = FALSE
)
}
\arguments{
\item{gobject}{giotto object}

\item{spat_unit}{spatial unit (e.g. "cell")}

\item{feat_type}{feature type (e.g. "rna", "dna", "protein")}

\item{name}{name of spatial grid}

\item{return_grid_Obj}{return grid object (default = FALSE)}
}
\description{
Function to get spatial grid
}
\seealso{
Other spatial grid data accessor functions: 
\code{\link{set_spatialGrid}()}

Other functions to get data from giotto object: 
\code{\link{get_NearestNetwork}()},
\code{\link{get_dimReduction}()},
\code{\link{get_expression_values}()},
\code{\link{get_feature_info}()},
\code{\link{get_giottoImage}()},
\code{\link{get_polygon_info}()},
\code{\link{get_spatialNetwork}()},
\code{\link{get_spatial_enrichment}()},
\code{\link{get_spatial_locations}()}
}
\concept{functions to get data from giotto object}
\concept{spatial grid data accessor functions}
