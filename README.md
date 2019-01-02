#Lock-Line-Analysis
*A suite of tools used to create a "lock-line" and "point of no return" based on historical NHL team results*

##Overview
This project is largely inspired by two [articles](https://theathletic.com/222746/2018/01/26/dellow-point-of-no-return-all-star-edition/) posted by [Tyler Dellow](https://theathletic.com/187165/2017/12/22/dellow-the-point-of-no-return-viva-las-vegas-edition/) at The Athletic during the 2017-2018 NHL hockey season. It involved analyzing game-by-game results for all teams from the 05-06 season onwards to identify the minimum number of points that any playoff team had achieved during that time frame, as well as the maximum number of points that any non-playoff team had achieved during the same time frame. The result was 2 lines, the lock line and the point of no return:

**Lock Line:** The minimum number of points that any team has achieved and still made the playoffs after each game (1-82) of the season  
**Point of no Return:** The maximum number of points that any team has achieved and still missed the playoffs after each game (1-82) of the season

##Contents
1. **Lock_Line_Analysis.rmd-** An R Markdown overview of my methodology, resulting data sets, and some basic take-aways. There are also corresponding HTML and PDF documents
2. **lock_line_creation.R-** A raw set of functions for creating the lock line and point of no return. May need to be modified to run on your local system
3. **lock_line_viz.R-** A quick function for graphing the lock line and point of no return
4. **Final Data Sets-** The final data sets for the game-by-game results summaries, the lock line and point of no return lines, as well as a list of playoff teams by season
