server <- function(input, output) {
  #Read in CSV files for all game results as well as the lock line
  df.all_summaries <- read_csv("all_seasons.csv", col_names = TRUE)
  df.lock_line <- read_csv("lock_line.csv")
  
  #Dynamic UI to Select all Teams in Dataset
  output$teamOutput <- renderUI({
    selectInput(inputId = "teamInput",
                label = "Team",
                choices = sort(unique(df.all_summaries$team)),
                selected = "ANA")
  })
  
  #Dynamic UI to Select all seasons available for a team
  output$seasonOutput <- renderUI({
    selectInput(inputId = "seasonInput",
                label = "Season",
                choices = sort(unique(
                  filter(df.all_summaries, 
                         team == input$teamInput)$season)),
                selected = "20172018")
  })
  
}