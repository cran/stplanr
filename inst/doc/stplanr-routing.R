## ---- include = FALSE----------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup---------------------------------------------------------------
library(stplanr)

## ---- echo=FALSE, eval=FALSE---------------------------------------------
#  # upload roads data
#  if(!file.exists("roads_iow.Rds")) {
#    download.file("https://github.com/ropensci/stplanr/releases/download/0.3.1/roads_iow.Rds", "roads_iow.Rds")
#  }
#  roads_iow = readRDS("roads_iow.Rds")
#  sf::write_sf(roads_iow, "roads_iow.geojson")
#  piggyback::pb_upload("roads_iow.geojson")

## ------------------------------------------------------------------------
roads_iow = sf::read_sf("https://github.com/ropensci/stplanr/releases/download/0.3.1/roads_iow.geojson")

## ---- echo=FALSE, eval=FALSE---------------------------------------------
#  if(!file.exists("iow.pbf"))
#    download.file("http://download.geofabrik.de/europe/great-britain/england/isle-of-wight-latest.osm.pbf", "iow.pbf")
#  options(osrm.server = "http://0.0.0.0:5000/", osrm.profile = "driving")

## ---- eval=FALSE---------------------------------------------------------
#  l = pct::wight_lines_30
#  p = line2points(l)
#  r = osrm::osrmRoute(src = p[1, ], dst = p[2, ], returnclass = "sf")
#  plot(r)

## ---- eval=FALSE---------------------------------------------------------
#  route_osrm2 = function(l) {
#    p = line2points(l)
#    s = (1:nrow(l)) * 2 - 1
#    list_out = lapply(s, function(i) osrm::osrmRoute(p[i, ], dst = p[i + 1, ], returnclass = "sf"))
#    do.call(rbind, list_out)
#  }
#  routes_osrm = route_osrm2(l)
#  plot(routes_osrm)
#  # tidy up
#  file.remove("iow.pbf")

