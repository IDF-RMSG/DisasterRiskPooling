# Load additional libraries
library(shiny)
#library(shinydashboard)
#library(tidyverse)
#library(shinyjs)
#library(shinyBS)
#library(shinyjqui)
#library(bsplus)
#library(scales)
#library(shinycssloaders)
#library(plotly)
#library(reshape2)
#library(WBTool1)
#library(readxl)
#library(qpcR)
#library(DT)
#library(ggplot2)
#library(ggthemes)
#library(shinyWidgets)
#library(shinythemes)
library(dplyr)
#library(htmltools)
#library(MASS)
#library(optimx)
#library(reshape2)
#library(fitdistrplus)
#library(actuar)
#library(Hmisc)
#library(boot)
#library(tidyr)
#library(data.table)
#library(tictoc)

# Remove scientific notation in plots
options(scipen = '999')

#################################################################################
# Create objects to store floating constants in for indexing and custom equations
#################################################################################
# For scaling outputs
scale_size = 1000000
start_year <- 2002
end_year <- 2024
#######################
# Read in country data
#######################
# EM-DAT

emdat_data_occ <-
  read.csv('data/Countries/emdat_country_occ.csv', stringsAsFactors = FALSE) %>%
  dplyr::filter(
    dplyr::between(
      .data$Year, start_year, end_year
      )
    )

emdat_data_yearly <-
  emdat_data_occ %>%
    dplyr::group_by(
      .data$`Country`,
      .data$`Year`,
      .data$Type.of.event
    ) %>%
    dplyr::summarise(
      `Total.affected` = sum(.data$`Sum.of.Total.affected`),
      `Total.Damage` = sum(.data$`Sum.of.Total.Damage`),
      `Event Count` = sum(.data$`Sum.of.Total.Damage` > 0),
      .groups = "drop"
    )

emdat_data_occ$origin <- 'EM_DAT'

# Combine data
country_data <- emdat_data_occ
# Rename columns
names(country_data) <-
  c('id', 'country', 'year', 'peril', 'affected', 'damage', 'origin')

# Melt data to collapse damage type
country_data <-
  country_data %>%
  tidyr::pivot_longer(
    c("damage", "affected"),
    names_to = "damage_type"
  )

#################################################################
# Create vectors to store choices for inputs in the app.r script
#################################################################
# Create a countries vector
countries <- unique(country_data$country)
countries <- countries[order(countries)]
peril_names_global <- unique(country_data$peril)
peril_names_global <- peril_names_global[order(peril_names_global)]

# Set currency code
currency_code <- "USD"

# Create a place-holder for distribution types
basic_parametric <- c('Gamma', 'Log normal', 'Weibull', 'Pareto')

# Get frequency data
cost_data <- dplyr::filter(country_data, .data$damage_type == 'affected')
damage_data <-  dplyr::filter(country_data, .data$damage_type == 'damage')

cost_freq <-
  cost_data %>%
  dplyr::group_by(
    .data$country,
    .data$year,
    .data$peril,
    .data$damage_type
  ) %>%
  dplyr::summarise(
     value = sum(.data$value > 0),
    .groups = "drop"
  ) %>%
  tidyr::complete(.data$country, .data$peril, .data$year, fill = list(value = 0))

damage_freq <-
  damage_data %>%
  dplyr::group_by(
    .data$country,
    .data$year,
    .data$peril,
    .data$damage_type
  ) %>%
  dplyr::summarise(
    value = sum(.data$value > 0),
    .groups = "drop"
  ) %>%
  tidyr::complete(.data$country, .data$peril, .data$year, fill = list(value = 0))

# Combine the cost per person and loss data
frequency_data <- rbind(cost_freq, damage_freq)

country_data <-
  rbind(damage_data, cost_data)

rm(cost_freq, damage_freq, cost_data, damage_data)

#######################
# Read in scaling data
#######################
# Population data

