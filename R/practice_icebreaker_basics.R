#### Practice Problem: Loading and manipulating a data frame ####
# Don't forget: Comment anywhere the code isn't obvious to you!

# Load the readxl and dplyr packages
library(readxl)
library(dplyr)

# Use the read_excel function to load the class survey data
df_icebreaker <- read_excel("data/icebreaker_answers.xlsx")
df_icebreaker

# Take a peek!
df_icebreaker # if the df doesn't autoview

# Create a travel_speed column in your data frame using vector operations and 
#   assignment
df_icebreaker$travel_speed <- c(df_icebreaker$travel_distance / 
                                  df_icebreaker$travel_time * 60) 
df_icebreaker



# Look at a summary of the new variable--seem reasonable?
summary(df_icebreaker) #gives summary of data by column
boxplot(df_icebreaker$travel_speed ~ df_icebreaker$travel_mode)
hist(df_icebreaker$travel_speed)

# Choose a travel mode, and use a pipe to filter the data by your travel mode
df_icebreaker |> filter(travel_mode == "bus")


# Note the frequency of the mode (# of rows returned)
summary(bus_data) #gives summary of data by column


# Repeat the above, but this time assign the result to a new data frame
bus_data <- df_icebreaker |> 
  filter(
    travel_mode == "bus"
  ) 

# Look at a summary of the speed variable for just your travel mode--seem 
#   reasonable?
summary(bus_data)

# Filter the data by some arbitrary time, distance, or speed threshold
df_icebreaker |> filter(travel_speed > 20 & travel_speed < 50)

# Stretch yourself: Repeat the above, but this time filter the data by two 
#   travel modes (Hint: %in%)
df_icebreaker |> filter(travel_mode %in% c("bike", "bus"))
# OR
df_icebreaker |> filter(travel_mode == "bike" | travel_mode == "bus")
