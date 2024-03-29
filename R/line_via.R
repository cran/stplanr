#' Convert 2 matrices to lines
#'
#' @param mat1 Matrix representing origins
#' @param mat2 Matrix representing destinations
#' @param crs Number representing the coordinate system of the data, e.g. 4326
#' @family lines
#'
#' @export
#' @examples
#' m1 <- matrix(c(1, 2, 1, 2), ncol = 2)
#' m2 <- matrix(c(9, 9, 9, 1), ncol = 2)
#' l <- mats2line(m1, m2)
#' class(l)
#' l
#' lsf <- sf::st_sf(l, crs = 4326)
#' class(lsf)
#' plot(lsf)
#' # mapview::mapview(lsf)
mats2line <- function(mat1, mat2, crs = NA) {
  l <- lapply(1:nrow(mat1), function(i) {
    mat_combined <- rbind(mat1[i, ], mat2[i, ])
    sf::st_linestring(mat_combined)
  })
  if(is.na(crs)) {
    sf::st_sfc(l)
  } else {
    sf::st_sfc(l, crs = crs)
  }
}
#' Add geometry columns representing a route via intermediary points
#'
#' Takes an origin (A) and destination (B), represented by the linestring `l`,
#' and generates 3 extra geometries based on points `p`:
#'
#' 1) From A to P1 (P1 being the nearest point to A)
#'
#' 2) From P1 to P2 (P2 being the nearest point to B)
#'
#' 3) From P2 to B
#'
#' @inheritParams points2odf
#' @inheritParams line2df
#' @family lines
#' @export
#' @examples
#' library(sf)
#' l <- flowlines_sf[2:4, ]
#' p <- destinations_sf
#' lv <- line_via(l, p)
#' lv
#' # library(mapview)
#' # mapview(lv) +
#' #    mapview(lv$leg_orig, col = "red")
#' plot(lv[3], lwd = 9, reset = FALSE)
#' plot(lv$leg_orig, col = "red", lwd = 5, add = TRUE)
#' plot(lv$leg_via, col = "black", add = TRUE)
#' plot(lv$leg_dest, col = "green", lwd = 5, add = TRUE)
line_via <- function(l, p) {
  l_crs <- sf::st_crs(l)
  mat_orig <- as.matrix(line2df(l)[c("fx", "fy")])
  mat_dest <- as.matrix(line2df(l)[c("tx", "ty")])
  mat_via <- sf::st_coordinates(p)
  knn_orig <- nabor::knn(mat_via, query = mat_orig, k = 1)$nn.idx
  knn_dest <- nabor::knn(mat_via, query = mat_dest, k = 1)$nn.idx
  mat_via_o <- mat_via[knn_orig, ]
  mat_via_d <- mat_via[knn_dest, ]
  l$leg_orig <- mats2line(mat_orig, mat_via_o, crs = l_crs)
  l$leg_via <- mats2line(mat_via_o, mat_via_d, crs = l_crs)
  l$leg_dest <- mats2line(mat_via_d, mat_dest, crs = l_crs)
  l
}
