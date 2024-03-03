library(shiny)
library(shinythemes)

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
   img(src = "KCM-New_Flyer.jpg", height = 650, width = 1000)
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
viz_1_sidebar <- sidebarPanel(
                              h3("Map Options:"),
                              radioButtons("radio", label = strong("Transit Center Presence in GEOIDs"),
                                           choices = list("All GEOIDs" = 1, "Present" = 2, "Absent" = 3)),
                              hr(),
  
  
)

# Main Panel for Viz 1 #
viz_1_main_panel <- mainPanel(
  h2("KCM Ridership by GEOID in King County, WA"),
  # plotlyOutput(outputId = "your_viz_1_output_id")
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
  #TODO: Put inputs for modifying graph here
)

viz_2_main_panel <- mainPanel(
  h2("Vizualization 2 Title"),
  # plotlyOutput(outputId = "your_viz_1_output_id")
)

viz_2_tab <- tabPanel("Economics & Ridership",
  sidebarLayout(
    viz_2_sidebar,
    viz_2_main_panel
  )
)

## VIZ 3 TAB INFO

viz_3_sidebar <- sidebarPanel(
  h2("Options for graph"),
  #TODO: Put inputs for modifying graph here
)

viz_3_main_panel <- mainPanel(
  h2("Vizualization 3 Title"),
  # plotlyOutput(outputId = "your_viz_1_output_id")
)

viz_3_tab <- tabPanel("Mode availability & Mode Choice",
  sidebarLayout(
    viz_3_sidebar,
    viz_3_main_panel
  )
)

## CONCLUSIONS TAB INFO

conclusion_tab <- tabPanel("Analysis Results",
 h1("What did we learn?"),
 p("some conclusions")
)



ui <- navbarPage("Equity in Transportation",
  overview_tab,
  viz_1_tab,
  viz_2_tab,
  viz_3_tab,
  conclusion_tab
)