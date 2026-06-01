# ==============================================================================
# test-mixed_distribution.R
# ==============================================================================

set.seed(1234)
N = 1e5

# ------------------------------------------------------------------------------
# SCENARIO 1: Simple bimodal
#   - Component distributions normal
#   - Negligible overlap
#   - Imbalanced weightings
# ------------------------------------------------------------------------------

# Define distribution
spec = list(
  distribution = "mixture",
  components = list(
    list(
    distribution = "normal",
    mean = 10,
    sd = 1,
    weight = 0.7
    ),
  list(
    distribution = "normal",
    mean = 20,
    sd = 1,
    weight = 0.3
    )
  )
)

# Generate data
sampler <- build_sampler(spec)
x <- sampler(N)

# Sampler returns correct number of values
expect_equal(length(x), N, info = "Unexpected number of values in sample")

# Weights implemented correctly
expect_equal(sum(x > 15) / length(x), 0.3, tolerance = 5e-2)
expect_equal(sum(x < 15) / length(x), 0.7, tolerance = 5e-2)
expect_equal(mean(x), (10 * 0.7) + (20 * 0.3), tolerance = 5e-2)

# For mixture, mean != median
expect_true(abs(mean(x) - median(x)) > 2)

# Each component distribution mean approximates median
expect_equal(mean(x[x < 15]), median(x[x < 15]), tolerance = 5e-2)
expect_equal(mean(x[x > 15]), median(x[x > 15]), tolerance = 5e-2)

# ------------------------------------------------------------------------------
# SCENARIO 2: Complex mixture
#   - 4 component distributions of different types
#   - Primarily a smoke test
#   - Approximately symmetrical, with modes at approximately -50, 0 and 50
# ------------------------------------------------------------------------------

# Define distribution
spec = list(
  distribution = "mixture",
  components = list(
    list(
      distribution = "normal",
      mean = -50,
      sd = 10,
      weight = 0.35
    ),
    list(
      distribution = "skew_normal",
      location = 50,
      scale = 10,
      shape = -5,
      weight = 0.35
    ),
    list(
      distribution = "uniform",
      min = -100,
      max = 100,
      weight = 0.2
    ),
    list(
      distribution = "fixed",
      value = 0,
      weight = 0.1
    )
  )
)

# Generate data
sampler <- build_sampler(spec)
x <- sampler(N)

# Sampler returns correct number of values
expect_equal(length(x), N, info = "Unexpected number of values in sample")

# Test median approximates 0
expect_equal(median(x), 0, tolerance = 10)

# Test all values within expected range
expect_gte(min(x), -150)
expect_lte(max(x), 150)

# Test quartiles loosely approximate expected values
expect_equal(unname(quantile(x, 0.25)), -50, tolerance = 20)
expect_equal(unname(quantile(x, 0.75)), 50, tolerance = 20)


























