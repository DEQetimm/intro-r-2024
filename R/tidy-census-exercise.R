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
tidy_acs_result <- function(raw_result, include_moe=FALSE) {
  # takes tidycensus acs result and returns a wide and tidy table#
  if (isTRUE(include_moe)) {
    new_df <- raw_result |> pivot_wider(id_cols = GEOID:NAME,
                                        names_from = variable,
                                        values_from = estimate:moe)
  } else {
    new_df <- raw_result |> pivot_wider(id_cols = GEOID:NAME,
                                        names_from = variable,
                                        values_from = estimate)
  }
  return(new_df)
}

tidy_acs_result

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

comm_19 <- tidy_acs_result(comm_19_raw) # this is now using our function and showing what needs to be called in

#

# 2022 ACS data
comm_22_raw <- get_acs(geography = "tract",
                       variables = c(wfh = "B08006_017",
                                     transit = "B08006_008",
                                     tot = "B08006_001"),
                       county = "Multnomah",
                       state = "OR",
                       year = 2022,
                       survey = "acs5",
                       geometry = FALSE) # can retrieve spacial data pre-joined; library (sf)
comm_22_raw # moe is +/- that number (confidence level)

# applying our function to pivot wider and drop moe
comm_22 <- tidy_acs_result(comm_22_raw)
comm_22

# join the years ----
comm_19_22 <- comm_19 |> inner_join(comm_22, #inner join only keeps those rows that match on id
                                    by="GEOID",
                                    suffix = c("_19", "_22")) |> # suffix clarifies column names
  select(-starts_with("NAME"))
comm_19_22

# create some change variables ----
comm_19_22 <- comm_19_22 |>
  mutate(wfh_chg = wfh_22 - wfh_19,
          transit_chg = transit_22 - transit_19,
          tot_chg = tot_22 - tot_19)
         summary(comm_19_22 |> select((ends_with("_chg"))))
comm_19_22  


# plot them ----
p <- comm_19_22 |>
  ggplot(aes(x = wfh_chg, y = transit_chg))
p + geom_point()
p + geom_point() + 
  geom_smooth(method = "lm") + # lm = linear model
  labs(x = "Change in WFH",
       y = "Change in Transit",
       title = "ACS 2022 vs 2019 (5-year)")+
  annotate("text", x=800, y=75,
           label = paste("r = ", 
                         round(cor(comm_19_22$wfh_chg,
                             comm_19_22$transit_chg), 3)))

# simple linear (default Pearson) correlation
cor(comm_19_22$wfh_chg, comm_19_22$transit_chg)

# model it ----
# model formula is dependent_var ~ dependent_var
m <- lm(transit_chg ~ wfh_chg,
        data = comm_19_22)
summary(m)

# model is an object ready for reuse!!
head(m$model) # model comes data included

scen1 <- comm_19_22 |>
  mutate(wfh_chg = wfh_chg * 1.5)

scen1_pred <- predict(m, newdata = scen1)

# difference in total daily transit impact from 50% increase in WFH change
sum(comm_19_22$transit_chg)
sum(scen1_pred)

# update(model, data =) function re-estimates model on new data





