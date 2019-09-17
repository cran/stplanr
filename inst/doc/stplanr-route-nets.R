## ---- include = FALSE----------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup, message=FALSE------------------------------------------------
library(stplanr)

## ---- out.width="40%", fig.show='hold', fig.width=5, message=FALSE-------
sample_routes = routes_fast_sf[2:6, NULL]
sample_routes$value = rep(1:3, length.out = 5)
rnet = overline2(sample_routes, attrib = "value")
plot(sample_routes["value"], lwd = sample_routes$value, main = "Routes")
plot(rnet["value"], lwd = rnet$value, main = "Route network")

## ----rnets1, message=FALSE, warning=FALSE, out.width="100%", fig.width=6, fig.height=6, echo=FALSE----
# knitr::include_graphics("route-networks.png")

## ---- message=FALSE, warning=FALSE, out.width="100%", fig.width=6, fig.height=6, echo=FALSE, eval=FALSE----
#  library(tmap)
#  # sample_routes = routes_fast_sf
#  # sample_routes$id <- 1:nrow(sample_routes)
#  # sample_routes <- sample_routes[!is.na(sample_routes$plan),]
#  sample_routes = routes_fast_sf[c(22,38,39,46,47), NULL]
#  sample_routes$type = " Routes"
#  v = 1:5
#  n = c(2, 3, 5)
#  # route_list = purrr::map(n, ~sample_routes[1:., ])
#  route_list = lapply(n, function(x) {
#    l = sample_routes[1:x, ]
#    l$n = x
#    l$value = rep(v, length.out = x)
#    l
#    }
#  )
#  routes_all = do.call(rbind, route_list)
#  # rnet_list = purrr::map(route_list, function(x) {
#  rnet_list = lapply(route_list, function(x) {
#    l = overline2(x, "value")
#    l$n = mean(x$n)
#    l
#    }
#  )
#  rnet_all = do.call(rbind, rnet_list)
#  rnet_all$type = "Route network"
#  all_routes = rbind(routes_all, rnet_all)
#  p = sf::st_centroid(all_routes)
#  tmap_mode("plot")
#  m = tm_shape(all_routes, bbox = tmaptools::bb(all_routes)) +
#    tm_lines(col = "value", lwd = 1, palette = "OrRd", scale = 8, alpha = 0.8, breaks = 0:6,
#             legend.lwd.show = FALSE, labels = as.character(1:6),
#             legend.col.show = FALSE) +
#    tm_text("value") +
#    tm_facets(by = c("n", "type")) +
#    tm_layout(scale = 1.5)
#  #m
#  tmap_save(m, "vignettes/route-networks.png")

## ---- eval=FALSE, echo=FALSE---------------------------------------------
#  # test code:
#  
#  sample_routes2 = sample_routes5[2:3, ]
#  sample_routes3 = sample_routes5[2:4, ]
#  rnet2 = overline2(sample_routes2, attrib = "value")
#  rnet3 = overline2(sample_routes3, attrib = "value")
#  rnet5 = overline2(sample_routes5, attrib = "value")
#  
#  b = 0:6
#  bb = tmaptools::bb(rnet, ext = 1.1)
#  
#  rnet5$n = 5
#  rnet5$type = "Route network"
#  sample_routes5$n = 5
#  sample_routes5$type = " Routes"
#  
#  all_routes = rbind(rnet5, sample_routes5)
#  
#  m2 = tm_shape(sample_routes[1:2, ], bbox = bb) +
#    tm_lines(col = "value", lwd = "value", palette = "magma", scale = 8, alpha = 0.5, breaks = b) +
#    tm_layout(title = "2 Routes", legend.show = FALSE)
#  r2 = tm_shape(rnet2, bbox = bb) +
#    tm_lines(col = "value", palette = "viridis", scale = 10, alpha = 0.5, breaks = b,
#             legend.lwd.show = FALSE, labels = as.character(1:6))
#  m3 = tm_shape(sample_routes[1:3, ], bbox = bb) +
#    tm_lines(col = "value", lwd = "value", palette = "viridis", scale = 15, alpha = 0.5, breaks = b) +
#    tm_layout(title = "3 Routes", legend.show = FALSE)
#  r3 = tm_shape(rnet3, bbox = bb) +
#    tm_lines(col = "value", palette = "viridis", scale = 8, alpha = 0.5, breaks = b) +
#    tm_layout(legend.show = FALSE)
#  m6 = tm_shape(sample_routes, bbox = bb) +
#    tm_lines(col = "value", lwd = "value", palette = "viridis", scale = 10, alpha = 0.5, breaks = b) +
#    tm_layout(title = "6 Routes", legend.show = FALSE)
#  r6 = tm_shape(rnet, bbox = bb) +
#    tm_lines(col = "value", palette = "viridis", scale = 8, alpha = 0.5, breaks = b) +
#    tm_layout(legend.show = FALSE)
#  
#  
#  
#  tmap_arrange(m2, r2, m3, r3, m6, r6, nrow = 3)
#  
