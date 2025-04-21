## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  # # Uncomment to speed-up build
  eval = FALSE,
  comment = "#>",
  echo = TRUE,
  message = FALSE,
  warning = FALSE
)
# devtools::load_all()
sf::sf_use_s2(FALSE)

## ----setup--------------------------------------------------------------------
# # library(stplanr)
# devtools::load_all()
# library(dplyr)
# library(tmap)
# library(ggplot2)
# library(tmaptools)
# rnet_x = sf::read_sf("https://github.com/ropensci/stplanr/releases/download/v1.0.2/rnet_x_ed.geojson")
# rnet_y = sf::read_sf("https://github.com/ropensci/stplanr/releases/download/v1.0.2/rnet_y_ed.geojson")
# # dups = duplicated(rnet_x$geometry)
# # summary(dups)
# # rnet_x = rnet_x |>
# #   filter(!dups)
# # sf::write_sf(rnet_x, "~/github/ropensci/stplanr/rnet_x_ed.geojson", delete_dsn = TRUE)

## ----out.width="50%", fig.width=8, fig.height=6, fig.show='hold'--------------
# # tmap_mode("view")
# # nrow(rnet_x)
# # summary(sf::st_length(rnet_x))
# plot(sf::st_geometry(rnet_x))
# rnet_x = rnet_subset(rnet_x, rnet_y, dist = 20)
# # nrow(rnet_x)
# # plot(sf::st_geometry(rnet_x))
# rnet_x = rnet_subset(rnet_x, rnet_y, dist = 20, min_length = 5)
# # summary(sf::st_length(rnet_x))
# # nrow(rnet_x)
# # plot(sf::st_geometry(rnet_x))
# rnet_x = rnet_subset(rnet_x, rnet_y, dist = 20, rm_disconnected = TRUE)
# # nrow(rnet_x)
# plot(sf::st_geometry(rnet_x))

## -----------------------------------------------------------------------------
# funs = list(value = sum, Quietness = mean)
# brks = c(0, 100, 500, 1000, 5000)
# system.time({
#   rnet_merged = rnet_merge(rnet_x, rnet_y, dist = 10, segment_length = 20, funs = funs)
# })
# m1 = tm_shape(rnet_y) + tm_lines("value", palette = "viridis", lwd = 5, breaks = brks)  +
#   tm_scale_bar()
# m2 = tm_shape(rnet_merged) + tm_lines("value", palette = "viridis", lwd = 5, breaks = brks)
# tmap_arrange(m1, m2, sync = TRUE, nrow = 1)

## -----------------------------------------------------------------------------
# rnet_x = sf::st_transform(rnet_x, 27700)
# rnet_y = sf::st_transform(rnet_y, 27700)

## -----------------------------------------------------------------------------
# rnet_y_segmented = line_segment(rnet_y, segment_length = 20, use_rsgeo = TRUE)
# system.time({
#   rnet_merged2 = rnet_merge(rnet_x, rnet_y, dist = 10, segment_length = 20, funs = funs)
# })

## -----------------------------------------------------------------------------
# names(rnet_merged)
# summary(rnet_merged$value)
# summary(rnet_y$value)
# sum(rnet_merged$value * sf::st_length(rnet_merged), na.rm = TRUE)
# sum(rnet_y$value * sf::st_length(rnet_y), na.rm = TRUE)

## -----------------------------------------------------------------------------
# rnet_merged = rnet_merge(rnet_x, rnet_y, dist = 20, segment_length = 10, funs = funs)
# m1 = tm_shape(rnet_y) + tm_lines("value", palette = "viridis", lwd = 5, breaks = brks)
# m2 = tm_shape(rnet_merged) + tm_lines("value", palette = "viridis", lwd = 5, breaks = brks)
# tmap_arrange(m1, m2, sync = TRUE, nrow = 1)

