library(shiny)

source("ui.R")
source("server.R")

shinyApp(ui = ui, server = server)

rsconnect::setAccountInfo(name='ahill132',
                          token='9A5EE93575E3930780A0B48915AB5F2D',
                          secret='KjDxjfA64dx1pE2Q3GFrjr2qoaVVg952ptN6pUNU')

rsconnect::deployApp(appName = "IncomeTransit",
                     appFiles = "https://github.com/mtwinarske/INFO-201_Final-Project/tree/main/INFO201_Shiny_Files",
                     launch.browser = TRUE)