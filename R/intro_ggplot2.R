# Visualizing data ----
# alternative libraries: highchart R?

library(dplyr)
library(ggplot2)
library(readxl)

# load data
df_ice <- read_xlsx("data/icebreaker_answers.xlsx")

tt_mi_fig <- df_ice |>
  ggplot(
    aes(x = travel_time, y = travel_distance)) + # plus sign adds on layers to base data (base, next adds type of chart, etc)
      geom_point()
tt_mi_fig   

tt_mi_ox_fig <- df_ice |>
  ggplot(
    aes(x = travel_time, y = travel_distance, color = serial_comma)
  ) +
  geom_point() +
xlab("Travel Time") + # changes x axis label
ylab("Travel Distance") # changes y axis label
tt_mi_ox_fig

# build upon previously created figure in new figure
tt_mi_2 <- tt_mi_ox_fig +
  theme_bw() # changes background from greyscale to b/w
tt_mi_2

# create new figure withe mode instead of serial_comma
tt_mi_mode_fig <- df_ice |>
  ggplot(
    aes(x = travel_time, y = travel_distance, color = travel_mode)
  ) +
  geom_point() +
  xlab("Travel Time") + # changes x axis label
  ylab("Travel Distance") + # changes y axis label
  theme_bw()
tt_mi_mode_fig


tt_mi_mode_fig <- df_ice |>
  ggplot(
    aes(x = travel_time, y = travel_distance, color = travel_mode)
  ) +
  geom_point() +
  labs(x = "Travel Time", y = "Travel Distance", color = "Travel Mode")+
  theme_bw()
tt_mi_mode_fig



# Faceting
ice_facet_fig <- df_ice |>
  ggplot(aes(x = travel_time, y = travel_distance)) +
  geom_point() +
  facet_wrap(travel_mode ~ .,
             scales = "free")
ice_facet_fig


tt_mode_car_fig <- df_ice |>
  filter(travel_mode == "car") |>
  ggplot(aes(x = travel_time, y = travel_distance)) +
  geom_point() +
  theme_bw()
tt_mode_car_fig
