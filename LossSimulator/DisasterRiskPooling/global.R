#######################################################
### Insurance Development Forum                     ###
### Disaster Risk Pooling Tool                      ###
### Global.R                                        ###
### https://github.com/IDF-RMSG/DisasterRiskPooling ###
#######################################################
### This file defines global variables for the main App
### This file is referenced as a source in app.R


#################################################################################
# Load additional libraries
#################################################################################
library(actuar)
library(boot)
library(bsplus)
library(data.table)
library(dplyr)
library(DT)
library(fitdistrplus)
library(ggplot2)
library(ggthemes)
library(Hmisc)
library(htmltools)
library(MASS)
library(plotly)
library(qpcR)
library(readxl)
library(scales)
library(shiny)
library(shinyBS)
library(shinycssloaders)
library(shinydashboard)
library(shinyjqui)
library(shinyjs)
library(shinythemes)
library(shinyWidgets)
library(tictoc)
library(tidyr)
library(tidyverse)
#library(reshape2) - deprecated
#library(optimx)
#library(WBTool1)


#################################################################################
# Define Global variables
#################################################################################


# ----- Input files ----
path_countries <- 'data/Countries/'
infile_cntrylist <- paste0(path_countries, 'emdat_country_occ.csv')

path_scaling <- 'data/Scale/'
infile_pop <- paste0(path_scaling, 'population_data.csv')
infile_gdp <- paste0(path_scaling, 'gdp.csv')
infile_infl <- paste0(path_scaling, 'inflation.csv')

infile_archetype <- "data/Archetypes/archetype_cost_data.csv" # Not used in 2025 version




### ----- Perils -----
str_perils <- c("Cyclone", "Flood" , "Drought", "Earthquake")


# ----- Currency code -----
ccy_code <- "USD"


# ----- Distribution Types-----
basic_parametric <- c('Gamma', 'Log normal', 'Weibull', 'Pareto')


# ----- Plotting: Remove scientific notation ----
options(scipen = 999)

# ----- Plotting: Scale values ----
scale_size = 1000000 # scale by millions

# ----- Plotting: Year range ----
start_year <- 2002
end_year <- 2024

### ----- Plotting: Fonts -----
fontsize_title <- 12
fontsize_axis <- 10
font_colour <- "#000000"
font_family <- "Raleway, sans-serif"
font_title <- list(family = font_family, size = fontsize_title, color = font_colour)
font_axis <- list(family = font_family, size = fontsize_axis, color = font_colour)

### ----- Buttons -----
button_style <- "color: white; background-color: #ff0000; font-weight: bold; 
position: relative; text-align:center; border-radius: 6px; border-width: 2px"



