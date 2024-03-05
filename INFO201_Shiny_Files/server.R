library(shiny)
library(shinythemes)
library(tidycensus)
library(tidyverse)
library(plotly)
library(ggplot2)

server <- function(input, output){
  data <- read.csv("IncomeTransitAlt.csv", na.strings = c("-", "**"))
  
    # You can access the values of the widget (as a vector)
    # with input$radio, e.g.
    
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
    
# vehicle plot
    
    output$vehicle_plot <- renderPlotly({
      if (input$chart_type == "Car/Truck/Van Driving Alone") {
        plot_data <- data[, c(14, 15, 16, 17)]
      } else if (input$chart_type == "Public Transportation") {
        plot_data <- data[, c(22, 23, 24, 25)]
      } else if (input$chart_type == "Carpool") {
        plot_data <- data[, c(30, 31, 32, 33)]
      } 
      
      none <- mean(plot_data[, 1], na.rm = TRUE)
      one <- mean(plot_data[, 2], na.rm = TRUE)
      two <- mean(plot_data[, 3], na.rm = TRUE)
      three <- mean(plot_data[, 4], na.rm = TRUE)
      
      vehicle_plot_df <- data.frame(
        "Available_vehicles" = c("None", "One vehicle", "Two vehicles", "Three or more vehicles"),
        "Mean_Percentage" = c(none, one, two, three)
      )
      
      ggplot(vehicle_plot_df, aes(x = Available_vehicles, y = Mean_Percentage, fill = Available_vehicles)) +
        geom_bar(stat = "identity") +
        labs(x = "Available vehicles", y = "Mean Percentage", fill = "Available vehicles",
             title = paste("Average", input$chart_type, "Distribution")) +
        theme_minimal()
    })
}

