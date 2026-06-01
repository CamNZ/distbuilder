# ------------------------------------------------------------------------------
# uniform_distribution.R
#
# Simulates values from a continuous uniform distribution using runif().
#
# Example YAML:
#
# Age:
#   distribution: uniform
#   min: 18
#   max: 85
# ------------------------------------------------------------------------------

.build_uniform_sampler <- function(spec) {
  # Input validation
  .require_param(spec, "min", "uniform")
  .require_param(spec, "max", "uniform")
  
  .check_single_numeric(spec$min, "uniform `min`")
  .check_single_numeric(spec$max, "uniform `max`")
  
  if (spec$min >= spec$max) {
    stop("uniform `min` must be less than `max`.")
  }
  
  # Create sampler
  sampler <- function(n) {
    runif(
      n = n,
      min = spec$min,
      max = spec$max
    )
  }
  
  return(sampler)
}