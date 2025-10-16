#######################################################
### Insurance Development Forum                     ###
### Disaster Risk Pooling Tool                      ###
### data_archetype.R                                ###
### https://github.com/IDF-RMSG/DisasterRiskPooling ###
#######################################################
### This file defines scalingdata for the main App
### This file is referenced as a source in app.R

source('global.R')


#################################################################################
# Read in and process SCALING DATA - TODO: put in separate file
#################################################################################

population_data <- read.csv(infile_pop)
gdp_data <- read.csv(infile_gdp)
# inflation_data <- read.csv(infile_infl)

# Join data
scale_data <- full_join(population_data, gdp_data, by = c('Country', 'Year'))
# scale_data <- full_join(scale_data, inflation_data, by = c('Country', 'Year'))
rm(population_data, gdp_data)
names(scale_data) <- c('country', 'year', 'population', 'gdp')


