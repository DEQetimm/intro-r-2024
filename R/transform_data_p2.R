#### Transforming Data Part 2 #### (four dash signs at end to create TOC header) ----

library(readxl)
library(dplyr)

# Load in our data from Excel (df = dataframe we're using, in this case sample)
df <- read_excel("data/icebreaker_answers.xlsx")
df # to view in console
View(df) # to view in table form
tail(df)

# take last row and add to end of existing df (use to add new data to existing data - yearly, etc)
df <- df |> bind_rows(slice_tail(df)) 
tail(df) # looking at last row

# returns only 1 unique row per set of values (takes the first row it finds)
# if you want to only look at certain distinct column values, add something inside () after distinct
df <- df |> distinct() 
tail(df)

# selecting columns and/or reording columns ----
# below grabs all rows except serial columns and reorders columns
# does not create a new df, just shows in the console
df |> select(travel_mode, travel_distance, travel_time)

df |> select (-serial_comma) #drop just one column
df_travel <- df |> select (-serial_comma) # same as above, but creates new df

df |> select(travel_mode:travel_distance) # group of columns (start:end)

df |> select(starts_with("travel_")) # selecting columns by expression

df_travel <- df |> select (-serial_comma) # perhaps easiest to read

# mutate and rename (creating and modifying data frames) ----

# using base R:
df_travel$travel_speed <- (df_travel$travel_distance / 
                                  df_travel$travel_time * 60) # mph
# using dyplr
df_travel <- df_travel |>
  mutate(travel_speed = travel_distance / travel_time * 60) # mph

# adding multiple columns
df_travel <- df_travel |>
  mutate(travel_speed = travel_distance / travel_time * 60, # mph
         travel_km = travel_distance / travel_time * 96.5) # fake km (I didn't know multiplier)

# rename columns ----
df_travel <- df_travel |> 
  rename(travel_mph = travel_speed) # travel is new name with values from travel_speed
colnames(df_travel)
df_travel

# if/else and case when logic ----
# adding logic to mutate
df_travel <- df_travel |>
  mutate(long_trip = if_else(travel_distance > 20,
                             "Yes", "No")) # over 20 miles = yes, under = no
df_travel

df_travel <- df_travel |>
  mutate (slow_trip = 
            case_when(
              travel_mode == "bike" & travel_mph < 12 ~ 1, # ~ means "report as" (1 = yes, slow trip)
              travel_mode == "car" & travel_mph < 25 ~ 1,
              travel_mode == "bus" & travel_mph < 15 ~ 1,
              travel_mode == "light rail" & travel_mph < 20 ~ 1,
              .default = 0 # ALL FALSE or NA
            ))
df_travel

# arrange to order output ----
df_travel |> arrange (travel_mph) |> print(n=25) # from slowest to fastest, shows 25 rows in console

df_travel |> arrange(travel_mode, travel_mph) |> print(n=25)

df_travel |> arrange (desc(travel_mph)) |> print(n=25) # from fastest to slowest, shows 25 rows in console

boxplot(df_travel$travel_mph ~ df_travel$long_trip) # box plot of travel mph and long trip
