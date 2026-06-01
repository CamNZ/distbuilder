# ------------------------------------------------------------------------------
# categorical_distribution.R
#
# Simulates values from a categorical distribution using sample().
#
# Example YAML:
#
# Sex:
#   distribution: categorical
#   levels:
#     - Female
#     - Male
#   probabilities:
#     - 0.5
#     - 0.5
# ------------------------------------------------------------------------------

.build_categorical_sampler <- function(spec) {
  # Input validation
  .require_param(spec, "levels", "categorical")
  .require_param(spec, "probabilities", "categorical")
  
  if (length(spec$levels) == 0) {
    stop("categorical `levels` must contain at least one value.")
  }
  
  if (!is.numeric(spec$probabilities)) {
    stop("categorical `probabilities` must be numeric.")
  }
  
  if (length(spec$levels) != length(spec$probabilities)) {
    stop("categorical `levels` and `probabilities` must have the same length.")
  }
  
  if (any(is.na(spec$probabilities))) {
    stop("categorical `probabilities` must not contain NA.")
  }
  
  if (any(spec$probabilities < 0)) {
    stop("categorical `probabilities` must be non-negative.")
  }
  
  if (sum(spec$probabilities) <= 0) {
    stop("categorical `probabilities` must sum to a positive value.")
  }
  
  # Create sampler
  sampler <- function(n) {
    sample(
      x = spec$levels,
      size = n,
      replace = TRUE,
      prob = spec$probabilities
    )
  }
  
  return(sampler)
}