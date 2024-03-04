library(shiny)
library(shinythemes)
library(tidycensus)
library(tidyverse)
library(plotly)
library(ggplot2)

server <- function(input, output){
  plot_data <- read.csv("IncomeTransitAlt.csv", na.strings = c("-", "**"))
  Transit.Center_df <- read_csv("TransitCenterLocations.csv")
  
  
    # You can access the values of the widget (as a vector)
    # with input$radio, e.g.
    
    output$poverty_plot <- renderPlot({
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
      
      
      plot_df <- data.frame(
        "Poverty_Status" = c("Below 100%", "100-149%", "Above 150%"),
        "Mean_Percentage" = c(below_100, between_100_149, above_150)
      )
      
      ggplot(plot_df, aes(x = Poverty_Status, y = Mean_Percentage, fill = Poverty_Status)) +
        geom_bar(stat = "identity") +
        labs(x = "Poverty Status", y = "Mean Percentage", fill = "Poverty Status",
             title = paste("Average", input$chart_type, "Distribution")) +
        theme_minimal()
    })
    
}

