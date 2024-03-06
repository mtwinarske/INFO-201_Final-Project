# load packages for project
library(shiny)
library(shinythemes)
library(tidyverse)
library(tidyr)
library(plotly)
library(ggplot2)
library(sf)
library(dplyr)

setwd("INFO201_Shiny_Files")


server <- function(input, output){
    # Read data now
    data <- read.csv("IncomeTransitAlt.csv", na.strings = c("-", "**"))
    map_data <- st_read("King_county_tracts.geojson")
    TransitCenter_df <- read_csv("TransitCenterLocations.csv")
    
    ##########################################################################################################
    ################################# poverty/income-plot ####################################################
    ##########################################################################################################
    output$poverty_plot <- renderPlotly({
      if (input$chart_type == "Car/Truck/Van Driving Alone") {
        plot_data <- data[, c(11, 12, 13)]
      } else if (input$chart_type == "Public Transportation") {
        plot_data <- data[, c(27, 28, 29)]
      } else if (input$chart_type == "Carpool") {
        plot_data <- data[, c(19, 20, 21)]
      } else if (input$chart_type == "Total Poverty Status") {
        plot_data <- data[, c(7, 8, 9)]
      }
      
      below_100 <- mean(plot_data[, 1], na.rm = TRUE)
      between_100_149 <- mean(plot_data[, 2], na.rm = TRUE)
      above_150 <- mean(plot_data[, 3], na.rm = TRUE)
      
      
      poverty_plot_df <- data.frame(
        "Poverty_Status" = c("Below 100%", "100-149%", "Above 150%"),
        "Mean_Percentage" = c(below_100, between_100_149, above_150)
      )
      
      ggplot(poverty_plot_df, aes(x = Poverty_Status, y = Mean_Percentage, fill = Poverty_Status)) +
        geom_bar(stat = "identity") +
        labs(x = "Poverty Status", y = "Mean Percentage", fill = "Poverty Status",
             title = paste("Average", input$chart_type, "Distribution")) +
        theme_gray()
    })
    
    ##########################################################################################################
    ################################# vehicle-plot ###########################################################
    ##########################################################################################################
    
    output$vehicle_plot <- renderPlotly({
      if (input$vehicle_chart_type == "Car/Truck/Van Driving Alone") {
        plot_data <- data[, c(14, 15, 16, 17)]
      } else if (input$vehicle_chart_type == "Carpool") {
        plot_data <- data[, c(22, 23, 24, 25)]
      } else if (input$vehicle_chart_type == "Public Transportation") {
        plot_data <- data[, c(30, 31, 32, 33)]
      } 
      
      none <- median(plot_data[, 1], na.rm = TRUE)
      one <- median(plot_data[, 2], na.rm = TRUE)
      two <- median(plot_data[, 3], na.rm = TRUE)
      three <- median(plot_data[, 4], na.rm = TRUE)
      vehicle_plot_df <- data.frame(
        "Available_vehicles" = c("None", "One vehicle", "Two vehicles", "Three or more vehicles"),
        "Median_Percentage" = c(none, one, two, three)
      )
      
      ggplot(vehicle_plot_df, aes(x = Available_vehicles, y = Median_Percentage, fill = Available_vehicles)) +
        geom_bar(stat = "identity") +
        labs(x = "Available vehicles", y = "Median Percentage", fill = "Available vehicles",
             title = paste("Median", input$vehicle_chart_type, "Distribution")) +
        theme_gray()
    })
##########################################################################################################
################################# mapping-plots ##########################################################
##########################################################################################################
  
    output$map_plot <- renderPlotly({
      if (input$map_chart_type == "Total Public Transportation Riders") {
        plot_data <- data$Estimate.Public.Transportation.Users.
        title_map <- "Total Public Transportation Trips per Rider in King County, WA"
      } else if (input$map_chart_type == "Total People in Poverty") {
        plot_data <- data$Estimate.Total.poverty.status.determined
        title_map <- "Total Carpool trips per Household in King County, WA"
      } 
      base_map <- ggplot(map_data) +
        geom_sf(aes(fill = plot_data)) +
        geom_point(data = TransitCenter_df, aes(x = Long, y = Lat)) +
        coord_sf() +
        scale_fill_gradient(low = "brown", high = "gold") +
        labs(title = title_map,
             fill = input$map_chart_type)
      
     
      
      
      ggplotly(base_map)
    })
}


