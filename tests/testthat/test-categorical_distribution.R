# ==============================================================================
# test-categorical_distribution.R
# ==============================================================================

# ------------------------------------------------------------------------------
# Setup
# ------------------------------------------------------------------------------

set.seed(1234)

# Params
N = 1e5
LEVELS = c("A", "B", "C")
PROBS = c(0.6, 0.3, 0.1)

# Create sampler
spec = list(
  distribution = "categorical",
  levels = LEVELS,
  probabilities = PROBS
)

sampler <- build_sampler(spec)

# Generate data
x <- sampler(N)

# ------------------------------------------------------------------------------
# Test cases
# ------------------------------------------------------------------------------

# Sampler returns correct number of values
expect_equal(length(x), N, info = "Unexpected number of values in sample")

# Sampler produces only expected levels
expect_true(setequal(unique(x), LEVELS))

# Sampler produces levels in expected weightings
observed_probs <- prop.table(table(factor(x, levels = LEVELS)))

expect_equal(
  as.numeric(observed_probs),
  PROBS,
  tolerance = 0.01,
  info = "Observed categorical proportions did not approximate expected probabilities"
)

























