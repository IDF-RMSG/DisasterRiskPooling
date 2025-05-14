
#' test_linear_trend
#'
#' This function tests through each peril if a linear trend exists in the data.
#' @param dat Data frame
#'
#' @return Data frame with the perils and their p-values.
#' @export
#'
#' @examples
#' test_data <- sdr
#' all_perils <- test_linear_trend(test_data)
test_linear_trend <- function(dat){

  peril_names <- unique(dat$peril)
  result_list <- list()
  for(i in 1:length(peril_names)){
    this_peril <- peril_names[i]
    sub_dat <- dat %>% filter(peril == this_peril)
    sub_dat$fit_x <- sub_dat$year - min_year

    sub_dat <- left_join(data.frame(fit_x = 0:(max_year-min_year)),sub_dat,by="fit_x")
    sub_dat[is.na(sub_dat$value),"value"] <- 0

    lm_ob <- lm(data = sub_dat, value ~ fit_x)

    standard_error_for_slope <- sqrt(diag(vcov(lm_ob)))["fit_x"]
    t_test <- 2*(1-pt(abs(lm_ob$coefficients["fit_x"]/standard_error_for_slope),df = (max_year-min_year+1)-2))

    if (!is.na(t_test) & !is.null(t_test)) {
      t_test_bool <- if(t_test < 0.05) TRUE else FALSE
    } else {
      t_test_bool <- FALSE
    }
    if (t_test_bool == TRUE) {
      test_outputs <- detrend_linear_data(sub_dat)
      if (any(test_outputs$trend_value < 0)) {
        t_test_bool <- FALSE
      }
    }
    result_data <- data_frame(peril = this_peril,
                              p_value = t_test_bool)
    result_list[[i]] <- result_data
  }
  out <- do.call('rbind', result_list)
  return(out)
}


#' detrend_linear_data
#'
#' This function applies linear detrending to the data.
#' @param dat Data frame with linear trend.
#'
#' @return Data frame with detrended data.
#' @export
#'
#' @examples
#' sub_data <- detrend_linear_data(sub_data)
detrend_linear_data <- function(dat){
  # get linear predictions
  return_df <- dat
  # Adjust for fit
  return_df$fit_x <- return_df$year - min_year

  return_df <- left_join(data.frame(fit_x = 0:(max_year-min_year)),return_df,by="fit_x")
  return_df[is.na(return_df$value),"value"] <- 0
  fit_model <- lm(data = return_df, value ~ fit_x)
  fitted_values <- fit_model$fitted.values
  # If the coefficient is negative - adjust from the first point - if it is positive then we use latest point.
  if (fit_model$coefficients["fit_x"] < 0) {
    return_df$trend_value <- fit_model$coefficients["(Intercept)"] + (return_df$value - fitted_values)
  } else {
    return_df$trend_value <- return_df[length(return_df$value),"value"] + (return_df$value - fitted_values)
  }
  return_df$fit_x <- NULL
  
  return(return_df)
}
