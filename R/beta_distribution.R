# ------------------------------------------------------------------------------
# beta_distribution.R
#
# Simulates values from a beta distribution using rbeta().
#
# Example YAML:
#
# Methylation:
#   distribution: beta
#   shape1: 2
#   shape2: 5
# ------------------------------------------------------------------------------

.build_beta_sampler <- function(spec) {
  # Input validation
  .require_param(spec, "shape1", "beta")
  .require_param(spec, "shape2", "beta")
  
  .check_single_numeric(spec$shape1, "beta `shape1`")
  .check_single_numeric(spec$shape2, "beta `shape2`")
  
  if (spec$shape1 <= 0) {
    stop("beta `shape1` must be positive.")
  }
  
  if (spec$shape2 <= 0) {
    stop("beta `shape2` must be positive.")
  }
  
  # Create sampler
  sampler <- function(n) {
    rbeta(
      n = n,
      shape1 = spec$shape1,
      shape2 = spec$shape2
    )
  }
  
  return(sampler)
}