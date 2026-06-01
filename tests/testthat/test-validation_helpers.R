# ==============================================================================
# test-validation_helpers.R
# ==============================================================================

# ------------------------------------------------------------------------------
# Test cases: expected inputs
# ------------------------------------------------------------------------------

# Required parameter present does not throw error
expect_no_error(
  .require_param(
    spec = list(mean = 0),
    param = "mean",
    distribution = "normal"
  )
)

# Single numeric value does not throw error
expect_no_error(
  .check_single_numeric(
    x = 1,
    name = "test parameter"
  )
)

# ------------------------------------------------------------------------------
# Test cases: invalid inputs
# ------------------------------------------------------------------------------

# Missing required parameter throws error
expect_error(
  .require_param(
    spec = list(),
    param = "mean",
    distribution = "normal"
  ),
  "requires.*mean"
)

# Non-numeric value throws error
expect_error(
  .check_single_numeric(
    x = "1",
    name = "test parameter"
  ),
  "single numeric"
)

# Multiple numeric values throw error
expect_error(
  .check_single_numeric(
    x = c(1, 2),
    name = "test parameter"
  ),
  "single numeric"
)

# NA value throws error
expect_error(
  .check_single_numeric(
    x = NA_real_,
    name = "test parameter"
  ),
  "single numeric"
)
