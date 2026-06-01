#' Build a sampler from a distribution specification
#'
#' @param spec A named list defining a distribution.
#'
#' @return A function that takes `n` and returns simulated values.
#' @export
#'
#' @examples
#' # Normal distribution
#' normal_sampler <- build_sampler(list(
#'   distribution = "normal",
#'   mean = 27,
#'   sd = 4
#' ))
#' normal_sampler(5)
#'
#' # Skew-normal distribution
#' skew_normal_sampler <- build_sampler(list(
#'   distribution = "skew_normal",
#'   location = 10, # centre; approximates mean if no skew
#'   scale = 2, # spread; approximates SD if no skew
#'   shape = 5 # skew direction/strength; positive = right skew
#' ))
#' skew_normal_sampler(5)
#'
#' # Log-normal distribution
#' log_normal_sampler <- build_sampler(list(
#'   distribution = "log_normal",
#'   meanlog = 2,
#'   sdlog = 0.3
#' ))
#' log_normal_sampler(5)
#'
#' # Uniform distribution
#' uniform_sampler <- build_sampler(list(
#'   distribution = "uniform",
#'   min = 18,
#'   max = 85
#' ))
#' uniform_sampler(5)
#'
#' # Beta distribution
#' beta_sampler <- build_sampler(list(
#'   distribution = "beta",
#'   shape1 = 2, # pulls values toward 1
#'   shape2 = 5 # pulls values toward 0
#' ))
#' beta_sampler(5)
#'
#' # Categorical distribution
#' categorical_sampler <- build_sampler(list(
#'   distribution = "categorical",
#'   levels = c("Female", "Male"),
#'   probabilities = c(0.5, 0.5)
#' ))
#' categorical_sampler(5)
#'
#' # Fixed value
#' fixed_sampler <- build_sampler(list(
#'   distribution = "fixed",
#'   value = 0.15
#' ))
#' fixed_sampler(5)
#'
#' # Mixture distribution
#' mixture_sampler <- build_sampler(list(
#'   distribution = "mixture",
#'   components = list(
#'     list(
#'       distribution = "normal",
#'       mean = 0,
#'       sd = 1,
#'       weight = 0.7
#'     ),
#'     list(
#'       distribution = "normal",
#'       mean = 5,
#'       sd = 1,
#'       weight = 0.3
#'     )
#'   )
#' ))
#' mixture_sampler(5)

build_sampler <- function(spec) {
  distribution <- spec$distribution

  if (is.null(distribution)) {
    stop("spec must include `distribution`.")
  }

  sampler <- switch(
    distribution,
    normal = .build_normal_sampler(spec),
    skew_normal = .build_skew_normal_sampler(spec),
    log_normal = .build_log_normal_sampler(spec),
    uniform = .build_uniform_sampler(spec),
    beta = .build_beta_sampler(spec),
    categorical = .build_categorical_sampler(spec),
    fixed = .build_fixed_sampler(spec),
    mixture = .build_mixture_sampler(spec),
    stop("Unknown distribution: ", distribution)
  )

  return(sampler)
}
