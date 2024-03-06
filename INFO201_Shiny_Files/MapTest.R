library(shiny)
library(shinythemes)
library(tidycensus)
library(sf)
library(tidyverse)
library(viridis)
library(ggplot2)
library(plotly)

map_sf<- st_read("king_county_tracts.geojson")

ui <- fluidPage(
  titlePanel("Interactive Map"),
  selectInput("map_view", "Select Map View:",
               choices = c("Total Household Carpools", "Transit Ridership", "Average Income Bracket")),
  radioButtons("transit_centers", "Transit Ceners:",
               ),
  plotOutput("my_map"),
  textOutput("map_title") # writing a placeholder for the dynamic map title here
)

server <- function(input, output) {
  # Load your map data and create the initial map (e.g., my_map)

  
  
  output$my_map <- renderPlot({
    if (input$map_view == "Total Household Carpools") {
      
      Carpool_map <- ggplot(map_df) +
        geom_sf(aes(fill = ),  linetype = 1, lwd = 1) +
        geom_point(data = TransitCenter_df, aes(x = Long, y = Lat)) +
        coord_sf() +
        scale_fill_gradient(low = "gray30", high = "gray90")
      
      # Carpool Map
      
    } else if (input$map_view == "Transit Ridership") {
      # Replace with your actual code
      Transit_Ridership_map <- ggplot(map_df) +
        geom_sf(aes(fill = Estimate.Public.Transportation.Users.), linetype = 1, lwd = 1) +
        geom_point(data = TransitCenter_df, aes(x = Long, y = Lat)) +
        coord_sf() +
        scale_fill_gradient(low = "gray30", high = "gray90")  
      
      # Transit Ridership Map
    
      } else {
        Income_Bracket_Map <- ggplot(map_df) +
          geom_sf(aes(fill = incomeBracket), linetype = 1, lwd = 1) +
          geom_point(data = TransitCenter_df, aes(x = Long, y = Lat)) +
          coord_sf() +
          scale_fill_gradient(low = "gray30", high = "gray90")
      my_map <- ggplot(...)  # Your land use map
    }
    
    my_map
  })
}

shinyApp(ui, server)
