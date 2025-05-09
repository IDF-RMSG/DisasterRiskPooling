
#' Expand data
#'
#' This function takes an arbitrary data set and expands from long form to wide form.
#' @param data
#'
#' @return Data frame.
#' @export
#'
#' @examples
#' expand_data(cost_data, "country")
#' expand_data(damage_data, "country")
expand_data <- function(data, country_archetype){

  if (country_archetype == "country") {
    data_combinations <- as.data.frame(expand.grid(year = unique(data$year),
                                      country = unique(data$country),
                                      peril = unique(data$peril),
                                      origin = unique(data$origin),
                                      damage_type = unique(data$damage_type)))
    # homogenize variable types
    data$damage_type <- as.character(data$damage_type)
    data$origin <- as.character(data$origin)
    data_combinations[[country_archetype]] <- as.character(data_combinations[[country_archetype]])
    data_combinations$peril <- as.character(data_combinations$peril)
    # join data
    data <- left_join(data_combinations, data)
  }
  else {
    data_combinations <- as.data.frame(expand.grid(year = unique(data$year),
                                                   archetype = unique(data$archetype),
                                                   peril = unique(data$peril),
                                                   data_type = unique(data$data_type)))
    # homogenize variable types
    data$data_type <- as.character(data$data_type)
    data_combinations[[country_archetype]] <- as.character(data_combinations[[country_archetype]])
    data_combinations$peril <- as.character(data_combinations$peril)
    # join data
    data <- left_join(data_combinations, data)
  }
  return(data)
}


#' Add identical lists
#' This function adds together two identical lists. In the case where either is empty it adds 0. If the lists are of unequal length, it will return the greatest list possible such that the two entries are added together.
#'
#' @param x
#' @param y
#'
#'
#' @export
#'
#' @examples
#' add_identical_lists(x = list_structure[[index_name]][[second_level_indexes[[index_position]]]],y = return_value)
add_identical_lists <- function(x,y) {

  if (length(x) == length(y) & length(x) == 0 |
      is.null(x) & is.null(y)) return(NULL)
  if (length(x) == 0 | is.null(x)) return(y)
  if (length(y) == 0 | is.null(y)) return(x)

  if (length(x) < length(y)) {
    return_list <- x
    add_list <- y
  } else {
    return_list <- y
    add_list <- x
  }

  for (i in seq_len(min(length(x),length(y)))) {
    return_list[[i]] <- return_list[[i]] + add_list[[i]]
  }

  return(return_list)
}


#' Match distribution names
#'
#' Matches distribution names such that if they are NULL or NA, then NULL or NA is returned. If the distribution names are one of: 'lnorm', 'Beta_ab', 'gamma','frechet', 'gumbel', 'weibull','pareto', then consequently 'Log normal', 'Beta', 'Gamma', 'Frechet', 'Gumbel', 'Weibull', 'Pareto' is returned.
#' @param x
#'
#'
#' @export
#'
#' @examples
#' peril_dists <- lapply(list(input$dist_drought_input,input$dist_earthquake_input,input$dist_flood_input,input$dist_storm_input),FUN=match_dist_names)
match_dist_names <- function(x) {
  if(is.null(x)) return(NA)
  if(is.na(x)) return(NA)
  c('Log normal', 'Beta', 'Gamma',
    'Frechet', 'Gumbel', 'Weibull',
    'Pareto')[match(x,c('Log normal', 'Beta', 'Gamma', 'Frechet', 'Gumbel', 'Weibull', 'Pareto'))]
}



#' Sum across two indexes
#'
#' This function subsets a list of lists to sum across in the format sum(x[[i_1]][[j_1]] + x[[i_2]][[j_2]]). Used within the combine_freq_sev_ci function.
#'
#' @param list_structure
#' @param first_level_indexes
#' @param second_level_indexes
#'
#'
#' @export
#'
#' @examples
#' sum_across_two_indexes(list_structure = freq_sev_ci, first_level_indexes = peril_names,second_level_indexes = peril_distributions)
sum_across_two_indexes <- function(list_structure,first_level_indexes,second_level_indexes) {
  return_value <- NULL
  for (index_name in first_level_indexes) {
    index_position <- match(index_name,first_level_indexes)
    if (!is.null(second_level_indexes[[index_position]])) {
      if (length(list_structure[[index_name]]) != 0L & second_level_indexes[[index_position]] %in% names(list_structure[[index_name]])) {
        return_value <- add_identical_lists(x = list_structure[[index_name]][[second_level_indexes[[index_position]]]],
                                            y = return_value)
      }
    }

  }
  return(return_value)
}

