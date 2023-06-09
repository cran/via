% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/generics.R, R/SfcArray-sf.R
\name{st_transform}
\alias{st_transform}
\alias{st_transform.SfcArray}
\title{Projection change of an '\code{\link[via:SfArray-class]{SfArray}}'-class object}
\usage{
\method{st_transform}{SfcArray}(x, ...)
}
\arguments{
\item{x}{a \code{\link[sf:sf]{sf}}-class object.}

\item{...}{arguments passed to the \code{\link[sf]{st_transform}} function.}
}
\value{
An \code{\link[via:RasterArray-class]{RasterArray}}-class object.
}
\description{
The method is inherited from the '\code{\link[sf:sf]{sf}}' class.
}
\examples{
data(paleocoastlines)
moll<- st_transform(paleocoastlines, "ESRI:54009")
plot(moll["20", "margin"], col="cyan")
plot(moll["20", "coast"], add=TRUE, col="brown")
}
