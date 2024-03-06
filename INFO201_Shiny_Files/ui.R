library(shiny)
library(shinythemes)
library(tidycensus)
library(tidyverse)
library(plotly)
library(ggplot2)

######################################################
################### Overview-Tab #####################
######################################################
overview_sidebar <- sidebarPanel(
          
# Research Questions
                                 h3("Research Questions:"),
                                 p("1) How does geographical proximity to public transportation affect overall ridership?"),
                                 p("2) How do income & poverty impact usage?"),
                                 p("3) How does vehicle ownership & the number of vehicles owned affect transit usage?"),
# Data used and Sources
                                 h3("Background"),
                                 strong("History"),
                                 p("From carriages to trolleys, from the monorail to the light rail, 
                                 Seattle’s history of public transportation is rich yet complex. Though 
                                 our city has made significant strides in the evolution of our railways 
                                 and public metro, disparities in access to transportation still exist in 
                                 modern day Seattle. Our project aims to examine the historical and 
                                 contemporary relationship between class and access to transportation throughout
                                 the greater Seattle area."),
                                 strong("Data is inherently biased"),
                                 p("Renters and certain demographic groups are often underrepresented in census data
                                   collection. For this reason our data, which aims to understand the relationship
                                   between transit usage and income, may be impacted by the undercounting of those
                                   which are likely in the lower financial brackets such as renters. Additionally,
                                   this data also only collects information from King County households, which may
                                   leave out workers that travel from other counties to work in King County."))



# Data Collection & Ethical Implications
h4(HTML("<b>Issues With Our Data: </b>"))
p("Renters and certain demographic groups are often underrepresented in census data collection. 
    For this reason our data, which aims to understand the relationship between transit usage and 
    income, may be impacted by the undercounting of those which are likely in the lower financial brackets 
    such as renters. Additionally, this data also only collects information from King County households, 
    which may leave out workers that travel from other counties to work in King County.")
                                 
                                 
  

overview_main_panel <- mainPanel(
   h2("An Observational Analysis of Equity in the KCM System"),
   h4("Angel Hill, Rose Garly, & Miles Winarske"),
   br(),
   img(src = "KCM-New_Flyer.jpg", height = 625, width = 1000),
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
  h2("Our Question: How Does Poverty Status Vary Across Different Modes of Transportation?"),
  selectInput("chart_type", 
              "Select Mode of Transport",
  choices = c("Car/Truck/Van Driving Alone", "Public Transportation", "Carpool", "Total Poverty Status")),
  p("This chart aims to illustrate the mode of transport based on the poverty status of individuals. 
  The graph illustrates how poverty status varies across different transportation modes. By examining the distribution, 
  we can identify patterns regarding how poverty intersects with transportation dependencies. Understanding this distribution can offer 
  insights into economic disparities and accessibility issues related to transportation options. Policymakers and urban planners 
    can use this information to influence the future of King County’s transportation system in an equitable and inclusive manner.")
)


viz_2_main_panel <- mainPanel(
  h2("Economic Background & Transit Ridership in King County, WA", align = "center"),
  plotlyOutput("poverty_plot")
)

viz_2_tab <- tabPanel("Poverty Status Distribution",
  sidebarLayout(
    viz_2_sidebar,
    viz_2_main_panel,
  ))

######################################################
#################### VIZ-3-Tab #######################
######################################################

viz_3_sidebar <- sidebarPanel(
  h2("Chart type selection"),
  radioButtons("radio",
               h3("Select Mode of Transport"),
               choices = list("Car/Truck/Van Driving Alone",
                              "Public Transportation",
                              "Carpool"),
               selected = "Car/Truck/Van Driving Alone"),
  h3("How is vehicle availability relevant?"),
  p("The United States as a nation is heavily reliant on vehicles for transportation,
  as much of our infrastructure centers around cars. However, this was not always the case,
  as the railroad efforts in the United States were a major development and certainly set up
  hopes for a promising American railway system. The rise of the motor vehicle following the
  Second World War sidelined our progress with railway development, and as vehicles became more
  accessible over the 20th century, dreams of a robust American railway were nearly forgotten.
  Access to vehicles is far more limited for those within our community who are economically
  disadvantaged. Thus, public transportation is essential for a significant portion of our
  population. Despite this, access to public transportation is limited even in large metropolitan
  areas. This limited access to both public and motor vehicle transportation disproportionately 
  affects disadvantaged communities."),
)

# viz 3 main panel
viz_3_main_panel <- mainPanel(
  h2("Transit Usage & Vehicles Availible in Household"),
  plotlyOutput("vehicle_plot")
)

# layout for viz_3_tab
viz_3_tab <- tabPanel("Mode availability & Mode Choice",
  sidebarLayout(
    viz_3_sidebar,
    viz_3_main_panel
  ))

######################################################
################### Conclusion-Tab ###################
######################################################

# Sidebar content
conclusion_sidebar <- sidebarPanel(
  br(),
  img(src = "1436294.jpg", height = 208, width = 333),
  h6("Image Source:",
     a("https://www.stocksy.com/1436294/seattle-skyline-at-sunset-with-mount-rainier-in-the-background")),
  h3("Method"),
  p("In this analysis, we employed a combination of data visualization techniques
    and statistical methods to investigate the factors influencing public 
    transportation ridership."),
  h3("Analysis"),
  p("Our analysis focused on three main aspects: the impact of geographical
    proximity to public transportation, the influence of income and poverty levels,
    and the relationship between vehicle ownership and transit usage.")
)

# Main panel content
conclusion_main_panel <- mainPanel(
  h1("What did we learn?"),
  p("Gentrification is a major issue within Seattle, as it is the third most gentrifying
  city in the nation. Looking into this issue in the context of transportation, we have
  become glaringly aware that even positive urban planning outcomes have influenced 
  change within the city. The development of the light rail has resulted in further
  displacement of locals, as TOD (Transit Oriented Development), led to higher development
  in the regions it was available. Therefore, access to public transportation may lead to the
  destruction of the local populations that actually rely on it. This interesting dichotomy
  has led us to ask the question: is access to public transportation really granted to those who need it?"),
  
  h3("How does geographical proximity to public transportation affect overall ridership?"),
  p("Miles writes his conclusion here!"),
  h3("How do income & poverty impact usage?"),
  p("Income and poverty levels have a notable impact on transit usage.
    Lower-income areas often rely more heavily on public transportation,
    while higher-income areas may have greater access to private vehicles,
    leading to lower transit usage. The graph illustrates how poverty status 
    varies across uses of public transport, carpooling and driving alone. 
    By examining the distribution, we can identify patterns regarding how poverty
    intersects with higher use of public transport and carpooling."),
  h3("How does vehicle ownership & the number of vehicles owned affect transit usage?"),
  p("Vehicle ownership rates inversely correlate with public transit usage. 
    Areas with lower rates of vehicle ownership tend to have higher public transportation ridership. 
    Carpooling users seem to have the fewest vehicles avaliable.")
)

# Tab label and format
conclusion_tab <- tabPanel("Analysis Results",
                           sidebarLayout(
                             conclusion_sidebar,
                             conclusion_main_panel
                           )
)


######################################################
################### Sources-Tab ######################
######################################################

#source main panel
sources_main_panel <- mainPanel(
  h2(HTML("<b>Sources</b>")),
  h4("Our Income Data, sourced from the United States Census Bureau:"),
  a("https://data.census.gov/table/ACSST5Y2022.S1903?g=050XX00US53033$1400000"),
  p("This source offered great insights into the socioecnomic landscape of King County."),
  h4("Our Transit Data, sourced from the United States Census Bureau: "),
  a("https://data.census.gov/table/ACSST5Y2022.S0802?g=050XX00US53033$1400000"),
  p("This source offered insights on the usage of transportation throughout King County, relating to poverty 
    status and vehicle availability."),
  h4("Our Zip Code Data, Sourced from Proximity One: "),
  a("https://proximityone.com/ziptractequiv.htm"),
  p("This source gave us the opportunity to evaluate GEOIDs by zip codes."),
)


# source tab layout
sources_tab <- tabPanel("Project Sources",
                        sources_main_panel)



ui <- navbarPage("Equity in Transportation",
  overview_tab,
  viz_1_tab,
  viz_2_tab,
  viz_3_tab,
  conclusion_tab,
  sources_tab
)