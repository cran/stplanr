# Line functions

#' Retrieve the number of vertices in sf objects
#'
#' Returns a vector of the same length as the number of sf objects.
#'
#' @param l An sf object with LINESTRING geometry
#' @family lines
#' @export
#' @examples
#' l = routes_fast_sf
#' n_vertices(l)
#' n_vertices(zones_sf)
n_vertices <- function(l) {
  UseMethod("n_vertices")
}
#' @export
n_vertices.sf <- function(l) {
  sapply(sf::st_geometry(l), function(x) nrow(sf::st_coordinates(x)))
}

#' Identify lines that are points
#'
#' OD matrices often contain 'intrazonal' flows, where the origin is the same point as the
#' destination. This function can help identify such intrazonal OD pairs, using 2 criteria:
#' the total number of vertices (2 or fewer) and whether the origin and destination are the same.
#'
#' @details
#' Returns a boolean vector. TRUE means that the associated line is in fact a point
#' (has no distance). This can be useful for removing data that will not be plotted.
#'
#' @inheritParams line2df
#' @family lines
#' @export
#' @examples
#' islp <- is_linepoint(flowlines_sf)
#' nrow(flowlines_sf)
#' sum(islp)
#' # Remove invisible 'linepoints'
#' nrow(flowlines_sf[!islp, ])
is_linepoint <- function(l) {
  nverts <- n_vertices(l)
  sel <- nverts <= 2
  ldf <- line2df(l)
  ldf$fx == ldf$tx & ldf$fy & ldf$ty & sel
}
#' Find the bearing of straight lines
#'
#' This function returns the
#' bearing (in degrees relative to north) of lines.
#'
#' @details
#' Returns a boolean vector. TRUE means that the associated line is in fact a point
#' (has no distance). This can be useful for removing data that will not be plotted.
#'
#' @inheritParams line2df
#' @param bidirectional Should the result be returned in a bidirectional format?
#' Default is FALSE. If TRUE, the same line in the oposite direction would have the same bearing
#' @family lines
#' @export
#' @examples
#' lib_versions <- sf::sf_extSoftVersion()
#' lib_versions
#' # fails on some systems (with early versions of PROJ)
#' if (lib_versions[3] >= "6.3.1") {
#'   bearings_sf_1_9 <- line_bearing(flowlines_sf[1:5, ])
#'   bearings_sf_1_9 # lines of 0 length have NaN bearing
#'   line_bearing(flowlines_sf[1:5, ], bidirectional = TRUE)
#' }
line_bearing <- function(l, bidirectional = FALSE) {
  p <- sf::st_geometry(line2points(l))
  i_s <- 1:length(sf::st_geometry(l)) * 2 - 1
  bearing_radians <- sapply(i_s, function(i) lwgeom::st_geod_azimuth(p[i:(i + 1)]))
  bearing <- bearing_radians * 180 / (pi)
  if (bidirectional) {
    bearing <- make_bidirectional(bearing)
  }
  bearing
}
#' Calculate the angular difference between lines and a predefined bearing
#'
#' This function was designed to find lines that are close to parallel and perpendicular
#' to some pre-defined route. It can return results that are absolute (contain information
#' on the direction of turn, i.e. + or - values for clockwise/anticlockwise),
#' bidirectional (which mean values greater than +/- 90 are impossible).
#'
#' Building on the convention used in in the `bearing()` function from the
#' `geosphere` package and in many applications,
#' North is definied as 0, East as 90 and West as -90.
#'
#' @inheritParams line_bearing
#' @param absolute If TRUE (the default) only positive values can be returned
#' @param angle an angle in degrees relative to North, with 90 being East and -90 being West.
#'  (direction of rotation is ignored).
#' @family lines
#'
#' @export
#' @examples
#' lib_versions <- sf::sf_extSoftVersion()
#' lib_versions
#' # fails on some systems (with early versions of PROJ)
#' if (lib_versions[3] >= "6.3.1") {
#'   # Find all routes going North-South
#'   lines_sf <- od2line(od_data_sample, zones = zones_sf)
#'   angle_diff(lines_sf[2, ], angle = 0)
#'   angle_diff(lines_sf[2:3, ], angle = 0)
#' }
angle_diff <- function(l, angle, bidirectional = FALSE, absolute = TRUE) {
  if (is(object = l, "sf")) {
    line_angles <- line_bearing(l)
  } else {
    line_angles <- l
  }
  angle_diff <- angle - line_angles
  angle_diff[angle_diff <= -180] <- angle_diff[angle_diff <= -180] + 180
  angle_diff[angle_diff >= 180] <- angle_diff[angle_diff >= 180] - 180
  if (bidirectional) {
    angle_diff[angle_diff <= -90] <- 180 + angle_diff[angle_diff <= -90]
    angle_diff[angle_diff >= 90] <- 180 - angle_diff[angle_diff >= 90]
  }
  if (absolute) {
    angle_diff <- abs(angle_diff)
  }
  angle_diff
}
#' Find the mid-point of lines
#'
#' @inheritParams line2df
#' @param tolerance The tolerance used to break lines at verteces.
#'   See [lwgeom::st_linesubstring()].
#' @family lines
#' @export
#' @examples
#' l = routes_fast_sf[2:5, ]
#' plot(l$geometry, col = 2:5)
#' midpoints = line_midpoint(l)
#' plot(midpoints, add = TRUE)
line_midpoint <- function(l, tolerance = NULL) {
  if(is.null(tolerance)) {
    sub = lwgeom::st_linesubstring(x = l, from = 0, to = 0.5)
  } else {
    sub = lwgeom::st_linesubstring(x = l, from = 0, to = 0.5, tolerance = tolerance)
  }
  lwgeom::st_endpoint(sub)
}

