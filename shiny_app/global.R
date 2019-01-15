library(readr)
library(plyr)
library(dplyr)
library(ggplot2)
library(ggrepel)
library(DT)

#Read in CSV files for all game results as well as the lock line
df.all_summaries <- read_csv("all_seasons.csv", col_names = TRUE)
df.lock_line <- read_csv("lock_line.csv")

