ui <- fluidPage(
  titlePanel("Chart Type Selection"),
  
  sidebarLayout(
    sidebarPanel(
      radioButtons("chart_type", label = h3("Select Chart Type:"),
                   choices = c("Car/Truck/Van Driving Alone",
                               "Public Transportation",
                               "Carpool"),
                   selected = "Car/Truck/Van Driving Alone")
    ),
    
    mainPanel(
      plotOutput("vehicle_plot")
    )
  )
)

server <- function(input, output) {
  data <- read.csv("IncomeTransitAlt.csv", na.strings = c("-", "**"))
  
  output$vehicle_plot <- renderPlot({
    if (input$chart_type == "Car/Truck/Van Driving Alone") {
      plot_data <- data[, c(14, 15, 16, 17)]
    } else if (input$chart_type == "Public Transportation") {
      plot_data <- data[, c(22, 23, 24, 25)]
    } else if (input$chart_type == "Carpool") {
      plot_data <- data[, c(30, 31, 32, 33)]
    } else if (input$chart_type == "Total Poverty Status") {
      plot_data <- data[, c(7, 8, 9)]
    }
    
    none <- mean(plot_data[, 1], na.rm = TRUE)
    one <- mean(plot_data[, 2], na.rm = TRUE)
    two <- mean(plot_data[, 3], na.rm = TRUE)
    three <- mean(plot_data[, 4], na.rm = TRUE)
    
    plot_df <- data.frame(
      "Available_vehicles" = c("None", "One vehicle", "Two vehicles", "Three or more vehicles"),
      "Mean_Percentage" = c(none, one, two, three)
    )
    
    ggplot(plot_df, aes(x = Available_vehicles, y = Mean_Percentage, fill = Available_vehicles)) +
      geom_bar(stat = "identity") +
      labs(x = "Available vehicles", y = "Mean Percentage", fill = "Available vehicles",
           title = paste("Average", input$chart_type, "Distribution")) +
      theme_minimal()
  })
}

shinyApp(ui = ui, server = server)