#' Divide an sf object with LINESTRING geometry into regular segments
#'
#' This function keeps the attributes
#'
#' @inheritParams line2df
#' @param n_segments The number of segments to divide the line into
#' @param segment_length The approximate length of segments in the output (overides n_segments if set)
#' @family lines
#' @export
#' @examples
#' l <- routes_fast_sf[2, ]
#' l_seg2 <- line_segment(l = l, n_segments = 2)
#' l_seg3 <- line_segment(l = l, n_segments = 3)
#' l_seg_100 <- line_segment(l = l, segment_length = 100)
#' l_seg_2000 <- line_segment(l = l, segment_length = 2000)
#' plot(sf::st_geometry(l_seg2), col = 1:2, lwd = 5)
#' plot(sf::st_geometry(l_seg3), col = 1:3, lwd = 5)
#' plot(sf::st_geometry(l_seg_100), col = seq(nrow(l_seg_100)), lwd = 5)
#' plot(sf::st_geometry(l_seg_2000), col = seq(nrow(l_seg_100)), lwd = 5)
#' # Multiple lines
#' l <- routes_fast_sf[2:4, ]
#' l_seg_multi = line_segment(l, segment_length = 1000)
#' plot(sf::st_geometry(l_seg_multi), col = seq(nrow(l_seg_100)), lwd = 5)
line_segment <- function(
    l,
    n_segments = NA,
    segment_length = NA
    ) {
  n_row_l = nrow(l)
  if(n_row_l > 1) {
    res_list = pbapply::pblapply(seq(n_row_l), function(i) {
      l_segmented = line_segment(l[i, ], n_segments, segment_length)
      res_names <- names(sf::st_drop_geometry(l_segmented))
      # Work-around for https://github.com/ropensci/stplanr/issues/531
      if (i == 1) {
        res_names <<- names(sf::st_drop_geometry(l_segmented))
      }
      l_segmented = l_segmented[res_names]
      l_segmented
      })
    res = bind_sf(res_list)
    return(res)
  }
  if (is.na(n_segments)) {
    l_length <- as.numeric(sf::st_length(l))
    n_segments <- max(round(l_length / segment_length), 1)
  }
  if(n_segments == 1) {
    return(l)
  }
  from_to_sequence = seq(from = 0, to = 1, length.out = n_segments + 1)
  suppressWarnings({
    line_segment_list = lapply(seq(n_segments), function(i) {
      lwgeom::st_linesubstring(
        x = l,
        from = from_to_sequence[i],
        to = from_to_sequence[i + 1]
      )
  })
  })
  # first_linestring = lwgeom::st_linesubstring(x = l, from = 0, to = 0.2)
  res <- bind_sf(line_segment_list)
  res
}


make_bidirectional <- function(bearing) {
  is_na_bearings <- is.na(bearing)
  non_na_bearings <- bearing[!is_na_bearings]
  non_na_bearings[non_na_bearings > 90] <- non_na_bearings[non_na_bearings > 90] - 180
  non_na_bearings[non_na_bearings < -90] <- non_na_bearings[non_na_bearings < -90] + 180
  bearing[!is_na_bearings] <- non_na_bearings
  bearing
}

#' Rapid row-binding of sf objects
#'
#' @param x List of sf objects to combine
#' @return An sf data frame
#' @family geo
bind_sf = function(x) {
  if (length(x) == 0) stop("Empty list")
  geom_name = attr(x[[1]], "sf_column")
  # browser()
  x = data.table::rbindlist(x, use.names = FALSE)
  # x = collapse::unlist2d(x, idcols = FALSE, recursive = FALSE)
  x[[geom_name]] = sf::st_sfc(x[[geom_name]], recompute_bbox = TRUE)
  x = sf::st_as_sf(x)
  x
}
