

## OVERVIEW TAB INFO

overview_tab <- tabPanel("Overview",
   h1(""),
   p("some explanation")
)



## VIZ 1 TAB - Miles W.
## “How does geographical proximity to public transportation affect overall ridership?”

######################################################
################ Left-hand-Sidebar ###################
######################################################

viz_1_sidebar <- sidebarPanel(
  h2(""),
  radioButtons("radio", label = h3("Transit Center Presence in GEOIDs"),
               choices = list("All GEOIDs" = 1, "Present" = 2, "Absent" = 3)),
  
  hr(),
  fluidRow(column(3, verbatimTextOutput("value"))),
  p("The presence of Transit centers looks to have a massive change toward ridership numbers.")
  
)

######################################################
################### Main-Panel #######################
######################################################
viz_1_main_panel <- mainPanel(
  h2("How does access to public transportation affect overall ridership?"),
  # plotlyOutput(outputId = "your_viz_1_output_id")
)

viz_1_tab <- tabPanel("Transit Centers & KCM Ridership",
  sidebarLayout(
    viz_1_sidebar,
    viz_1_main_panel
  )
)

## VIZ 2 TAB INFO

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
 h1("Some title"),
 p("some conclusions")
)



ui <- navbarPage("Equity in Transportation",
  overview_tab,
  viz_1_tab,
  viz_2_tab,
  viz_3_tab,
  conclusion_tab
)