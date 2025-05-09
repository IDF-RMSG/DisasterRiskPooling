#' rbern
#'
#' Random sample from Bernoulli distribution.
#' @param n Sample size.
#' @param prob A vector of success probabilities.
#'
#' @return Binary vector of length \code{n}.
#' @export
#'
#' @examples
#' rbern(1000, 0.5)
#' rbern(5000, 0.04)
rbern <- function(n,prob) {
  rbinom(n,size=1,prob=prob)
}


#' dgumbel
#'
#' Density function for the Gumbel distribution with location and scale parameters.
#' @param x Vector.
#' @param mu Location parameter.
#' @param s Scale parameter.
#'
#' @return Density Function.
#' @export
#'
#' @examples
#' dgumbel(-1:2, -1, 0.5)
dgumbel <- function(x,mu,s){ # PDF
  exp((mu - x)/s - exp((mu - x)/s))/s
}


#' pgumbel
#'
#' Distribution function for the Gumbel distribution with location and scale parameters.
#' @param q Vector.
#' @param mu Location parameter.
#' @param s Scale parameter.
#'
#' @return Distribution function.
#' @export
#'
#' @examples
#' pgumbel(-1:2, -1, 0.5)
pgumbel <- function(q,mu,s){ # CDF
  exp(-exp(-((q - mu)/s)))
}


#' rgumbel
#' Generate random deviates from the Gumbel distribution with location and scale parameters.
#'
#' @param n Number of observations.
#' @param mu Location parameter.
#' @param s Scale parameter.
#'
#' @return Binary vector of length \code{n}.
#' @export
#'
#' @examples
#' rgumbel(6, -1, 0.5)
rgumbel <- function(n, mu, s){ # quantile function
  return_array <- mu-s*log(-log(runif(n)))
  return_array[return_array < 0] <- 0
  return_array
}


#' dfrechet
#'
#' Density function for the Frechet distribution with shape and scale parameters.
#'
#' @param x Vector.
#' @param alpha Shape parameter.
#' @param s Scale parameter.
#'
#' @return Density function.
#' @export
#'
#' @examples
#' dfrechet(2:4, 0.8, 0.5)
dfrechet <- function(x,alpha,s) {
  (alpha/s)*(x/s)^(-1-alpha)*exp(-(x/s)^(-alpha))
}

#' pfrechet
#'
#' Distribution function for the Frechet distribution with shape and scale parameters.
#' @param q Vector.
#' @param alpha Shape parameter.
#' @param s Scale parameter.
#'
#' @return Distribution function.
#' @export
#'
#' @examples
#' pfrechet(2:4, 0.8, 0.5)
pfrechet <- function(q,alpha,s) {
  exp(-(s/q)^alpha)
}

#' rfrechet
#'
#' Generate random deviates from the Frechet distribution with shape and scale parameters.
#' @param n Number of observations.
#' @param alpha Shape parameter.
#' @param s Scale parameter.
#'
#' @return Binary vector of length \code{n}.
#' @export
#'
#' @examples
#' rfrechet(6, 0.8, 0.5)
rfrechet <- function(n,alpha,s) {
  s*(-log(runif(n)))^(-1/alpha)
}

# These are slightly different to those implemented in the tools as it corrects the definition of skewness
# (https://www.itl.nist.gov/div898/handbook/eda/section3/eda35b.htm)


#' Sample Skewness
#'
#' This function calculates the adjusted Fisher-Pearson coefficient of skewness, adjusted for sample size.
#' @param x Sample data.
#'
#' @return A number.
#' @export
#'
#' @examples
#' sample_skew <- sample_skewness(data)
sample_skewness <- function(x) {
  if (length(x) <= 2) return(NA)
  n <- length(x)
  (sum(n*(x - mean(x))^3)/((n-1)*(n-2)*(sample_var(x))^(3/2)))
}

#' Sample Variance
#'
#' This function calculates the sample variance.
#' @param x Sample data.
#'
#' @return A number.
#' @export
#'
#' @examples
#' sample_var <- sample_var(data)
sample_var <- function(x) {
  if (length(x) <= 1) return(NA)
  n <- length(x)
  sum((x-mean(x))^2)/(n-1)
}

