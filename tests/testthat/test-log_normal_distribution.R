# ==============================================================================
# test-log_normal_distribution.R
# ==============================================================================

# ------------------------------------------------------------------------------
# Setup
# ------------------------------------------------------------------------------

set.seed(1234)

# Params
N = 1e5
MEAN_LOG = 2
SD_LOG = 0.3

# Create sampler
spec = list(
  distribution = "log_normal",
  meanlog = MEAN_LOG,
  sdlog = SD_LOG
)

sampler <- build_sampler(spec)

# Generate data
x <- sampler(N)

# ------------------------------------------------------------------------------
# Test cases
# ------------------------------------------------------------------------------

# Sampler returns correct number of values
expect_equal(length(x), N, info = "Unexpected number of values in sample")

# All values are positive
expect_gt(min(x), 0)

# Distribution is right skewed
q <- quantile(x, c(0.05, 0.5, 0.95))
expect_gt(q[["95%"]] - q[["50%"]], q[["50%"]] - q[["5%"]])

# log transformed sample - mean and median similar
expect_equal(mean(log(x)), median(log(x)), tolerance = 0.01)

# log transformed sample - mean approximates param
expect_equal(mean(log(x)), MEAN_LOG, tolerance = 0.01)

# log transformed sample - sd approximates param
expect_equal(sd(log(x)), SD_LOG, tolerance = 0.01)






















