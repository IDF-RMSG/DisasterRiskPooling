#######################################################
### Insurance Development Forum                     ###
### Disaster Risk Pooling Tool                      ###
### data_archetype.R                                ###
### https://github.com/IDF-RMSG/DisasterRiskPooling ###
#######################################################
### This file defines archetype data for the main App
### This file is referenced as a source in app.R

source('global.R')

#################################################################################
# Read in and process ARCHETYPE DATA - TODO: put in separate file
#################################################################################

# ----- Archetype Cost data ----
archetype_cost_data <- read_csv(infile_archetype, show_col_types = FALSE)

archetype_cost_data <- cbind(archetype_cost_data, data_type = "archetype_cost")

names(archetype_cost_data) <- c('archetype', 'year', 'peril', 'value', 'data_type')

# ----- Archetype Cost data ----
archetype_freq_data <- expand_data(archetype_cost_data, "archetype")

# Fill NA with zeroes
archetype_freq_data$value[is.na(archetype_freq_data$value)] <- 0
archetype_freq_data$value <- ifelse(archetype_freq_data$value > 0, 1, 0)

# Get all archetype frequency data into data frame
archetype_freq_data <-
  archetype_freq_data[c('year', 'peril', 'value', 'archetype', 'data_type')]
archetypes <- unique(archetype_cost_data$archetype)
archetypes <- archetypes[order(archetypes)]

# Number of years in each time horizon
years_archetype <- unique(archetype_cost_data$year)
years_country <- unique(country_data$year)
min_year <- min(min(years_archetype), min(years_country))
max_year <- max(max(years_archetype), max(years_country))
num_years <-
  pmax(
    max(years_archetype) - min(years_archetype) + 1,
    max(years_country) - min(years_country) + 1
  )