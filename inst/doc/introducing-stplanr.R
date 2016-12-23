## ---- include=FALSE------------------------------------------------------
library(stplanr)

## ---- eval=FALSE---------------------------------------------------------
#  install.packages("stplanr")

## ---- eval=FALSE---------------------------------------------------------
#  devtools::install_github("ropensci/stplanr")

## ------------------------------------------------------------------------
library(stplanr)

## ------------------------------------------------------------------------
od_eg = read.csv(text = 
  "origin, destination, V1, V2
  1, 2, 100, 3
  1, 3, 50, 5"
  )
knitr::kable(od_eg)

## ------------------------------------------------------------------------
data("flow") # load the 'flow' dataset from the stplanr package
head(flow[c(1:3, 12)])

## ------------------------------------------------------------------------
data("cents") # load the 'cents' dataset
head(cents)

## ------------------------------------------------------------------------
library(tmap)
osm_tiles = read_osm(bb(cents, 1.4))
(map = qtm(osm_tiles) +
  qtm(cents, symbols.size = 5) )

## ------------------------------------------------------------------------
flow_single_line = flow[4,] # select only the first line
desire_line_single = od2line(flow = flow_single_line, zones = cents)

## ------------------------------------------------------------------------
map +
  qtm(desire_line_single, lines.lwd = 5)

## ------------------------------------------------------------------------
l = od2line(flow = flow, zones = cents)

## ---- eval=FALSE---------------------------------------------------------
#  map +
#    qtm(l)

## ------------------------------------------------------------------------
map +
  tm_shape(l) + tm_lines(lwd = "All", scale = 10)

## ------------------------------------------------------------------------
map +
  tm_shape(l) + tm_lines(lwd = "All", scale = 10, col = "Bicycle")

## ---- eval=FALSE---------------------------------------------------------
#  r = line2route(l) # requires the a cyclestreets.net API key

## ---- echo=FALSE---------------------------------------------------------
r = routes_fast

## ------------------------------------------------------------------------
r@data = cbind(r@data, l@data)
map +
  tm_shape(r) + tm_lines(lwd = "All", scale = 10, col = "Bicycle")

