library(stationaRy)
library(ggplot2)
library(dplyr)
library(lubridate)
library(sf)
library(tmap)


# Get stations for CME. Limit output to years 2000 through 2019
sta.df <- get_station_metadata() %>% 
          filter(country == "US", state == "ME") %>% 
          select(id, name, lat, lon, begin_year, end_year) 
  
# Create spatial object from table for mapping
sta.sf <- st_as_sf(sta.df, coords=c("lon", "lat"), 
                   na.fail=FALSE, crs=4326) 

# Map stations. Click on points to get ID
tmap_mode("view")
tm_shape(sta.sf) + tm_dots(col="red", jitter=0.01,
                                popup.vars=c("id","begin_year","end_year") )

# Augusta: 726185-14605 (1973 - 2019)

# Get the default meteorological parameters plus the precipitation values (AA1)
# If precipitation values are present, this will add four new fields: aa1_1
# through aa1_4. aa1_2 returns precip in mm 
# See https://www1.ncdc.noaa.gov/pub/data/ish/ish-format-document.pdf for code
# documentation
lga_met_data <- get_met_data(
  station_id = "726185-14605",
  years = 1973:2019, 
  add_fields = "AA1") 

# Save output
saveRDS(lga_met_data, "AugustaME_1973_2019.rds")



