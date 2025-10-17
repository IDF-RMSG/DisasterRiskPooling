return_bootstrap <- function(data, dis_name, niter) {

  data <- if(dis_name == 'Freq') {data[[2]]} else {data[[1]]}
  dis_name <- if(dis_name == 'Freq') {"nbinom"} else {dis_name}
  dist <- fitdistrplus::fitdist(data$value, dis_name)
  fitdistrplus::bootdist(dist, niter = niter, bootmethod = "nonparam")
}


make_bootsrap <- function(dis_name, dat, n_sim){

  dat <- dat |>  dplyr::filter(distribution == dis_name)

  if(dis_name == 'Freq') {
    sim <- stats::rnbinom(n = n_sim, size = dat$`mle1`, mu = dat$`mle2`)
  } else if(dis_name == 'Log normal'){
    if(any(is.na(dat$aic))){
      sim <- NA
    }  else {
      sim <- rlnorm(n = n_sim, meanlog = dat$`mle1`, sdlog = dat$`mle2`)
    }
  } else if (dis_name == 'Gamma'){
    if(any(is.na(dat$aic))){
      sim <- NA
    }  else {
      sim <- rgamma(n = n_sim, shape = dat$`mle1`, scale = 1/(dat$`mle2`))
    }
    # } else if (dis_name == 'Beta'){
    #   if(any(is.na(dat$aic))){
    #     sim <- NA
    #   } else {
    #     sim <- rBeta_ab(n = 15000, shape1 = dat$`mle1`, shape2 = dat$`mle2`, b = dat$`mle3`)
    #     sim_lower <- rBeta_ab(n = 15000, shape1 = dat$`mle1_lower`, shape2 = dat$`mle2_lower`,
    #                           b = dat$`mle3_lower`)
    #     sim_upper <- rBeta_ab(n = 15000, shape1 = dat$`mle1_upper`, shape2 = dat$`mle2_upper`,
    #                           b = dat$`mle3_upper`)
    #
    #   }
    # }  else if (dis_name == 'Frechet'){
    #   if(any(is.na(dat$aic))){
    #     sim <- NA
    #   }  else {
    #     sim <- rfrechet(n = 15000,alpha = dat$`mle1`, s = dat$`mle2`)
    #     sim_lower <- rfrechet(n = 15000,alpha = dat$`mle1_lower`, s = dat$`mle2_lower`)
    #     sim_upper <- rfrechet(n = 15000,alpha = dat$`mle1_upper`, s = dat$`mle2_upper`)
    #
    #   }
    # } else if (dis_name == 'Gumbel'){
    #   if(any(is.na(dat$aic))){
    #     sim <- NA
    #   } else {
    #     sim <- rgumbel(n = 15000, mu = dat$`mle1`, s = dat$`mle2`)
    #     sim_lower <- rgumbel(n = 15000, mu = dat$`mle1_lower`, s = dat$`mle2_lower`)
    #     sim_upper <- rgumbel(n = 15000, mu = dat$`mle1_upper`, s = dat$`mle2_upper`)
    #
    #   }
  } else if (dis_name == 'Weibull'){
    if(any(is.na(dat$aic))){
      sim <- NA
    }  else {
      sim <- rweibull(n = n_sim, shape = dat$`mle1`, scale = dat$`mle2`)
    }
  } else {
    if(any(is.na(dat$aic))){
      sim <- NA
    }  else {
      sim <- extraDistr::rpareto(n = 15000, a = dat$`mle1`, b = dat$`mle2`)
    }
  }

  sim <- as.data.frame(sim)
  sim[sim < 0] <- 0

  sim

}



