library(tidycensus)
library(sf)
library(tidyverse)
library(viridis)
library(ggplot2)
library(plot)

TransitCenter_df <- read_csv("TransitCenterLocations.csv")
IncomeTransit_df <- read.csv("IncomeTransitAlt.csv")
KingCountyCensusShapes_df <- read_csv("KingCountyCensusShapes.csv")


get_king_county_tracts <- function() {
  census_api_key("5adc81c9c101a3cbe6db02d12867966425f6e5cf", install = TRUE, overwrite = TRUE)
  
  # Fetch Census tract data for King County
  king_county_tracts <- get_decennial(
    geography = "tract",
    variables = c('P0010001'),
    state = "WA",
    county = "King",
    geometry = TRUE,
    year = 2020
  )
  
  return(king_county_tracts)
}




king_tracts_sf <- get_king_county_tracts()



KingCountyCensusShapes_df$GEOID <- paste0("1400000US", KingCountyCensusShapes_df$GEOID)


king_tracts_sf$GEOID <- paste0("1400000US", king_tracts_sf$GEOID)
map_df <- left_join(KingCountyCensusShapes_df, IncomeTransit_df, by = "GEOID")

# Calculate the actual minimum and maximum values of transit users
min_users <- min(map_df$Estimate.Public.Transportation.Users., na.rm = TRUE)
max_users <- max(map_df$Estimate.Public.Transportation.Users., na.rm = TRUE)

# Create the choropleth map with dynamic color scale
TransitCenter_map <- ggplot(KingCountyCensusShapes_df) +
  geom_polygon(aes(x = Long,
                   y = Lat,
                   group = group),
                   color = "black",
                   fill = NA) + coord_map()


geom_point(data = TransitCenter_df, aes(x = Long, y = Lat)) +
  coord_map() +
  scale_fill_gradient(low = "blue", high = "green")

# Display the map
plot(TransitCenter_map)





