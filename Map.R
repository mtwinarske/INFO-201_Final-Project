library(tidycensus)
library(sf)
library(tidyverse)
library(viridis)
census_api_key("5adc81c9c101a3cbe6db02d12867966425f6e5cf", install = TRUE, overwrite=TRUE)  # Install for future R sessions
readRenviron("~/.Renviron")
Sys.getenv("CENSUS_API_KEY")

library(tidycensus)
library(sf)

get_king_county_tracts <- function() {
  # Set your Census API key (replace with your actual key)
  census_api_key("5adc81c9c101a3cbe6db02d12867966425f6e5cf", install = TRUE)
  
  # Fetch Census tract data for King County
  king_county_tracts <- get_decennial(
    geography = "tract",
    state = "WA",
    county = "King",
    geometry = TRUE,
    year = 2020
  )
  
  return(king_county_tracts)
}

# Call the custom function to get King County tract shapes
king_tracts_sf <- get_king_county_tracts()

# Now you can explore and visualize the data (e.g., create maps)
# For example:
plot(king_tracts_sf["geometry"])
