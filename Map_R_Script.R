library(tidycensus)
library(sf)
library(tidyverse)
library(viridis)
library(ggplot2)
library(plot)

# file to find, and write a geojson file for mapmaking in INFO: 201 final project
# Group BF-5: Angel, Rose, Miles

census_api_key("5adc81c9c101a3cbe6db02d12867966425f6e5cf", install = TRUE, overwrite = TRUE)


get_king_county_tracts <- function() {
  census_api_key("your_api_key_here", overwrite = TRUE, install = TRUE)
  
  # Fetch Census tract data for King County
  king_county_tracts <- get_acs(
    geography = "tract",
    variables = c('B01003_001'),
    state = "WA",
    county = "King",
    geometry = TRUE,
    year = 2020
  )
  
  return(king_county_tracts)
}



king_tracts_sf <- get_king_county_tracts()

king_tracts_sf$GEOID <- paste0("1400000US", king_tracts_sf$GEOID)
st_write(king_tracts_sf, "king_county_tracts.geojson")
map_sf<- st_read("king_county_tracts.geojson")