#' Transform Core data
#'
#' Function for making core data a one row per peril-year data set
#' @param cdx
#'
#' @return Data frame
#' @export
#'
#' @examples
#' out <- dat
#' out <- transform_core_data(out)
transform_core_data <- function(cdx){
  if(is.null(cdx)){
    return(NULL)
  }
  if(!is.list(cdx)){
    return(NULL)
  }
  if(length(cdx) != 2){
    return(NULL)
  }
  cdx2 <- cdx[[2]]
  cdx1 <- cdx[[1]]
  cdx1 <- cdx2 %>%
    dplyr::select(-value) %>%
    left_join(cdx1) %>%
    mutate(value = ifelse(is.na(value), 0, value))
  out <- list(cdx1, cdx2)
  return(out)
}


#' Elongate core data
#'
#' Transform core data back to long format
#' @param cdx
#'
#' @return Data frame
#' @export
#'
#' @examples
#' cdx1 <- cdx[[1]]
#' cdx2 <- cdx[[2]]
#' cdx1 <- widen_core_data(cdx1)
#' cdx1[i,j+1] <- as.numeric(v)
#' cdx1 <- elongate_core_data(cdx1)
#' cdx2 <- values_to_frequency(cdx1)
elongate_core_data <- function(cdx){

  if(is.null(cdx)){
    return(NULL)
  }
  if(!is.data.frame(cdx)){
    return(NULL)
  }
  if(nrow(cdx) == 0){
    return(NULL)
  }
  names(cdx)[1:2] <- tolower(names(cdx)[1:2])
  out <- cdx %>% gather(peril, value, names(cdx)[3:ncol(cdx)])
  return(out)
}


#' Widen core data
#'
#' Function widens the data from long to wide format.
#' @param cdx
#'
#' @return Data frame
#' @export
#'
#' @examples
#' if(nrow(data) <=3){
#' the_data  <- tibble(` ` = "Not enough observations available")
#' } else {
#'   the_data <- widen_core_data(data)
#'   }
widen_core_data <- function(cdx){
  if(is.null(cdx)){
    return(cdx)
  }
  cdx <- cdx %>%
    tidyr::spread(key = peril, value = value)
  names(cdx)[1:2] <- c('Year', 'Country')
  return(cdx)
}


#' Values to frequency
#'
#' This function converts values to frequency data.
#' @param cdx
#'
#' @return Data frame
#' @export
#'
#' @examples
#' cdx1 <- elongate_core_data(cdx1)
#' cdx2 <- values_to_frequency(cdx1)
values_to_frequency <- function(cdx){

  # takes the first item in the core-data() list and returns its frequency equivalent
  if(is.null(cdx)){
    return(NULL)
  }

  these_columns <-
    names(cdx)[!tolower(names(cdx)) %in% c('country', 'year', 'peril')]

  for(j in 1:length(these_columns)){
    this_column <- these_columns[j]
    old_vals <- cdx[,this_column]
    new_vals <- ifelse(old_vals > 0, 1, 0)
    cdx[,this_column] <- new_vals
  }
  return(cdx)
}


#' Calculate Scaling Factors
#'
#' This function takes a set of scaling data for a chosen country and turns it into factors relative to the most recent year
#' @param scaling_data
#' @param chosen_scale
#'
#' @return Data frame
#' @export
#'
#' @examples
#' scaling_data <- calc_scale_factors(raw_scaling_data, chosen_scale)
calc_scale_factors <- function(scaling_data, chosen_scale){
  # Set 0 values to na
  used_years <- scaling_data[,"year"]
  scaling_data[scaling_data == 0] <- NA
  chosen_scale <- tolower(chosen_scale)
  scaling_data[[chosen_scale]] <- as.numeric(scaling_data[[chosen_scale]])
  sub_dat <- scaling_data %>% arrange(-year) %>% drop_na()
  sub_dat$scale_factor <- sub_dat[[chosen_scale]][1]/sub_dat[[chosen_scale]]
  sub_dat <- left_join(tibble(year = used_years), sub_dat, by = "year")
  return(sub_dat)
}