#' Sample excess kurtosis
#'
#' This function calculates the samples excess kurtosis, adjusted for sample size.
#' @param x Sample data.
#'
#' @return A number.
#' @export
#'
#' @examples
#' sample_exkurtosis <- sample_excess_kurtosis(data)
sample_excess_kurtosis <- function(x) {
  if (length(x) <= 3) return(NA)
  n <- length(x)
  ((n+1)*n*sum((x-mean(x))^4))/((n-1)*(n-2)*(n-3) * sample_var(x)^2) - 3*(n-1)^2/((n-2)*(n-3))
}

#' beta_mom
#'
#' This function estimates the parameters of the Beta distribution which best fits the data, using the method of moments approach.
#' @param data Data frame.
#'
#' @return A vector of estimated parameters for the Beta distribution.
#' @export
#'
#' @examples
#' mom_fit_beta <- beta_mom(sub_dat$value)
beta_mom <- function(data) {
  if (length(data) == 0L) {
    return(list(shape1 = 2, shape2 = 3, a = 0, b = 1))
  }
  sample_mean <- mean(data)
  sample_var <- sample_var(data)
  sample_skew <- sample_skewness(data)
  sample_exkurtosis <- sample_excess_kurtosis(data)

  if (sample_skew == 0 & sample_exkurtosis >-2 & sample_exkurtosis <0) {
    v = (3*sample_exkurtosis+6)/(-sample_exkurtosis)
    p = v/2
    q = p

  } else if ((sample_skew^2 - 2 < sample_exkurtosis) & (sample_exkurtosis < 1.5 * sample_skew^2)) {
    v = 3*(sample_exkurtosis-sample_skew^2 + 2)/(1.5*sample_skew^2 - sample_exkurtosis)
    interim_calc <- sqrt(1 + (16*(v+1)/(((v+2) *sample_skew)^2)))
    p_est = 0.5*v*(1+1/interim_calc)
    q_est = 0.5*v*(1-1/interim_calc)
    if (sample_skew < 0) {
      p = pmax(p_est,q_est)
      q = pmin(p_est,q_est)
    } else {
      q = pmax(p_est,q_est)
      p = pmin(p_est,q_est)
    }

  } else {
    # We have failed at a MOM estimate - we should probably provide a reasonable guess for a Beta solution
    return(list(shape1 = 2, shape2 = 3, a = 0, b = 1))
  }

  b = 0.5*sqrt(sample_var) *sqrt(((2+v)*sample_skew)^2 + 16*(1+v))
  a = 0

  return(list(shape1 = p, shape2 = q, b = b))

}



#' dBeta_ab
#'
#' Density function for the 4-parameter Beta distribution.
#' @param x A vector.
#' @param shape1 Shape parameter.
#' @param shape2 Shape parameter.
#' @param b Boundary parameter.
#'
#' @return Density function.
#' @export
#'
dBeta_ab <- function(x, shape1=2, shape2=3, b=1){
  out <- (x>=0 & x<=b) * dbeta((x-0)/(b-0),shape1,shape2)/(b-0)
  return(out)
}


#' pBeta_ab
#'
#' Distribution function for the 4-parameter Beta distribution.
#' @param q A vector.
#' @param shape1 Shape parameter.
#' @param shape2 Shape parameter.
#' @param b Boundary parameter.
#'
#' @return Distribution function.
#' @export
#'
pBeta_ab <- function(q, shape1=2, shape2=3, b=1){
  out <- pbeta((q-0)/(b-0),shape1,shape2)
  return(out)
}

#
#' qBeta_ab
#'
#' Quantile function for the 4-parameter Beta distribution.
#' @param p A vector of probabilities.
#' @param shape1 Shape parameter.
#' @param shape2 Shape parameter.
#' @param b Boundary parameter.
#'
#' @return Quantile function.
#' @export
#'

qBeta_ab <- function(p, shape1=2, shape2=3, b=1){
  out <- (b-0)*qbeta(p,shape1,shape2) + 0
  return(out)
}


#' rBeta_ab
#'
#' Generates random deviates from the 4-parameter Beta distribution.
#' @param n Number of observations.
#' @param shape1 Shape parameter.
#' @param shape2 Shape parameter.
#' @param b Boundary parameter.
#'
#' @return Binary vector of length \code{n}.
#' @export
#'

rBeta_ab <- function(n, shape1=2, shape2=3, b = 1){
  X <- rbeta(n,shape1,shape2)
  out <- (b-0)*X + 0
  return(out)
}





