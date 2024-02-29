library(shinythemes)

######################################################
################### Overview-Tab #####################
######################################################
overview_tab <- tabPanel("Overview",
   h2("An Observational Analysis of Equity in KCM System", align = "center"),
   h4("Angel Hill, Rose Garly, and Miles Winarske", align = "center"),
   br(),
   h4("What questions are we seeking to answer?"),
   p("How does geographical proximity to public transportation affect overall ridership?"),
   p("How does vehicle ownership & the number of vehicles owned affect transit usage?"),
   p("How do income & poverty impact usage?"),
   
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
  fluidRow(column(3, verbatimTextOutput("value"))),
  
  
)

# Main Panel for Viz 1 #
viz_1_main_panel <- mainPanel(
  h2("KCM Ridership by GEOID in King County, WA", align = "center"),
  # plotlyOutput(outputId = "your_viz_1_output_id")
)

# Tab label and Format of Viz 1 #
viz_1_tab <- tabPanel("Transit Centers & KCM Ridership",
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

viz_2_tab <- tabPanel("Viz 2 tab title",
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

viz_3_tab <- tabPanel("Viz 3 tab title",
  sidebarLayout(
    viz_3_sidebar,
    viz_3_main_panel
  )
)

## CONCLUSIONS TAB INFO

conclusion_tab <- tabPanel("Project Findings",
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