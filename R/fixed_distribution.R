# ------------------------------------------------------------------------------
# fixed_distribution.R
#
# Simulates a fixed value by repeating the same value n times.
#
# Example YAML:
#
# Platform:
#   distribution: fixed
#   value: NovaSeq
# ------------------------------------------------------------------------------

.build_fixed_sampler <- function(spec) {
  # Input validation
  .require_param(spec, "value", "fixed")
  
  # Create sampler
  sampler <- function(n) {
    rep(spec$value, n)
  }
  
  return(sampler)
}