#' make_simulation
#'
#' This function takes the name of the distribution with the lowest AIC score and the corresponding MLE and AIC values, then simulates 15,000 observations.
#' @param dis_name The name of the distribution, which will used to run the simulations.
#' @param dat  Data frame which includes the corresponding MLE values.
#' @return 15,000 simulated values.
#' @export
#'
#' @examples
#' make_simulation(dis_name = sub_peril$distribution, dat = sub_peril)
make_simulation <- function(dis_name, dat, n_sim){

  dat <- dat |>  dplyr::filter(distribution == dis_name)

  if(dis_name == 'Freq' & !is.na(dat$mle2)) {
      sim <- stats::rnbinom(n = n_sim, mu = dat$`mle2`, size = dat$`mle1`)
  } else if(dis_name == 'Freq' & is.na(dat$mle2)){
      sim <- stats::rpois(n = n_sim, lambda = dat$`mle1`)
  } else if(dis_name == 'Log normal'){
    if(any(is.na(dat$aic))){
      sim <- NA
    }  else {
      sim <- rlnorm(n = n_sim, meanlog = dat$`mle1`, sdlog = dat$`mle2`)
    }
  } else if (dis_name == 'Gamma'){
    if(any(is.na(dat$aic))){
      sim <- NA
    }  else {
      sim <- rgamma(n = n_sim, shape = dat$`mle1`, scale = 1/(dat$`mle2`))
    }
  # } else if (dis_name == 'Beta'){
  #   if(any(is.na(dat$aic))){
  #     sim <- NA
  #   } else {
  #     sim <- rBeta_ab(n = 15000, shape1 = dat$`mle1`, shape2 = dat$`mle2`, b = dat$`mle3`)
  #     sim_lower <- rBeta_ab(n = 15000, shape1 = dat$`mle1_lower`, shape2 = dat$`mle2_lower`,
  #                           b = dat$`mle3_lower`)
  #     sim_upper <- rBeta_ab(n = 15000, shape1 = dat$`mle1_upper`, shape2 = dat$`mle2_upper`,
  #                           b = dat$`mle3_upper`)
  #
  #   }
  # }  else if (dis_name == 'Frechet'){
  #   if(any(is.na(dat$aic))){
  #     sim <- NA
  #   }  else {
  #     sim <- rfrechet(n = 15000,alpha = dat$`mle1`, s = dat$`mle2`)
  #     sim_lower <- rfrechet(n = 15000,alpha = dat$`mle1_lower`, s = dat$`mle2_lower`)
  #     sim_upper <- rfrechet(n = 15000,alpha = dat$`mle1_upper`, s = dat$`mle2_upper`)
  #
  #   }
  # } else if (dis_name == 'Gumbel'){
  #   if(any(is.na(dat$aic))){
  #     sim <- NA
  #   } else {
  #     sim <- rgumbel(n = 15000, mu = dat$`mle1`, s = dat$`mle2`)
  #     sim_lower <- rgumbel(n = 15000, mu = dat$`mle1_lower`, s = dat$`mle2_lower`)
  #     sim_upper <- rgumbel(n = 15000, mu = dat$`mle1_upper`, s = dat$`mle2_upper`)
  #
  #   }
  } else if (dis_name == 'Weibull'){
    if(any(is.na(dat$aic))){
      sim <- NA
    }  else {
      sim <- rweibull(n = n_sim, shape = dat$`mle1`, scale = dat$`mle2`)
    }
  } else {
    if(any(is.na(dat$aic))){
      sim <- NA
    }  else {
      sim <- extraDistr::rpareto(n = 15000, a = dat$`mle1`, b = dat$`mle2`)
    }
  }

  sim <- as.data.frame(sim)
  sim[sim < 0] <- 0

  sim

}



#' combine_freq_sev_ci
#'
#' @param freq_sev_ci Input list of all peril names and a list of the distributions attributable to those perils.
#' @param peril_names List of all the peril names.
#' @param peril_distributions List of the distributions attributable to the perils.
#' @param percentile_granularity Set to 100.
#' @param return_percentiles 0.025, 0.5, 0.975.
#' @param percentile_interval 0.5, 0.99.
#'
#' @return
#' @export
#'
#' @examples
#' return_val <- combine_freq_sev_ci(freq_sev_ci = fvci,
#'                                   peril_names = all_perils,
#'                                   peril_distributions = peril_dists)
combine_freq_sev_ci <- function(freq_sev_ci,
                                peril_names,
                                peril_distributions,
                                percentile_granularity = 100,
                                return_percentiles = c(0.025,0.5,0.975),
                                percentile_interval = c(0.5,0.99)) {

  return_list <- NA
  dist_list_entry <- sum_across_two_indexes(list_structure = freq_sev_ci,
                                            first_level_indexes = peril_names,
                                            second_level_indexes = peril_distributions)
  if (!is.null(dist_list_entry)) {

    #The following line gives the average for the resamples.
    average_resamples <- unlist(lapply(dist_list_entry,FUN = mean))
    average_resamples <- average_resamples[!is.na(average_resamples)]

    # The following line gives the respective percentiles starting at 50%.
    percentile_resamples <- lapply(dist_list_entry,FUN=quantile,prob = seq(percentile_interval[1],percentile_interval[2],by=1/percentile_granularity))

    percentile_resamples <- apply(do.call("rbind",percentile_resamples),MARGIN = 2,FUN = quantile,probs = return_percentiles)

    return_list <- list(average = quantile(average_resamples,probs = return_percentiles),percentiles = percentile_resamples)
  }
  return(return_list)
}


