library(readr)
library(plyr)
library(dplyr)
library(ggplot2)
library(ggrepel)

ui <- fluidPage(
  titlePanel("Team Performance vs Lock Line", 
             windowTitle = "Lock Line Analysis"),
  sidebarLayout(
    sidebarPanel(
    uiOutput("teamOutput"),
    uiOutput("seasonOutput")),
    mainPanel(plotOutput("viz.lock_line"),
              br(), br(),
              tableOutput("df.results_table"))
  )
)