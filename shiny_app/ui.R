ui <- fluidPage(
  titlePanel("Team Performance vs Lock Line", 
             windowTitle = "Lock Line Analysis"),
  sidebarLayout(
    sidebarPanel(
    uiOutput("teamOutput"), #Team Filter
    uiOutput("seasonOutput"), #Season Filter
    h3("Project Overview"), #Project Overview
    "This project was originally inspired by two articles posted on
    The Athletic by Tyler Dellow", br(), br(),
    tags$b(a("The Point of No Return - All-Star Edition", 
             href = "https://theathletic.com/222746/2018/01/26/dellow-point-of-no-return-all-star-edition/")), 
    br(), br(),
    tags$b(a("The Point of No Return - Viva Las Vegas Edition",
           href = "https://theathletic.com/187165/2017/12/22/dellow-the-point-of-no-return-viva-las-vegas-edition/")),
    br(), br(),
    h3("Definitions"), #Definitions
    tags$b("Lock Line:"), " The point total after each game of the regular season that no team has missed the playoffs after achieving", br(), br(),
    tags$b("Point of no Return:"), " The point total after each game of the regular season where no team has made the playoffs after reaching", br(), br(),
    h3("Methodology"), #Methodology
    "A brief overview of the methodology used to create the data for this app is outlined
    at the below location", br(), br(),
    a("Methodology Overview", href = "http://htmlpreview.github.com/?https://github.com/EFastner/Lock_Line_Analysis/blob/master/Lock_Line_Analysis.html"),
    br(),
    a("PDF Download", href = "https://github.com/EFastner/Lock_Line_Analysis/raw/master/Lock_Line_Analysis.pdf"),
    width = 4),
    
    mainPanel(plotOutput("viz.lock_line", height = "100%"),
              br(), br(),
              h2(textOutput("titleOutput")),
              h3(textOutput("playoffsOutput")),
              br(),
              downloadButton("export_summary", "Export to .csv"),
              br(), br(),
              DT::dataTableOutput("df.results_table"))
  )
)