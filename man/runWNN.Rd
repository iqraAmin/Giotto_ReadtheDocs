% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/wnn.R
\name{runWNN}
\alias{runWNN}
\title{Multi omics integration with WNN}
\usage{
runWNN(gobject, k = 20)
}
\arguments{
\item{gobject}{A Giotto object with individual PCA modalities pre-calculated}

\item{k}{k number, default = 20}
}
\value{
A Giotto object with integrated UMAP (integrated.umap) within the dimension_reduction slot and Leiden clusters (integrated_leiden_clus) in the cellular metadata.
}
\description{
Multi omics integration with WNN
}
