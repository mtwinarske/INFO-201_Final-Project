library(tidycensus)
library(sf)
library(tidyverse)
library(viridis)
library(ggplot2)
library(plot)

TransitCenter_df <- read_csv("TransitCenterLocations.csv")
IncomeTransit_df <- read.csv("IncomeTransitAlt.csv")
map_info <- st_read("king_county_tracts.geojson")


map_joined_info <- left_join(map_info, IncomeTransit_df, by = "GEOID")

# Calculate the actual minimum and maximum values of transit users
min_users <- min(map_df$Estimate.Public.Transportation.Users., na.rm = TRUE)
max_users <- max(map_df$Estimate.Public.Transportation.Users., na.rm = TRUE)

# Transit Map
TransitUsage_map <- ggplot(map_joined_info) +
  geom_sf(aes(fill = Estimate.Public.Transportation.Users.), linetype = 0.5, lwd = 1) +
  geom_point(data = TransitCenter_df, aes(x = Long, y = Lat)) +
  coord_sf() +
  scale_fill_gradient(low = "blue", high = "yellow")

# Carpool Map
Carpool_map <- ggplot(map_joined_info) +
  geom_sf(aes(fill = Estimate.Car.truck.or.van.households.carpooled.), linetype = 0.5, lwd = 1) +
  geom_point(data = TransitCenter_df, aes(x = Long, y = Lat)) +
  coord_sf() +
  scale_fill_gradient(low = "blue", high = "yellow")

# Income Bracket Map
IncomeBracket_map <- ggplot(map_joined_info) +
  geom_sf(aes(fill = median_income), linetype = 0.5, lwd = 1) +
  geom_point(data = TransitCenter_df, aes(x = Long, y = Lat)) +
  coord_sf() +
  scale_fill_gradient(low = "blue", high = "yellow")

# Display the map
plot(TransitUsage_map)
plot(IncomeBracket_map)
plot(Carpool_map)




