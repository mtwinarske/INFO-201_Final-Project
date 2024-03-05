library(tidycensus)
library(sf)
library(tidyverse)
library(viridis)
library(ggplot2)
library(plot)

TransitCenter_df <- read_csv("TransitCenterLocations.csv")
IncomeTransit_df <- read.csv("IncomeTransitAlt.csv")
KingCountyCensusShapes_df <- read_csv("KingCountyCensusShapes.csv")
census_api_key("5adc81c9c101a3cbe6db02d12867966425f6e5cf", install = TRUE, overwrite = TRUE)

v17 <- load_variables(2020, "acs5", cache = TRUE)
view(v17)

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

my_sf <- st_as_sf(king_tracts_df, coords = c("Lon", "lat"), crs = 4326)


king_tracts_df <- as.data.frame(king_tracts_sf)

king_tracts_sf <- get_king_county_tracts()

write_csv("king_tracts_sf.csv")

KingCountyCensusShapes_df$GEOID <- paste0("1400000US", KingCountyCensusShapes_df$GEOID)


king_tracts_sf$GEOID <- paste0("1400000US", king_tracts_sf$GEOID)
map_df <- left_join(king_tracts_sf, IncomeTransit_df, by = "GEOID")

# Calculate the actual minimum and maximum values of transit users
min_users <- min(map_df$Estimate.Public.Transportation.Users., na.rm = TRUE)
max_users <- max(map_df$Estimate.Public.Transportation.Users., na.rm = TRUE)

# Create the map
TransitCenter_map <- ggplot(map_df) +
  geom_sf(aes(fill = Estimate.Public.Transportation.Users.), linetype = 1, lwd = 1) +
  geom_point(data = TransitCenter_df, aes(x = Long, y = Lat)) +
  coord_sf() +
  scale_fill_gradient(low = "gray30", high = "gray90")

# Display the map
plot(TransitCenter_map)





