% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/generics.R, R/SfcArray-sf.R
\name{st_bbox}
\alias{st_bbox}
\alias{st_bbox.SfcArray}
\title{Bounding box of an '\code{\link[via:SfArray-class]{SfArray}}'-class object}
\usage{
\method{st_bbox}{SfcArray}(obj, ...)
}
\arguments{
\item{obj}{a \code{\link[sf:sf]{sf}}-class object.}

\item{...}{arguments passed to the \code{\link[sf]{st_bbox}} function.}
}
\value{
An \code{\link[via:RasterArray-class]{RasterArray}} class object.
}
\description{
The method is inherited from the '\code{\link[sf:sf]{sf}}' class.
}
\examples{
data(paleocoastlines)
bb<- st_bbox(paleocoastlines)
}
