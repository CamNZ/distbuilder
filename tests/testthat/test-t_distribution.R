# ==============================================================================
# test-t_distribution.R
# ==============================================================================

# ------------------------------------------------------------------------------
# Setup
# ------------------------------------------------------------------------------

set.seed(1234)

# Params
N = 1e5
LOCATION = 100
SCALE = 10
DF_HIGH = 1e3
DF_LOW = 2

# Create samplers
spec_high_df = list(
  distribution = "t",
  location = LOCATION,
  scale = SCALE,
  df = DF_HIGH
)

spec_low_df = list(
  distribution = "t",
  location = LOCATION,
  scale = SCALE,
  df = DF_LOW
)

sampler_high_df <- build_sampler(spec_high_df)
sampler_low_df <- build_sampler(spec_low_df)

# Generate data
x_high_df <- sampler_high_df(N)
x_low_df <- sampler_low_df(N)

# ------------------------------------------------------------------------------
# Test cases
# ------------------------------------------------------------------------------

# Sampler returns correct number of values
expect_equal(length(x_high_df), N, info = "Unexpected number of values in sample")
expect_equal(length(x_low_df), N, info = "Unexpected number of values in sample")

# High df: sample mean approximates location
expect_equal(mean(x_high_df), LOCATION, tolerance = 1, info = "High df sample mean did not approximate location")

# High df: sample sd approximates scale
expect_equal(sd(x_high_df), SCALE, tolerance = 0.2, info = "High df sample sd did not approximate scale")

# High df: sample mean and median are similar
expect_equal(mean(x_high_df), median(x_high_df), tolerance = 1, info = "High df sample mean and median were not similar")

# Low df: sample mean approximates location
expect_equal(mean(x_low_df), LOCATION, tolerance = 1, info = "Low df sample mean did not approximate location")

# Low df: sample mean and median are similar
expect_equal(mean(x_low_df), median(x_low_df), tolerance = 1, info = "Low df sample mean and median were not similar")

# Low df: sample sd is much larger than scale
expect_gt(sd(x_low_df), 2 * SCALE)
