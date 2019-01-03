fun.lockline_viz <- function(df.lock_line, df.game_summaries, team_name, season_ID){
#DESCRIPTION: Creates a vizualization of specified lock line, point of no return, and team performance
#ARUMENTS: 
  #df.lock_line = a data frame containing a lock line and point of no return for all 82 games
  #df.game_summaries = a data frame containing a team's summarised results by game
  #team_name = a list of team names to grab
  #season_ID = the season to search

  require(ggplot2)
  require(plyr)
  require(dplyr)
  require(readr)
  
  #Filter Regular Season Games for the selected team and season only
  df.team_summaries <- 
    filter(df.game_summaries, 
           session == "R" & 
             team %in% team_name & 
             season %in% season_ID) %>% 
    arrange(team_game)
  
  #Filter the lock line to only the number of games completed
  df.lock_line <- filter(df.lock_line, team_game <= max(df.team_summaries$team_game))
  
  #Define the team labels for the viz
  df.line_labels <- 
    df.team_summaries %>% 
    dplyr::group_by(team) %>%
    dplyr::summarise(points = max(team_point_total),
              games = max(team_game)) %>%
    dplyr::mutate(label = paste(team, points, sep = ", "))
  
  #Create Viz
  viz.lockline_performance <- 
    ggplot() +
    ggtitle("Lock Line and Point of No Return") +
    theme(plot.title = element_text(hjust = 0.5), legend.position = "none") +
    labs(x = "Game Number", y = "Total Points", color = "Team") +
    geom_line(data = df.lock_line, na.rm = TRUE, mapping = aes(x = team_game, y = lock_line), color = "blue", linetype = "longdash", alpha = .3) +
    geom_line(data = df.lock_line, na.rm = TRUE, mapping = aes(x = team_game, y = no_return), color = "red", linetype = "longdash", alpha = .3) +
    geom_line(data = df.team_summaries, mapping = aes(x = team_game, y = team_point_total, color = team)) +
    geom_text(data = df.line_labels, mapping = aes(x = games, y = points, label = label, color = team), nudge_x = 1.75)
  
  return(viz.lockline_performance)
}