## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  # # Uncomment to speed-up build
  eval = FALSE,
  comment = "#>",
  echo = FALSE,
  message = FALSE,
  warning = FALSE
)
# devtools::load_all()
sf::sf_use_s2(FALSE)

## ----setup--------------------------------------------------------------------
#  library(stplanr)
#  library(dplyr)
#  library(tmap)
#  rnet_x = sf::read_sf("https://github.com/ropensci/stplanr/releases/download/v1.0.2/rnet_x_ed.geojson")
#  rnet_y = sf::read_sf("https://github.com/ropensci/stplanr/releases/download/v1.0.2/rnet_y_ed.geojson")
#  # dups = duplicated(rnet_x$geometry)
#  # summary(dups)
#  # rnet_x = rnet_x |>
#  #   filter(!dups)
#  # sf::write_sf(rnet_x, "~/github/ropensci/stplanr/rnet_x_ed.geojson", delete_dsn = TRUE)

## ---- out.width="50%", fig.width=8, fig.height=6, fig.show='hold'-------------
#  # tmap_mode("view")
#  # nrow(rnet_x)
#  # summary(sf::st_length(rnet_x))
#  plot(sf::st_geometry(rnet_x))
#  rnet_x = rnet_subset(rnet_x, rnet_y, dist = 20)
#  # nrow(rnet_x)
#  # plot(sf::st_geometry(rnet_x))
#  rnet_x = rnet_subset(rnet_x, rnet_y, dist = 20, min_length = 5)
#  # summary(sf::st_length(rnet_x))
#  # nrow(rnet_x)
#  # plot(sf::st_geometry(rnet_x))
#  rnet_x = rnet_subset(rnet_x, rnet_y, dist = 20, rm_disconnected = TRUE)
#  # nrow(rnet_x)
#  plot(sf::st_geometry(rnet_x))

## -----------------------------------------------------------------------------
#  funs = list(value = sum, Quietness = mean)
#  brks = c(0, 100, 500, 1000, 5000)
#  rnet_merged = rnet_merge(rnet_x, rnet_y, dist = 10, segment_length = 20, funs = funs)
#  m1 = tm_shape(rnet_y) + tm_lines("value", palette = "viridis", lwd = 5, breaks = brks)  +
#    tm_scale_bar()
#  m2 = tm_shape(rnet_merged) + tm_lines("value", palette = "viridis", lwd = 5, breaks = brks)
#  tmap_arrange(m1, m2, sync = TRUE, nrow = 1)

## -----------------------------------------------------------------------------
#  summary(rnet_merged$value)
#  summary(rnet_y$value)
#  sum(rnet_merged$value * sf::st_length(rnet_merged), na.rm = TRUE)
#  sum(rnet_y$value * sf::st_length(rnet_y), na.rm = TRUE)

## -----------------------------------------------------------------------------
#  rnet_merged = rnet_merge(rnet_x, rnet_y, dist = 20, segment_length = 10, funs = funs)
#  m1 = tm_shape(rnet_y) + tm_lines("value", palette = "viridis", lwd = 5, breaks = brks)
#  m2 = tm_shape(rnet_merged) + tm_lines("value", palette = "viridis", lwd = 5, breaks = brks)
#  tmap_arrange(m1, m2, sync = TRUE, nrow = 1)

## -----------------------------------------------------------------------------
#  summary(rnet_merged$value)
#  summary(rnet_y$value)
#  sum(rnet_merged$value * sf::st_length(rnet_merged), na.rm = TRUE)
#  sum(rnet_y$value * sf::st_length(rnet_y), na.rm = TRUE)

## -----------------------------------------------------------------------------
#  rnet_merged = rnet_merge(rnet_x, rnet_y, dist = 20, segment_length = 10, funs = funs, max_angle_diff = 20)
#  m1 = tm_shape(rnet_y) + tm_lines("value", palette = "viridis", lwd = 5, breaks = brks)
#  m2 = tm_shape(rnet_merged) + tm_lines("value", palette = "viridis", lwd = 5, breaks = brks)
#  tmap_arrange(m1, m2, sync = TRUE, nrow = 1)

## -----------------------------------------------------------------------------
#  summary(rnet_merged$value)
#  summary(rnet_y$value)
#  sum(rnet_merged$value * sf::st_length(rnet_merged), na.rm = TRUE)
#  sum(rnet_y$value * sf::st_length(rnet_y), na.rm = TRUE)

