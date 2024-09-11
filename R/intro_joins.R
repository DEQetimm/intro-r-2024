library(dplyr)
library(ggplot2)

# import data sets
detectors <- read.csv("data/portal_detectors.csv", stringsAsFactors = F)
stations <- read.csv("data/portal_stations.csv", stringsAsFactors = F)
data <- read.csv("data/agg_data.csv", stringsAsFactors = F)

head(data) # shows data table headers
table(data$detector_id) # how many detectors and observations

data_detectors <- data |>
  distinct(detector_id)

# join by col with different names (only need shared name, if both tables have same col name)
data_detectors_meta <- data_detectors |>
  left_join(detectors, by = c("detector_id" = "detectorid")) 

# shows those that didn't join on the id
data_detectors_missing <- detectors |>
  anti_join(data_detectors, by = c("detectorid" = "detector_id")) |>
  distinct(detectorid)


# use the data_detectors_meta to join wit the stations metadata
# I want the stations metadata for the detectors that we have data for
stations_detector_join <- data_detectors_meta |>
  select(detector_id, stationid) |> # only takes two columns from data_detectors_meta to make it smaller/cleaner
  left_join(stations, by = c("stationid")) 
stations_detector_join

stations_detector_join2 <- data_detectors_meta |>
   left_join(stations, by = c("stationid")) 
stations_detector_join2

stations_detector_join3 <- stations |>
  left_join(data_detectors_meta, by = c("stationid")) 
stations_detector_join3