population_data <- read.csv('data/Scale/population_data.csv')
gdp_data <- read.csv('data/Scale/gdp.csv')
# inflation_data <- read.csv('data/Scale/inflation.csv')

# Join data
scale_data <- full_join(population_data, gdp_data, by = c('Country', 'Year'))
# scale_data <- full_join(scale_data, inflation_data, by = c('Country', 'Year'))
rm(population_data, gdp_data)
names(scale_data) <- c('country', 'year', 'population', 'gdp')

#########################
# Read in archetype data
#########################
# Get all archetype cost data into one data frame
archetype_cost_data <- read_csv("data/Archetypes/archetype_cost_data.csv")
archetype_cost_data <- cbind(archetype_cost_data, data_type = "archetype_cost")
names(archetype_cost_data) <-
  c('archetype', 'year', 'peril', 'value', 'data_type')

# Get frequency data
archetype_freq_data <- expand_data(archetype_cost_data, "archetype")

# Fill NA with zeroes
#archetype_cost_freq <- fill_na(archetype_cost_freq)
archetype_freq_data$value[is.na(archetype_freq_data$value)] <- 0
archetype_freq_data$value <- ifelse(archetype_freq_data$value > 0, 1, 0)

# Get all archetype frequency data into data frame
archetype_freq_data <-
  archetype_freq_data[c('year', 'peril', 'value','archetype', 'data_type')]
archetypes <- unique(archetype_cost_data$archetype)
archetypes <- archetypes[order(archetypes)]

# Number of years in each time horizon
years_archetype <- unique(archetype_cost_data$year)
years_country <- unique(country_data$year)
min_year <- min(min(years_archetype),min(years_country))
max_year <- max(max(years_archetype),max(years_country))
num_years <-
  pmax(
    max(years_archetype) - min(years_archetype) + 1,
    max(years_country) - min(years_country) + 1
  )

