% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/geo_projected.R
\name{geo_length}
\alias{geo_length}
\title{Calculate line length of line with geographic or projected CRS}
\usage{
geo_length(shp)
}
\arguments{
\item{shp}{A spatial line object}
}
\description{
Takes a line (represented in sf or sp classes)
and returns a numeric value representing distance in meters.
}
\examples{
lib_versions <- sf::sf_extSoftVersion()
lib_versions
if (lib_versions[3] >= "6.3.1") {
  geo_length(routes_fast_sf)
}
}
\seealso{
Other geo: 
\code{\link{bbox_scale}()},
\code{\link{bind_sf}()},
\code{\link{geo_bb}()},
\code{\link{geo_bb_matrix}()},
\code{\link{geo_buffer}()},
\code{\link{geo_projected}()},
\code{\link{geo_select_aeq}()},
\code{\link{quadrant}()}
}
\concept{geo}
