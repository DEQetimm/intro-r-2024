library(tidycensus) # acts as a gateway to the Census API for ACS and Decenial data
                    # for more info: https://walker-data.com/tidycensus
library(dplyr)
library(tidyr)
library(ggplot2)

#### Run on first use if not already stored in R ####
# enter you API key within ""
census_api_key("myCensusAPIKey", install=T) 
readRenviron("~/.Renviron")
####

#### User functions ####


####

# get a searchable census variable table ----
v19 <- load_variables(2019, "acs5") # 2019 ACS 5 year data
v19 |> filter(grepl("^B08006_", name)) |> # search through df to find something; ^ = start at top; _ = starts with what is before?
    print(n=25)
  
# get the data for traffic, wfh, and total workers ----
# ?get_acs for help
comm_19_raw <- get_acs(geography = "tract",
                       variables = c(wfh = "B08006_017",
                                     transit = "B08006_008",
                                     tot = "B08006_001"),
                       county = "Multnomah",
                       state = "OR",
                       year = 2019,
                       survey = "acs5",
                       geometry = FALSE) # can retrieve spacial data pre-joined; library (sf)
comm_19_raw # moe is +/- that number (confidence level)

# move data around so it's more analyzable
comm_19 <- comm_19_raw |>
  pivot_wider(id_cols = GEOID:NAME,
              names_from = variable,
              values_from = estimate:moe)
comm_19

#