#' get_freq_sev_ci
#'
#' This function takes the MLEs from the previous outputs and uses the input data to calculate a frequency distribution and hence estimates a freq*sev distribution for each combination of perils
#' @param the_right_data Data frame.
#' @param ci_mle_list List of the chosen MLE parameters for each peril.
#' @param number_of_simulations Number of simulations, default is 1000
#' @param number_of_resamples Number of resamples, default is 1000
#'
#' @return
#' @export
#'
#' @examples
#' return_list <- get_freq_sev_ci(the_right_data = input_data, ci_mle_list = distribution_mles)
get_freq_sev_ci <- function(bootstraps,
                            number_of_simulations = 1000,
                            number_of_resamples = 1000,
                            percentile_granularity = 100,
                            return_percentiles = c(0.025,0.5,0.975),
                            percentile_interval = c(0.5,0.99)) {

overall_bootstrap_sample <-
  bootstraps |>
    purrr::transpose() |>
    purrr::map(~ purrr::reduce(.x, `+`))

average_resamples <-
  lapply(overall_bootstrap_sample, FUN = mean) |>
    unlist()

average_resamples <- average_resamples[!is.na(average_resamples)]

# The following line gives the respective percentiles starting at 50%.
percentile_resamples <-
  lapply(
    overall_bootstrap_sample,
    FUN = quantile,
    prob =
      seq(
        percentile_interval[1],
        percentile_interval[2],
        by = 1 / percentile_granularity
      )
  )

percentile_resamples <-
  apply(
    do.call("rbind", percentile_resamples),
    MARGIN = 2,
    FUN = quantile, probs = return_percentiles
  )

  list(
    average = quantile(average_resamples, probs = return_percentiles),
    percentiles = percentile_resamples
  )

}


#' sim_bern
#'
#' This function simulates the frequency data based on the mle of bernoulli.
#' @param the_right_data Data frame, which is either the scaled, detrended or core data, depending on the inputs selected
#'
#' @return Data frame with 15,000 simulated values for each peril.
#' @export
#'
#' @examples
#' simulate_bernoulli <- reactive({
#' rd <- get_right_data()
#' rd <- rd[[2]]
#' temp<- sim_bern(rd)
#' return(temp)
#' })
sim_bern <- function(the_right_data = NULL){
  require(tidyverse)
  # the right data should be either scaled, detrended or core data, depending on inputs
  data_list <- list()
  out <- NULL
  if(!is.null(the_right_data) && nrow(the_right_data) > 0){
    freq_data <- the_right_data
    num_trials <- max(freq_data$year) - min(freq_data$year)
    num_trials <- num_trials + 1
    all_perils <- unique(freq_data$peril)
    for(i in 1:length(all_perils)){
      peril_name <- all_perils[i]
      sub_dat <- freq_data %>% dplyr::filter(peril == peril_name)
      if(sum(sub_dat$value) > 0){
        mle_bern <- nrow(sub_dat[sub_dat$value == 1,])/num_trials
        uniform_dis <- runif(15000,0 ,1)
        uni_dat <- as.data.frame(cbind(simulation_num = 1:15000, uniform_dis = uniform_dis))
        uni_dat$value <- ifelse(uni_dat$uniform_dis < mle_bern, 1, 0)
        uni_dat$uniform_dis <- NULL
        uni_dat$simulation_num <- NULL
        uni_dat$peril <- peril_name
        uni_dat <- uni_dat[, c('peril', 'value')]
        data_list[[i]] <- uni_dat
      }
    }
    out <- do.call('rbind', data_list)
  }
  return(out)
}


