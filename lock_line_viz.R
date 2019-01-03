fun.lockline_viz <- function(df.lock_line, df.game_summaries, df.team_list){
#DESCRIPTION: Creates a vizualization of specified lock line, point of no return, and team performance
#ARUMENTS: 
  #df.lock_line = a data frame containing a lock line and point of no return for all 82 games
  #df.game_summaries = a data frame containing a team's summarised results by game
  #team_list = a dataframe with a team list in the first column and a season ID in the second

  require(ggplot2)
  require(ggrepel)
  require(plyr)
  require(dplyr)
  require(readr)
  
  #create a blank dataframe for the resulting summaries for each team
  df.team_summaries <- data.frame(team = as.character(), season = as.integer())
  
  #Filter Regular Season Games for the selected team/season combinations only
  for(i in 1:nrow(df.team_list))
  {
    df.team_summaries <- 
      rbind(df.team_summaries,
            filter(df.game_summaries, 
                   session == "R" & 
                     team == as.character(df.team_list[i,1]) & 
                     season == as.character(df.team_list[i,2])) %>% 
              arrange(team_game))
  }
  
  #Filter the lock line to only the number of games completed
  df.lock_line <- filter(df.lock_line, team_game <= max(df.team_summaries$team_game))
  
  #Define the team labels for the viz
  df.line_labels <- 
    df.team_summaries %>% 
    dplyr::group_by(team, season) %>%
    dplyr::summarise(points = max(team_point_total),
              games = max(team_game)) %>%
    dplyr::mutate(label = paste0(team, "-", season, "\n", points, " Points"))
  
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