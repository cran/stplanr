% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/oneway.R
\name{od_id_order}
\alias{od_id_order}
\title{Generate ordered ids of OD pairs so lowest is always first
This function is slow on large datasets, see szudzik_pairing for faster alternative}
\usage{
od_id_order(x, id1 = names(x)[1], id2 = names(x)[2])
}
\arguments{
\item{x}{A data frame or SpatialLinesDataFrame, representing an OD matrix}

\item{id1}{Optional (it is assumed to be the first column)
text string referring to the name of the variable containing
the unique id of the origin}

\item{id2}{Optional (it is assumed to be the second column)
text string referring to the name of the variable containing
the unique id of the destination}
}
\description{
Generate ordered ids of OD pairs so lowest is always first
This function is slow on large datasets, see szudzik_pairing for faster alternative
}
\examples{
x <- data.frame(id1 = c(1, 1, 2, 2, 3), id2 = c(1, 2, 3, 1, 4))
od_id_order(x) # 4th line switches id1 and id2 so stplanr.key is in order
}
\seealso{
Other od: 
\code{\link{od2line}()},
\code{\link{od2odf}()},
\code{\link{od_aggregate_from}()},
\code{\link{od_aggregate_to}()},
\code{\link{od_coords}()},
\code{\link{od_coords2line}()},
\code{\link{od_id}},
\code{\link{od_oneway}()},
\code{\link{od_to_odmatrix}()},
\code{\link{odmatrix_to_od}()},
\code{\link{points2flow}()},
\code{\link{points2odf}()}
}
\concept{od}