#' prepare_simulationa
#'
#' This function prepares the data for simulations
#' @param fitted_distribution 5 column data frame as produced by the fit_distribution function.
#' @param dist_flood Selected distribution for flood.
#' @param dist_drought Selected distribution for drought.
#' @param dist_storm Selected distribution for storm.
#' @param dist_earthquake Selected distribution for earthquake.
#'
#' @return Data frame.
#' @export
#'
#' @examples
#' prepared_simulations <- reactive({
#' fd <- fitted_distribution()[[1]]
#' x <- prepare_simulations(fd, dist_flood = input$dist_flood_input,
#'                          dist_drought = input$dist_drought_input,
#'                          dist_storm = input$dist_storm_input,
#'                          dist_earthquake = input$dist_earthquake_input)
#' x
#' })
prepare_simulations <- function(fitted_distribution = NULL,
                                dist_flood = NULL,
                                dist_drought = NULL,
                                dist_storm = NULL,
                                dist_earthquake = NULL){
  # fitted_distribution should be a 5 column df as produced by fit_distribution

  if(is.null(dist_flood)){
    dist_flood = 'Gamma'
  }
  if(is.null(dist_drought)){
    dist_drought = 'Gamma'
  }
  if(is.null(dist_storm)){
    dist_storm = 'Gamma'
  }
  if(is.null(dist_earthquake)){
    dist_earthquake = 'Gamma'
  }
  out <- NULL
  if(!is.null(fitted_distribution) && nrow(fitted_distribution) > 0){
    out <-
      fitted_distribution  |>
      dplyr::mutate(keep = FALSE) |>
        dplyr::filter(
          (.data$peril == 'Flood' & .data$distribution == dist_flood) |
          (.data$peril == 'Drought' & .data$distribution == dist_drought) |
          (.data$peril == 'Cyclone' & .data$distribution == dist_storm) |
          (.data$peril == 'Earthquake' & .data$distribution == dist_earthquake) |
          (.data$distribution == "Freq")
        )
  }
  return(out)
}



#' run_simulations
#'
#' This function checks if the data is ready for simulation, then simulates the data with the "make_simulations" function. The simulated loss data is then multiplied by the simulated frequency data.
#' @param prepared_simulation_data Data frame that comes from the prepare_simulations function.
#' @param prepared_frequency_data Data frame of the simulated frequency data that comes from sim_bern function.
#'
#' @return A data frame with 15,000 rows with simulated values, including simulated values for both upper and lower quartiles, the simulated frequencies, and then the outcomes, including the upper and lower quartiles.
#' @export
#'
#' @examples
#' ran_simulations <- reactive({
#' rep_bern <- repeatable(simulate_bernoulli, seed = 122)
#' bs <- rep_bern()
#' ps <- prepared_simulations()
#' rep_sims <- repeatable(run_simulations, seed = 122) # setting seed to ensure repeatable outcomes
#' x <- rep_sims(ps, bs)
#' return(x)
#' })
run_simulations <- function(prepared_simulation_data = NULL, prepared_frequency_data = NULL){
  # prepared_simulation_data is the format that comes
  # from the prepare_simulations function, a 5 column df as produced by
  # fit_distribution, but filtered down to only include 1 distribution for
  # each peril, ie only 4 rows total
  # column names should be distribution, peril, mle1, mle2, aic

  out <- NULL
  ok <- FALSE
  if(!is.null(prepared_simulation_data)){
    if(nrow(prepared_simulation_data) > 0){
      ok <- TRUE
    }
  }

  if(ok){
    prepared_simulation_data <-
      prepared_simulation_data |>
        dplyr::filter(!is.na(.data$mle1))

    perils <-
      sort(
        unique(
          prepared_simulation_data$peril[prepared_simulation_data$distribution != "Freq"]
        )
      )

    out_list <- list()

    for(i in 1:length(perils)){

      this_peril <- perils[i]
      sub_peril <- prepared_simulation_data |>  dplyr::filter(peril == this_peril)
      sub_peril_severity <- dplyr::filter(sub_peril, .data$distribution != "Freq")
      freq <- make_simulation(dis_name = "Freq", dat = sub_peril, n_sim = 15000)

      severity_sim_count <- sum(freq$sim)

      severity <-
        make_simulation(
          dis_name = sub_peril_severity$distribution,
          dat = sub_peril_severity,
          n_sim = severity_sim_count
        )

      year_ids <- rep(seq_len(nrow(freq)), times = freq$sim)

      event_losses <-
        dplyr::bind_cols(year = year_ids, severity) |>
        dplyr::mutate(key = this_peril) |>
        dplyr::rename(value = sim)

      agg_losses <-
        event_losses |>
          dplyr::group_by(.data$year, .data$key) |>
          dplyr::summarise(value = sum(.data$value), .groups = "drop") |>
          tidyr::complete(year = 1:15000, fill = list(value = 0, key = this_peril))

      out_list[[i]] <-
        list(event_losses = event_losses, agg_losses = agg_losses)

    }

    out[[1]] <-
      out_list |>
        purrr::map(\(x) x[[1]]) |>
        dplyr::bind_rows()

    out[[2]] <-
      out_list |>
      purrr::map(\(x) x[[2]]) |>
      dplyr::bind_rows()

    out <- stats::setNames(out, c("Event", "Yearly"))
    # returns a dataframe with key, value, freq, n, and outcome
  }

  out

}
