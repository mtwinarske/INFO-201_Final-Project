# Load required libraries
library(ggplot2)
library(sf)
library(dplyr)
library(maps)
library(mapproj)

options(scipen = 999)

Income_Transit_df <- read.csv("IncomeTransitAlt.csv")
map_df <- read.csv("ShapeDataKingCounty.csv")
TransitCenterLocations <- read.csv("TransitCenterLocations.csv")

ggplot(data = map_df) +
  
  geom_polygon(aes(x = Long,
                   y = Lat,
                   group = Group,
                   fill = "red")) +
  # Transit Center Locations
  geom_point(data = TransitCenterLocations) +
aes(x = Long,
    y = Lat,
    group = Group,
    color = "yellow") +
  
  coord_map()
