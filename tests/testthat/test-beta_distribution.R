# ==============================================================================
# test-beta_distribution.R
# ==============================================================================

# ------------------------------------------------------------------------------
# Setup
# ------------------------------------------------------------------------------

set.seed(1234)

# Params
N <- 1e5

params <- list(
  symmetric   = list(shape1 = 5, shape2 = 5),
  right_skew  = list(shape1 = 1, shape2 = 5),
  left_skew   = list(shape1 = 5, shape2 = 1)
)

# Create samplers
samplers <- lapply(params, function(p) {
  build_sampler(list(
    distribution = "beta",
    shape1 = p$shape1,
    shape2 = p$shape2
  ))
})

# Generate data
x <- lapply(samplers, function(sampler) sampler(N))

# ------------------------------------------------------------------------------
# Test cases
# ------------------------------------------------------------------------------

# Sampler returns correct number of values
expect_equal(length(x$symmetric), N, info = "Unexpected number of values in sample")

# All values between 0 and 1
expect_gte(min(x$symmetric), 0)
expect_lte(max(x$symmetric), 1)

# Symmetric - median approximates 0.5
expect_equal(median(x$symmetric), 0.5, tolerance = 1e-2)

# Left skew - median > 0.5
expect_gt(median(x$left), 0.5)

# Right skew - median < 0.5
expect_lt(median(x$right), 0.5)












































