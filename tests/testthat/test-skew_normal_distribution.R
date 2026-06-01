# ==============================================================================
# test-skew_normal_distribution.R
# ==============================================================================

# ------------------------------------------------------------------------------
# Setup
# ------------------------------------------------------------------------------

set.seed(1234)

# Params
N = 1e5
LOCATION = 100
SCALE = 10
SHAPE = 10

# Create samplers
spec.right = list(
  distribution = "skew_normal",
  location = LOCATION,
  scale = SCALE,
  shape = SHAPE
)

spec.left = list(
  distribution = "skew_normal",
  location = LOCATION,
  scale = SCALE,
  shape = -SHAPE
)

sampler.right <- build_sampler(spec.right)
sampler.left <- build_sampler(spec.left)

# Generate data
x.right <- sampler.right(N)
x.left <- sampler.left(N)

# ------------------------------------------------------------------------------
# Test cases
# ------------------------------------------------------------------------------

# Samplers returns correct number of values
expect_equal(length(x.right), N, info = "Unexpected number of values in sample")
expect_equal(length(x.left), N, info = "Unexpected number of values in sample")

# Right skew - expect right tail heavier
q.right = quantile(x.right, c(0.05, 0.5, 0.95))
expect_gt(q.right[["95%"]] - q.right[["50%"]], q.right[["50%"]] - q.right[["5%"]])

# Left skew - expect left tail heavier
q.left = quantile(x.left, c(0.05, 0.5, 0.95))
expect_gt(q.left[["50%"]] - q.left[["5%"]], q.left[["95%"]] - q.left[["50%"]])







