library(tidycensus)
library(sf)
library(tidyverse)
library(viridis)
library(ggplot2)
library(plot)

# file to find, and write a geojson file for mapmaking in INFO: 201 final project
# Group BF-5: Angel, Rose, Miles
TransitCenter_df <- read_csv("TransitCenterLocations.csv")
IncomeTransit_df <- read.csv("IncomeTransitAlt.csv")

map_unjoined_data <- st_read("2020CensusTracts.geojson")
map_unjoined_data$GEOID <- paste0("1400000US", map_unjoined_data$GEOID)
map_joined_data <-  full_join( IncomeTransit_df, map_unjoined_data, by = "GEOID")

st_write(map_joined_data, "king_county_tracts.geojson")
map_data<- st_read("king_county_tracts.geojson")
