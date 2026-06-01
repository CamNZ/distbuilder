# ==============================================================================
# test-fixed_distribution.R
# ==============================================================================

# ------------------------------------------------------------------------------
# Setup
# ------------------------------------------------------------------------------

set.seed(1234)

# Params
N = 1e5
VALUE = 0.15

# Create sampler
spec = list(
  distribution = "fixed",
  value = VALUE
)

sampler <- build_sampler(spec)

# Generate data
x <- sampler(N)

# ------------------------------------------------------------------------------
# Test cases
# ------------------------------------------------------------------------------

# Sampler returns correct number of values
expect_equal(length(x), N, info = "Unexpected number of values in sample")

# Sampler returns only the fixed value
expect_true(all(x == VALUE))
