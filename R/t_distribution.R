# ------------------------------------------------------------------------------
# t_distribution.R
#
# Simulates values from a location-scale t distribution using rt().
#
# Example YAML:
#
# Residual:
#   distribution: t
#   location: 0
#   scale: 1
#   df: 5
# ------------------------------------------------------------------------------

.build_t_sampler <- function(spec) {
  # Input validation
  .require_param(spec, "location", "t")
  .require_param(spec, "scale", "t")
  .require_param(spec, "df", "t")

  .check_single_numeric(spec$location, "t `location`")
  .check_single_numeric(spec$scale, "t `scale`")
  .check_single_numeric(spec$df, "t `df`")

  if (spec$scale <= 0) {
    stop("t `scale` must be positive.")
  }

  if (spec$df <= 0) {
    stop("t `df` must be positive.")
  }

  # Create sampler
  sampler <- function(n) {
    spec$location + spec$scale * stats::rt(
      n = n,
      df = spec$df
    )
  }

  return(sampler)
}
