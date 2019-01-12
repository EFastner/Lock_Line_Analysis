library(readr)
library(plyr)
library(dplyr)

ui <- fluidPage(
  titlePanel("Team Performance vs Lock Line", 
             windowTitle = "Lock Line Analysis"),
  sidebarLayout(
    uiOutput("teamOutput"),
    uiOutput("seasonOutput")),
  mainPanel(plotOutput("viz.lock_line"),
            br(), br(),
            tableOutput("df.team_results"))
)