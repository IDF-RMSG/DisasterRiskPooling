#######################################################
### Insurance Development Forum                     ###
### Disaster Risk Pooling Tool                      ###
### data_archetype.R                                ###
### https://github.com/IDF-RMSG/DisasterRiskPooling ###
#######################################################
### This file defines historical data for the main App
### This file is referenced as a source in app.R

source('global.R')

#################################################################################
# Read in and process HISTORICAL DATA (EM-DAT) - TODO: put in separate file
#################################################################################

# ----- Read EM-DAT ----
emdat_data_occ <-
  read.csv(infile_cntrylist, stringsAsFactors = FALSE) |>
  dplyr::filter(dplyr::between(.data$Year, start_year, end_year)) |>
  dplyr::mutate(Sum.of.Total.Damage = .data$`Sum.of.Total.Damage` * 1000)

emdat_data_yearly <-
  emdat_data_occ %>%
  dplyr::group_by(.data$`Country`, .data$`Year`, .data$Type.of.event) %>%
  dplyr::summarise(
    `Total.affected` = sum(.data$`Sum.of.Total.affected`),
    `Total.Damage` = sum(.data$`Sum.of.Total.Damage`),
    `Event Count` = sum(.data$`Sum.of.Total.Damage` > 0),
    .groups = "drop"
  )

emdat_data_occ$origin <- 'EM_DAT'

# Combine data
country_data <- emdat_data_occ
names(country_data) <-
  c('id', 'country', 'year', 'peril', 'affected', 'damage', 'origin')

# Pivot data: collapse damage type
country_data <-
  country_data %>%
  tidyr::pivot_longer(c("damage", "affected"), names_to = "damage_type")

# ----- Process EM-DAT: create countries vector ----
countries <- unique(country_data$country)
countries <- countries[order(countries)]

# ----- Process EM-DAT: create perils vector ----
peril_names_global <- unique(country_data$peril)
peril_names_global <- peril_names_global[order(peril_names_global)]


# ----- Process EM-DAT: obtain frequency and loss ----
cost_data <- dplyr::filter(country_data, .data$damage_type == 'affected')
damage_data <-  dplyr::filter(country_data, .data$damage_type == 'damage')

cost_freq <-
  cost_data %>%
  dplyr::group_by(.data$country, .data$year, .data$peril, .data$damage_type) %>%
  dplyr::summarise(value = sum(.data$value > 0), .groups = "drop") %>%
  tidyr::complete(.data$country, .data$peril, .data$year, fill = list(value = 0))

damage_freq <-
  damage_data %>%
  dplyr::group_by(.data$country, .data$year, .data$peril, .data$damage_type) %>%
  dplyr::summarise(value = sum(.data$value > 0), .groups = "drop") %>%
  tidyr::complete(.data$country, .data$peril, .data$year, fill = list(value = 0))

frequency_data <- rbind(cost_freq, damage_freq)

# ----- Process EM-DAT: Combine the cost per person and loss data ----
country_data <- rbind(damage_data, cost_data)

rm(cost_freq, damage_freq, cost_data, damage_data)