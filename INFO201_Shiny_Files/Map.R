library(tidycensus)
library(sf)
library(tidyverse)

library(ggplot2)
library(plotly)

TransitCenter_df <- read_csv("TransitCenterLocations.csv")
IncomeTransit_df <- read.csv("IncomeTransitAlt.csv")
map_data <- st_read("King_county_tracts.geojson")

# Transit Map
TransitUsage_map <- ggplot(map_data) +
  geom_sf(aes(fill = Estimate.Public.Transportation.Users.), linetype = 0.5, lwd = 1) +
  geom_point(data = TransitCenter_df, aes(x = Long, y = Lat)) +
  coord_sf() +
  scale_fill_gradient(low = "blue", high = "yellow")

# Carpool Map
Carpool_map <- ggplot(map_data) +
  geom_sf(aes(fill = Estimate.Car.truck.or.van.households.carpooled.), linetype = 0.5, lwd = 1) +
  geom_point(data = TransitCenter_df, aes(x = Long, y = Lat)) +
  coord_sf() +
  scale_fill_gradient(low = "blue", high = "yellow")

# Income Bracket Map
IncomeBracket_map <- ggplot(map_data) +
  geom_sf(aes(fill = median_income), linetype = 0.5, lwd = 1) +
  geom_point(data = TransitCenter_df, aes(x = Long, y = Lat)) +
  coord_sf() +
  scale_fill_gradient(low = "blue", high = "yellow")

# Display the map
plot(TransitUsage_map)
plot(IncomeBracket_map)
plot(Carpool_map)



output$map_plot <- renderPlotly({
  if (input$map_chart_type == "Total Transit Trips per Household") {
    plot_data <- data$Estimate.Public.Transportation.households.
    title_map <- "Total Public Transportation Trips per Household in King County, WA"
  } else if (input$map_chart_type == "Total People in Poverty") {
    plot_data <- data$Estimate.Car.truck.van.households.drove.
    title_map <- "Total Carpool trips per Household in King County, WA"
  } 
  
  base_map <- ggplot(map_data) +
    geom_sf(aes(fill = plot_data)) +
    coord_sf() +
    scale_fill_gradient(low = "blue", high = "yellow") +
    labs(title = title_map,
         fill = input$map_chart_type)
  
base_map  <- ggplot(map_data) +
    geom_sf(aes(fill = median_income), linetype = 0.5, lwd = 1) +
    geom_point(data = TransitCenter_df, aes(x = Long, y = Lat)) +
    coord_sf() +
    scale_fill_gradient(low = "blue", high = "yellow")+
    labs(title = title_map,
         fill = input$map_chart_type)
  
  ggplotly(base_map)
})

