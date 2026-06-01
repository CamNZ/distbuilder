# ==============================================================================
# test-uniform_distribution.R
# ==============================================================================

# ------------------------------------------------------------------------------
# Setup
# ------------------------------------------------------------------------------

set.seed(1234)

# Params
N = 1e5
MIN = 100
MAX = 200

# Create sampler
spec = list(
  distribution = "uniform",
  min = MIN,
  max = MAX
)

sampler <- build_sampler(spec)

# Generate data
x <- sampler(N)

# ------------------------------------------------------------------------------
# Test cases
# ------------------------------------------------------------------------------

# Sampler returns correct number of values
expect_equal(length(x), N, info = "Unexpected number of values in sample")

# All values within expected range
expect_gte(min(x), MIN)
expect_lte(max(x), MAX)

# Spacing between deciles is similar
q <- quantile(x, seq(from = 0, to = 1, by = 0.1))
decile_spacing <- diff(q)
expect_equal(min(decile_spacing), max(decile_spacing), tolerance = 0.5)






















