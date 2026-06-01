# ------------------------------------------------------------------------------
# normal_distribution.R
#
# Simulates values from a normal distribution using rnorm().
#
# Example YAML:
#
# BMI:
#   distribution: normal
#   mean: 27
#   sd: 4
# ------------------------------------------------------------------------------

.build_normal_sampler <- function(spec) {
  # Input validation
  .require_param(spec, "mean", "normal")
  .require_param(spec, "sd", "normal")

  .check_single_numeric(spec$mean, "normal `mean`")
  .check_single_numeric(spec$sd, "normal `sd`")

  if (spec$sd < 0) {
    stop("normal `sd` must be non-negative.")
  }

  # Create sampler
  sampler <- function(n) {
    stats::rnorm(
      n = n,
      mean = spec$mean,
      sd = spec$sd
    )
  }

  return(sampler)
}
