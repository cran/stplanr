## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  eval = FALSE,
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
# library(stplanr)
# library(sf)
# library(dplyr)
# library(tmap)
# library(parallel)
# library(cyclestreets)

## -----------------------------------------------------------------------------
# # ?route
# l = flowlines_sf %>%
#   dplyr::filter()
# t1 = Sys.time()
# routes_route_cyclestreet = line2route(l)
# Sys.time() - t1
# ncol(routes_route_cyclestreet)
# nrow(routes_route_cyclestreet)
# names(routes_route_cyclestreet)
# routes_route_cyclestreet_joined = dplyr::inner_join(routes_route_cyclestreet, sf::st_drop_geometry(l))
# Sys.time() - t1
# rnet_go_dutch = overline(routes_route_cyclestreet_joined, "All")
# Sys.time() - t1
# tm_shape(rnet_go_dutch) +
#   tm_lines(lwd = 5, col = "All", breaks = c(0, 10, 100, 500, 1000), palette = "viridis")

## -----------------------------------------------------------------------------
# # ?route
# t1 = Sys.time()
# routes_journey = route(l = l, route_fun = cyclestreets::journey)
# ncol(routes_journey)
# nrow(routes_journey)
# 
# Sys.time() - t1
# names(routes_journey)
# rnet_go_dutch_journey = overline(routes_journey, "All")
# Sys.time() - t1
# rnet_go_dutch_agg = overline(routes_journey, "All")
# Sys.time() - t1
# tm_shape(rnet_go_dutch_agg) +
#   tm_lines(lwd = 5, col = "All", breaks = c(0, 10, 100, 500, 1000), palette = "viridis")

## -----------------------------------------------------------------------------
# # ?route
# t1 = Sys.time()
# 
# 
# # load parallel stuff
# cl <- makeCluster(detectCores())
# clusterExport(cl, c("journey"))
# Sys.time() - t1
# routes_journey_par = route(l = l, route_fun = cyclestreets::journey, cl = cl) # multi-core
# stopCluster(cl) # kill cluster
# 
# Sys.time() - t1
# Sys.time() - t1
# names(routes_journey_par)
# rnet_go_dutch_journey = overline(routes_journey_par, "All")
# Sys.time() - t1
# rnet_go_dutch_agg = overline(routes_journey_par, "All")
# Sys.time() - t1
# tm_shape(rnet_go_dutch_agg) +
#   tm_lines(lwd = 5, col = "All", breaks = c(0, 10, 100, 500, 1000), palette = "viridis")

## -----------------------------------------------------------------------------
# # ?route
# t1 = Sys.time()
# 
# 
# # load parallel stuff
# library(parallel)
# library(cyclestreets)
# cl <- makeCluster(detectCores())
# clusterExport(cl, c("journey"))
# Sys.time() - t1
# routes_journey_par = route(l = l, route_fun = cyclestreets::journey, cl = cl, plan = "quietest") # multi-core
# stopCluster(cl) # kill cluster
# 
# Sys.time() - t1
# Sys.time() - t1
# names(routes_journey_par)
# rnet_go_dutch_journey = overline(routes_journey_par, "All")
# Sys.time() - t1
# rnet_go_dutch_agg = overline(routes_journey_par, "All")
# Sys.time() - t1
# tm_shape(rnet_go_dutch_agg) +
#   tm_lines(lwd = 5, col = "All", breaks = c(0, 10, 100, 500, 1000), palette = "viridis")

## -----------------------------------------------------------------------------
# routes_journey_aggregated = routes_journey %>% # already has data from data frame in there!
#   group_by(id) %>%
#   summarise(All = median(All)) %>%
#   sf::st_cast("LINESTRING")
# 
# 
# rnet_journey_dplyr = routes_journey %>% # already has data from data frame in there!
#   group_by(name, distances) %>%
#   summarise(All = sum(All))
# Sys.time() - t1
# tm_shape(rnet_journey_dplyr) +
#   tm_lines(lwd = 5, col = "All", breaks = c(0, 10, 100, 500, 1000), palette = "viridis") # quite different...
# 
# 
# rnet_journey_go_dutch = routes_journey %>%
#   group_by(start_longitude, start_latitude, finish_longitude, finish_latitude) %>%
#   summarise(All = sum(All))
# 
# 