## -----------------------------------------------------------------------------
# summary(rnet_merged$value)
# summary(rnet_y$value)
# sum(rnet_merged$value * sf::st_length(rnet_merged), na.rm = TRUE)
# sum(rnet_y$value * sf::st_length(rnet_y), na.rm = TRUE)

## -----------------------------------------------------------------------------
# rnet_merged = rnet_merge(rnet_x, rnet_y, dist = 20, segment_length = 10, funs = funs, max_angle_diff = 20)
# m1 = tm_shape(rnet_y) + tm_lines("value", palette = "viridis", lwd = 5, breaks = brks)
# m2 = tm_shape(rnet_merged) + tm_lines("value", palette = "viridis", lwd = 5, breaks = brks)
# tmap_arrange(m1, m2, sync = TRUE, nrow = 1)

## -----------------------------------------------------------------------------
# summary(rnet_merged$value)
# summary(rnet_y$value)
# sum(rnet_merged$value * sf::st_length(rnet_merged), na.rm = TRUE)
# sum(rnet_y$value * sf::st_length(rnet_y), na.rm = TRUE)

## -----------------------------------------------------------------------------
# rnet_y$char = paste0("road", sample(1:3, nrow(rnet_y), replace = TRUE))
# most_common = function(x) {
#   ux = unique(x)
#   ux[which.max(tabulate(match(x, ux)))]
# }
# funs = list(char = most_common)
# system.time({
#   rnet_merged = rnet_merge(rnet_x, rnet_y, dist = 10, segment_length = 20, funs = funs)
# })
# plot(rnet_y["char"])
# plot(rnet_merged["char"])
# 

## -----------------------------------------------------------------------------
# rnet_x = sf::read_sf("https://github.com/nptscot/networkmerge/releases/download/v0.1/os_3km.geojson")
# rnet_y = sf::read_sf("https://github.com/nptscot/npt/releases/download/rnet_3km_buffer/rnet_3km_buffer.geojson")

## -----------------------------------------------------------------------------
# # Extract column names from the rnet_x data frame
# name_list <- names(rnet_y)
# name_list
# # Initialize an empty list
# funs <- list()
# 
# # Loop through each name and assign it a function based on specific conditions
# for (name in name_list) {
#   if (name == "geometry") {
#     next  # Skip the current iteration
#   } else if (name %in% c("Gradient", "Quietness")) {
#     funs[[name]] <- mean
#   } else {
#     funs[[name]] <- sum
#   }
# }

## ----eval = FALSE-------------------------------------------------------------
# brks = c(0, 100, 500, 1000, 5000,10000)
# colors <- c("green", "yellow", "blue", "purple", "red")
# rnet_merged = rnet_merge(rnet_x, rnet_y, dist = 20, segment_length = 10, funs = funs, max_angle_diff = 20)
# # st_write(rnet_merged, "data-raw/3km_exmaple_merged.geojson", driver = "GeoJSON")
# rnet_merged <- st_make_valid(rnet_merged)
# m1 = tm_shape(rnet_y) + tm_lines("all_fastest_bicycle", palette = "viridis", lwd = 5, breaks = brks)
# m2 = tm_shape(rnet_merged) + tm_lines("all_fastest_bicycle", palette = "viridis", lwd = 5, breaks = brks)
# tmap_arrange(m1, m2, sync = TRUE, nrow = 1)

## -----------------------------------------------------------------------------
# exmaple_3km = sf::read_sf("https://github.com/nptscot/networkmerge/releases/download/v0.1/3km_exmaple_merged.geojson")
# names(rnet_y)
# 
# summary(rnet_y$all_fastest_bicycle)
# summary(exmaple_3km$all_fastest_bicycle)
# sum(exmaple_3km$all_fastest_bicycle * sf::st_length(exmaple_3km), na.rm = TRUE)
# sum(rnet_y$all_fastest_bicycle * sf::st_length(rnet_y), na.rm = TRUE)

