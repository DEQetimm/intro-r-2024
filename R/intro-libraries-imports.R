## Reference: R for data science - found online

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

library(dplyr)

# filtering data by ODOT and I-5); 
odot_meta <- sta_meta |> # piping function; old pipe notation %>%; don't use this any more use this: |>
  filter(
    agency == "ODOT",
    highwayid == 1
    ) # also note formatting of this set of lines
      # open parenthesis: new line, additional filter: new line, close parenthesis: new line

# filtering data for everything BUT ODOT, or NOT (!) ODOT  
notodot_meta <- sta_meta |>
  filter(
    agency != "ODOT"
  ) 

# looking for NAs
nas_meta <- sta_meta |>
  filter(
    is.na(detectorlocation)
  ) 
  
# excluding NAs
real_meta <- sta_meta |>
  filter(
    !is.na(detectorlocation)
  )







