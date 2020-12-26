
# 1.1 The .R file --------------------------------------------------------------

# Load in Libraries ------------------------------------------------------------

library(tidyverse)
library(janitor)
library(assertr)

# Question 1 -------------------------------------------------------------------

# Read the data into R

meteorite_raw <- read_csv("raw_data/meteorite_landings.csv")

# Question 2 -------------------------------------------------------------------

# Change the names of the variables to follow our naming standards.

meteorite_clean <- meteorite_raw %>% 
  rename(
    mass = "mass (g)",
    lat_long = "GeoLocation"
  )

# Question 3 -------------------------------------------------------------------

# Split in column GeoLocation into latitude and longitude, the new latitude 
# and longitude columns should be numeric.

meteorite_clean <- meteorite_clean %>%
  separate(lat_long, c("latitude", "longitude"),
           sep = ",") %>%
  mutate(latitude = str_remove(
    latitude, pattern = "\\("
  )) %>%
  mutate(longitude = str_remove(
    longitude, pattern = "\\)"
  )) %>% 
  mutate(latitude = as.numeric(latitude)) %>%
  mutate(longitude = as.numeric(longitude))

# Question 4 -------------------------------------------------------------------

# Replace any missing values in latitude and longitude with zeros.

meteorite_clean <- meteorite_clean %>% 
  mutate(latitude = coalesce(latitude, 0)) %>% 
  mutate(longitude = coalesce(longitude, 0))

# Question 5 -------------------------------------------------------------------

# Remove meteorites less than 1000g in weight from the data.

meteorite_clean <- meteorite_clean %>% 
  filter(mass >= 1000)

# Question 6 -------------------------------------------------------------------

# Order the data by the year of discovery.

meteorite_clean <- meteorite_clean %>% 
  arrange(year)

# Write cleaned data -----------------------------------------------------------

write_csv(meteorite_clean, "clean_data/meteorite_clean")

# End of Cleaning --------------------------------------------------------------
