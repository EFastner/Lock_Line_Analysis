server <- function(input, output) {
  #Read in CSV files for all game results as well as the lock line
  df.all_summaries <- read_csv("all_seasons.csv", col_names = TRUE)
  df.lock_line <- read_csv("lock_line.csv")
  
  #Filter dataframe based on criteria
  df.team_results <- reactive({
    df.all_summaries %>%
      filter(team == input$teamInput,
             season == input$seasonInput,
             session == "R")
  })
    
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
  
  output$viz.lock_line <- renderPlot({
    #Create the labels for the plot
    df.line_labels <- reactive({
      df.team_results() %>% 
        dplyr::group_by(team, season) %>%
        dplyr::summarise(points = max(team_point_total),
                         games = max(team_game)) %>%
        dplyr::mutate(label = paste0(team, "-", season, "\n", points, " Points"))
    })
    
    #Create Viz
    viz.lockline_performance <- 
      ggplot() +
      ggtitle("Lock Line and Point of No Return") +
      theme(plot.title = element_text(hjust = 0.5), legend.position = "none") +
      labs(x = "Game Number", y = "Total Points", color = "Team") +
      geom_line(data = df.lock_line, na.rm = TRUE, mapping = aes(x = team_game, y = lock_line), color = "blue", linetype = "longdash", alpha = .3) +
      geom_line(data = df.lock_line, na.rm = TRUE, mapping = aes(x = team_game, y = no_return), color = "red", linetype = "longdash", alpha = .3) +
      geom_line(data = df.team_results(), mapping = aes(x = team_game, y = team_point_total, color = team)) +
      geom_text(data = df.line_labels(), mapping = aes(x = games, y = points, label = label, color = team), nudge_x = 1.75)
    
    viz.lockline_performance
  })
  
  output$df.results_table <- renderTable({
    df.joined_tables <- reactive({
      merge(x = df.team_results(), 
            y = df.lock_line,
            by = "team_game",
            all.x = TRUE)
    })
    
    df.joined_tables() %>%
      mutate(
           "Game" = team_game, 
           "Opponent" = opp,
           "Side" = side, 
           "Result" = result, 
           "Point Total" = team_point_total,
           "Lock Line" = lock_line,
           "Var to LL" = team_point_total - lock_line,
           "No Return" = no_return,
           "Var to NR" = team_point_total - no_return
           ) %>%
      select(Game,
             Opponent,
             Side,
             Result,
             "Point Total",
             "Lock Line",
             "Var to LL",
             "No Return",
             "Var to NR")
  })
  
}