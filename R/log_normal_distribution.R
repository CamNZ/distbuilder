# ------------------------------------------------------------------------------
# log_normal_distribution.R
#
# Simulates values from a log-normal distribution using rlnorm().
#
# Example YAML:
#
# Biomarker:
#   distribution: log_normal
#   meanlog: 2
#   sdlog: 0.3
# ------------------------------------------------------------------------------

.build_log_normal_sampler <- function(spec) {
  # Input validation
  .require_param(spec, "meanlog", "log_normal")
  .require_param(spec, "sdlog", "log_normal")

  .check_single_numeric(spec$meanlog, "log_normal `meanlog`")
  .check_single_numeric(spec$sdlog, "log_normal `sdlog`")

  if (spec$sdlog < 0) {
    stop("log_normal `sdlog` must be non-negative.")
  }

  # Create sampler
  sampler <- function(n) {
    stats::rlnorm(
      n = n,
      meanlog = spec$meanlog,
      sdlog = spec$sdlog
    )
  }

  return(sampler)
}
