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
# Test cases: expected inputs
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

# ------------------------------------------------------------------------------
# Test cases: invalid inputs
# ------------------------------------------------------------------------------

# Missing levels throws error
expect_error(
  build_sampler(list(
    distribution = "categorical",
    probabilities = PROBS
  )),
  "levels"
)

# Missing probabilities throws error
expect_error(
  build_sampler(list(
    distribution = "categorical",
    levels = LEVELS
  )),
  "probabilities"
)

# Empty levels throws error
expect_error(
  build_sampler(list(
    distribution = "categorical",
    levels = character(0),
    probabilities = numeric(0)
  )),
  "at least one"
)

# Non-numeric probabilities throw error
expect_error(
  build_sampler(list(
    distribution = "categorical",
    levels = LEVELS,
    probabilities = c("high", "medium", "low")
  )),
  "probabilities.*numeric"
)

# Mismatched levels and probabilities throw error
expect_error(
  build_sampler(list(
    distribution = "categorical",
    levels = LEVELS,
    probabilities = c(0.5, 0.5)
  )),
  "same length"
)

# NA probabilities throw error
expect_error(
  build_sampler(list(
    distribution = "categorical",
    levels = LEVELS,
    probabilities = c(0.5, NA, 0.5)
  )),
  "NA"
)

# Negative probabilities throw error
expect_error(
  build_sampler(list(
    distribution = "categorical",
    levels = LEVELS,
    probabilities = c(0.6, -0.3, 0.7)
  )),
  "non-negative"
)

# Zero-sum probabilities throw error
expect_error(
  build_sampler(list(
    distribution = "categorical",
    levels = LEVELS,
    probabilities = c(0, 0, 0)
  )),
  "positive"
)
























