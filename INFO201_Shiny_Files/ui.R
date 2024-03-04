library(shiny)
library(shinythemes)
library(tidycensus)
library(tidyverse)
library(plotly)


######################################################
################### Overview-Tab #####################
######################################################
overview_sidebar <- sidebarPanel(
          
# Research Questions
                                 h3("Research Questions:"),
                                 p("How does geographical proximity to public transportation affect overall ridership?"),
                                 p("How does vehicle ownership & the number of vehicles owned affect transit usage?"),
                                 p("How do income & poverty impact usage?"),
# Data used and Sources
                                 h3("Data used & Sources:"),
                                 strong("Datasets:"),
                                 p("Means of Transport to Work", 
                                   a("https://data.census.gov/table/ACSST5Y2022.S0802?g=050XX00US53033$1400000")),
                                 p("Median Income in the Past 12 Months",
                                   a("https://data.census.gov/table/ACSST5Y2022.S1903?g=050XX00US53033$1400000")),
                                 p("Equivalencing ZIP Code and Census Tract Geographies",a("https://proximityone.com/ziptractequiv.htm")),
                                 strong("Supplemental refererences:"),
                                 p("Income Bracket Reference",
                                   a("https://www.bls.gov/news.release/wkyeng.nr0.htm")),
                                 p("King County Transit Center Zipcodes",
                                   a("https://kingcounty.gov/en/dept/metro/routes-and-service/schedules-and-maps")),
                                 p("Income Bracket Calculation Help",
                                   a("https://stackoverflow.com/questions/12979456/categorize-numeric-variable-into-group-bins-breaks")),
# Data Collection & Ethical Implications
                                 h3("Data Collection & Ethical Implications:"),
                                 p("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod
                                   tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
                                   quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
                                   Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat
                                   nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia
                                   deserunt mollit anim id est laborum."),
                                 
                                 
  
)

overview_main_panel <- mainPanel(
   h2("An Observational Analysis of Equity in the KCM System"),
   h4("Angel Hill, Rose Garly, & Miles Winarske"),
   br(),
   img(src = "KCM-New_Flyer.jpg", height = 650, width = 1000),
   h6("Image Source:",
     a("https://www.flickr.com/photos/brasegaliwa/12870751595/"))
)
overview_tab <- tabPanel("Overview",
                         fluidPage(
                           theme = shinytheme("sandstone"),
                         ),
                      sidebarLayout(
                        overview_sidebar,
                        overview_main_panel
                        )
)


######################################################
#################### VIZ-1-Tab #######################
######################################################

# Sidebar for Viz 1 #
viz_1_sidebar <- sidebarPanel(h3("How is the proximity to TCs relevant?"),
                              p("Transit Centers act as regional hubs that offer many different bus routes,
                                and help connect cities in a web of low-cost public transit. "),
                              h3("Observational Analysis:"),
                              p("By visualizing the dataset for ridership numbers, and observing the decrease in
                                ridership as distance increases, we can infer that people are discouraged to take
                                public transportation due to the low accessability. This visualization suggests that
                                by increasing the amount of transit centers, or by increasing the frequency of bus trips,
                                we may be able to boost ridership numbers."),
                              h3("Map Options:"),
                              radioButtons("radio", label = strong("Transit Center Presence in GEOIDs"),
                                           choices = list("All GEOIDs" = 1, "Present" = 2, "Absent" = 3)),
                              hr(),
  
  
)

# Main Panel for Viz 1 #
viz_1_main_panel <- mainPanel(
  h2("Ridership numbers & Transit Centers in King County, WA", align = "center"),
  plotlyOutput(outputId = "your_viz_1_output_id")
)

# Tab label and Format of Viz 1 #
viz_1_tab <- tabPanel("Geography & Ridership",
  sidebarLayout(
    viz_1_sidebar,
    viz_1_main_panel
  )
)

######################################################
#################### VIZ-2-Tab #######################
######################################################

viz_2_sidebar <- sidebarPanel(
  h2("Options for graph"),
  selectInput("chart_type", "Select Mode of Transport",
  choices = c("Car/Truck/Van Driving Alone", "Public Transportation", "Carpool", "Total Poverty Status"))
)

viz_2_main_panel <- mainPanel(
  h2("Economic Background & Transit Ridership in King County, WA", align = "center"),
  # plotlyOutput(outputId = "poverty_plot")
)

viz_2_tab <- tabPanel("Poverty Status Distribution",
  sidebarLayout(
    viz_2_sidebar,
    viz_2_main_panel,
  ))

######################################################
#################### VIZ-3-Tab #######################
######################################################

#viz 3 sidebar
viz_3_sidebar <- sidebarPanel(
  h2("Options for graph"),
  #TODO: Put inputs for modifying graph here
)

# viz 3 main panel
viz_3_main_panel <- mainPanel(
  h2("Vizualization 3 Title"),
  # plotlyOutput(outputId = "your_viz_1_output_id")
)

# layout for viz_3_tab
viz_3_tab <- tabPanel("Mode availability & Mode Choice",
  sidebarLayout(
    viz_3_sidebar,
    viz_3_main_panel))

######################################################
################### Conclusion-Tab ###################
######################################################

conclusion_tab <- tabPanel("Analysis Results",
 h1("What did we learn?"),
 p("some conclusions"))

######################################################
################### Sources-Tab ######################
######################################################

sources_sidebar <- sidebarPanel(
  h2("Text here"))

sources_main_panel <- mainPanel(
  h2("Sources"))

sources_tab <- tabPanel("Project Sources",
                      sidebarLayout(
                        sources_sidebar,
                        sources_main_panel
                      ))




ui <- navbarPage("Equity in Transportation",
  overview_tab,
  viz_1_tab,
  viz_2_tab,
  viz_3_tab,
  conclusion_tab,
  sources_tab
)