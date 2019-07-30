library(stplanr)

z = zones_sf
mapview::mapview(z) +
  mapview::mapview(flowlines) +
  mapview::mapview(routes_fast_sf)

mapview::mapview(route_network_sf)

library(tmap)
ttm()

tm_shape(flowlines_sf) +
  tm_lines(col = "Bicycle", lwd = "All", palette = "viridis", scale = 9)


tm_shape(flowlines_sf) +
  tm_lines(col = "Bicycle", lwd = "All", palette = "viridis", scale = 9)

library(mapedit)
points = mapedit::drawFeatures()
mapview::mapview(points)
l = points2line(points)
mapview::mapview(l)
l = l[l$D == 475, ]
plot(l)
l$v = 1
r = line2route(l)
r$v = 1
rnet = overline2(r, "v")
mapview::mapview(r)
mapview::mapview(rnet, lwd = "v")
mapview::mapview(l)

tm_shape(rnet) +
  tm_lines(lwd = "v", scale = 9)
