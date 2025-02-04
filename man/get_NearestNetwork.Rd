% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/accessors.R
\name{get_NearestNetwork}
\alias{get_NearestNetwork}
\title{Get nearest network}
\usage{
get_NearestNetwork(
  gobject,
  spat_unit = NULL,
  feat_type = NULL,
  nn_network_to_use = NULL,
  network_name = NULL,
  output = c("igraph", "data.table")
)
}
\arguments{
\item{gobject}{giotto object}

\item{spat_unit}{spatial unit (e.g. "cell")}

\item{feat_type}{feature type (e.g. "rna", "dna", "protein")}

\item{nn_network_to_use}{"kNN" or "sNN"}

\item{network_name}{name of NN network to be used}

\item{output}{return a igraph or data.table object. Default 'igraph'}
}
\value{
igraph or data.table object
}
\description{
Get a NN-network from a Giotto object
}
\seealso{
Other expression space nearest network accessor functions: 
\code{\link{set_NearestNetwork}()}

Other functions to get data from giotto object: 
\code{\link{get_dimReduction}()},
\code{\link{get_expression_values}()},
\code{\link{get_feature_info}()},
\code{\link{get_giottoImage}()},
\code{\link{get_polygon_info}()},
\code{\link{get_spatialGrid}()},
\code{\link{get_spatialNetwork}()},
\code{\link{get_spatial_enrichment}()},
\code{\link{get_spatial_locations}()}
}
\concept{expression space nearest network accessor functions}
\concept{functions to get data from giotto object}
