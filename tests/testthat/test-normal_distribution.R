# ==============================================================================
# test-normal_distribution.R
# ==============================================================================

# ------------------------------------------------------------------------------
# Setup
# ------------------------------------------------------------------------------

set.seed(1234)

# Params
N = 1e5
MEAN = 100
SD = 10

# Create sampler
spec = list(
  distribution = "normal",
  mean = MEAN,
  sd = SD
)

sampler <- build_sampler(spec)

# Generate data
x <- sampler(N)

# ------------------------------------------------------------------------------
# Test cases
# ------------------------------------------------------------------------------

# Sampler returns correct number of values
expect_equal(length(x), N, info = "Unexpected number of values in sample")

# Sample mean approximates theoretical mean
expect_equal(mean(x), MEAN, tolerance = 1, info = "Sample mean did not aproximate theoretical mean")

# Sample sd aproximates theoretical sd
expect_equal(sd(x), SD, tolerance = 0.1, info = "Sample sd did not aproximate theoretical sd")

# Sample mean and median are similar
expect_equal(mean(x), median(x), tolerance = 1, info = "Sample mean and median were not similar")


























