ui <- fluidPage(
  titlePanel("Team Performance vs Lock Line", 
             windowTitle = "Lock Line Analysis"),
  sidebarLayout(
    sidebarPanel(
    uiOutput("teamOutput"),
    uiOutput("seasonOutput")),
    mainPanel(plotOutput("viz.lock_line"),
              br(), br(),
              h2("Season Trends"), 
              downloadButton("export_summary", "Export to .csv"),
              tableOutput("df.results_table"))
  )
)