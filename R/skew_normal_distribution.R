# ------------------------------------------------------------------------------
# skew_normal_distribution.R
#
# Simulates values from a skew-normal distribution using sn::rsn().
# Positive shape gives right skew, negative shape gives left skew, and shape = 0
# gives a normal distribution.
#
# Example YAML:
#
# Biomarker:
#   distribution: skew_normal
#   location: 10
#   scale: 2
#   shape: 5
# ------------------------------------------------------------------------------

.build_skew_normal_sampler <- function(spec) {
  # Input validation
  .require_param(spec, "location", "skew_normal")
  .require_param(spec, "scale", "skew_normal")
  .require_param(spec, "shape", "skew_normal")

  .check_single_numeric(spec$location, "skew_normal `location`")
  .check_single_numeric(spec$scale, "skew_normal `scale`")
  .check_single_numeric(spec$shape, "skew_normal `shape`")

  if (spec$scale <= 0) {
    stop("skew_normal `scale` must be positive.")
  }

  if (!requireNamespace("sn", quietly = TRUE)) {
    stop("Package `sn` is required for skew_normal distributions.")
  }

  # Create sampler
  sampler <- function(n) {
    as.vector(sn::rsn(
      n = n,
      xi = spec$location,
      omega = spec$scale,
      alpha = spec$shape
    ))
  }

  return(sampler)
}
