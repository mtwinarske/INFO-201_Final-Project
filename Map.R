library(tidycensus)
library(sf)
library(tidyverse)
library(viridis)
census_api_key("5adc81c9c101a3cbe6db02d12867966425f6e5cf", install = TRUE, overwrite=TRUE)  # Install for future R sessions
readRenviron("~/.Renviron")
Sys.getenv("CENSUS_API_KEY")

TransitCenter_df <- read_csv("TransitCenterLocations.csv")

get_king_county_tracts <- function() {
  # Set your Census API key (replace with your actual key)
  census_api_key("5adc81c9c101a3cbe6db02d12867966425f6e5cf", install = TRUE, overwrite = TRUE)
  
  # Fetch Census tract data for King County
  king_county_tracts <- get_acs(
    geography = "tract",
    variables = c('B01001_020E'),
    state = "WA",
    county = "King",
    geometry = TRUE,
    year = 2020
  )
  
  return(king_county_tracts)
}


king_tracts_sf <- get_king_county_tracts()
plot(king_tracts_sf ['geometry'])

TransitCenter_map <- ggplot(king_tracts_sf) +
  geom_sf() +  # Plot the Census tract shapes
  geom_point(data = TransitCenter_df, aes(x = Long,
                                          y = Lat, 
                                          color = "red")) +
  coord_map("mercator")

plot(TransitCenter_map ['geometry'])
