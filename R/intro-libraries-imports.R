# Read in a csv file using base R
sta_meta <- read.csv("data/portal_stations.csv", stringsAsFactors = F) # read in a csv file
# stringsAsFactors = brings in the individual instances, rather than setting values

str(sta_meta) # looks at structure of data in console (similiar to arrow drop-down)

head(sta_meta) # shows first six rows of data
tail(sta_meta) # shows last six rows of data

nrow(sta_meta) # shows number of rows of data

summary(sta_meta) # summarizes data set, can get info about NAs

# Using data import shortcut to read in xlsx and copy/paste code
library(readxl)
icebreaker_answers <- read_excel("data/icebreaker_answers.xlsx")
View(icebreaker_answers)

