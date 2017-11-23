## ---- include=FALSE------------------------------------------------------
library(stplanr)
has_internet <- curl::has_internet()
build = require("tmap") & has_internet
knitr::opts_chunk$set(eval = build)

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
tmap_mode("view")
qtm(cents, symbols.size = 5)

## ------------------------------------------------------------------------
flow_single_line = flow[4,] # select only the first line
desire_line_single = od2line(flow = flow_single_line, zones = cents)

## ------------------------------------------------------------------------
qtm(desire_line_single, lines.lwd = 5)

## ------------------------------------------------------------------------
l = od2line(flow = flow, zones = cents)
# remove 'internal flows'
sel = l$Area.of.residence == l$Area.of.workplace
l = l[!sel, ]

## ---- eval=FALSE---------------------------------------------------------
#  qtm(l)

## ------------------------------------------------------------------------
qtm(l, lines.lwd = "All", scale = 10)

## ------------------------------------------------------------------------
tm_shape(l) + tm_lines(lwd = "All", scale = 10, col = "Bicycle")

## ---- message=FALSE------------------------------------------------------
# if the next line returns FALSE the code will not run
curl::has_internet() 
r = line2route(l, route_fun = route_osrm)

## ------------------------------------------------------------------------
r@data = cbind(r@data, l@data)
tm_shape(r) + tm_lines(lwd = "All", scale = 10, col = "Bicycle")