## Define text for the about page
about_page <-
  fluidPage(
    fluidRow(column(10, offset = 1,
      h1('About'),
      h2("Overview"),
      p(
        "
         This Tool has been developed to support users to better understand the
         risk of losses occurring from natural disasters. It is an educational
         tool which aims to increase the user's understanding of the risk
         associated with disaster and loss distributions and ways to financially
         mitigate that risk (via the associated spreadsheet).
         This Tool can be used with any of the following: preloaded country data,
         one of the six preloaded data archetypes, manually inputted data or
         catastrophe risk model output data, both of which may be uploaded into
         the tool. This Tool depends on the quality of the data which is input.
         Therefore, the output from this Tool remains only an indication of the
         losses associated with a natural disaster, actual losses may differ
         significantly from the Tool's output.
         The Tool is designed to work on a laptop or desktop PC with the web
         browser maximised, you may not be able to use the Tool on smaller
         screens. Please read the user guides before use.
        "
      ),
      h2("Authorship"),
      p(
        "
          This Tool was developed by Maximum Information on behalf of the Risk
          Modelling Steering Group (RMSG) at the Insurance Development Forum (IDF)
          with support of the Disaster Risk Financing and Insurance Program (DRFIP)
          which is housed in the Finance, Competitiveness and Innovation Global
          Practice of the World Bank Group.
        "),
      h2("Disclaimer"),
      p(
        "
          This Tool has been developed to support users better understand the risk
          of losses caused by natural disasters. Information in the Tool is provided
          for educational purposes only and does not constitute legal or scientific
          advice or service. Neither the IDF or World Bank makes warranties or
          representations, express or implied as to the accuracy or reliability of
          the Tool or the data contained therein. Users of the Tool should seek
          qualified expert advice for specific diagnostic and analysis of a
          particular project. Any use thereof or reliance thereon is at the sole
          and independent discretion and responsibility of the user. No conclusions
          or inferences drawn from the Tool should be attributed to either The IDF
          or World Bank. In no event will the IDF or World Bank be liable for any form
          of damage arising from the application or misapplication of the tool, or
          any other associated materials.
        "
      )
    )),
    fluidRow(column(width = 12, align = "center",
      br(),
      actionButton("start_btn", "Use the Tool", icon("crosshairs"))
    ))
  )

## Define text for user guide page
user_guide <-
  fluidPage(
    fluidRow(column(10, offset = 1,
      h1('User Guide Links'),
      p("Please find links to the model documentation:"),
      downloadLink("user_guide_download", "Link to user guide", style = "color:blue"),
      p("This comprises a quick start guide as well as a more detailed reference guide explaining the functionality of the model.")

    ))
  )

# Define text for tab 1 heading
tab1_heading <-
  fluidRow(column(10, offset = 1,
    h2('Data Selection'),
    p("Please make selections to specify the data you wish to analyse. The data selected can be viewed using the graphic at the bottom of the page or edited by switching to the table and double clicking the relevant cells."),
    p("If you wish to have extra flexibility in specifying the data source and/or statistics produced, please select Advanced mode below."),
    br()
  ))

# Define text for scaling heading
scale_heading <-
  fluidRow(column(10, offset = 1,
    h2('Scaling'),
    p("Scaling can remove trends caused by known indexes such as population, to help make losses more comparable between years. Basic mode always scales by population but advanced mode allows for more options."),
    p("For each given year, a scaling factor is calculated by dividing the scaling data for the most recent year by the given year. Each peril year is then multiplied by the scaling factor for that year to give a corrected loss in terms of the most recent scaling year."),
    br()
  ))

# Define text for detrending heading
detrend_heading <-
  fluidRow(column(10, offset = 1,
    h2('Detrending'),
    p("Detrending also aims to remove trends from the data, but does so automatically, without extra data, by performing a linear regression."),
    p("For each peril, the Tool looks for any linear trends and, if successful, the user can choose to modify the loss data in order to remove the trend."),
    br()
  ))

# Define text for final data heading
final_data_heading <-
  fluidRow(column(10, offset = 1,
    h2('Final Data '),
    p("The peril data displayed below has been multiplied by the chosen scaling factors and detrended (if detrending selected in advanced mode)."),
    p("This data is what the tool will use to fit the parametric distributions to each peril and produce the outputs."),
    br(),
  ))

# Define text for simulations heading
sim_heading <-
  fluidRow(column(10, offset = 1,
    h2('Simulations'),
    p("The Tool runs 15,000 simulations for each parametric distribution that has been successfully fitted to a given peril. If multiple distributions are fit for a peril, the one with the highest AIC (Aikaike Information Criterion) weight is selected."),
    p("In advanced mode the user can change the selected distribution for a given peril."),
    br()
  ))

# Define text for quality of fit heading
qof_heading <-
  fluidRow(column(10, offset = 1,
    h2('Quality of Severity Fit and Maximum Likelihood Estimates'),
    p("The table below displays the results from each successful distribution fitting for the selected peril."),
    p("The Tool tries to find the best (most likely) parameters for each fitted distribution to estimate the distribution of the observed data. The maximum likelihood estimates (MLEs) are the parameters of the estimated distributions."),
    p("The AIC weight measures the quality of fit of the estimated distributions - the higher the AIC weight, the better the fit."),
    br()
  ))

# Define text for outputs heading
outputs_heading <-
  fluidRow(column(10, offset = 1,
    h2('Outputs'),
    p("In this tab, the user can view the simulated losses across the selected perils calculated from the distributions selected on the previous page. Selecting combinations of perils will combine each peril's simulations to produce a new set of 15,000 simulations. Therefore the risk profile of two perils is not the sum of the losses at each return period. When perils are combined the tools assumes no correlation between each peril."),
    p("95% confidence intervals can be toggled. These show the range of possible values for each return period that 95% of losses will fall within."),
    br()
  ))

