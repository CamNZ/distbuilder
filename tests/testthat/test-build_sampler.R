# ==============================================================================
# test-build_sampler.R
# ==============================================================================

# ------------------------------------------------------------------------------
# Setup
# ------------------------------------------------------------------------------

N <- 10

supported_specs <- list(
  normal = list(
    distribution = "normal",
    mean = 0,
    sd = 1
  ),
  fixed = list(
    distribution = "fixed",
    value = -7
  ),
  categorical = list(
    distribution = "categorical",
    levels = c("A", "B", "C"),
    probabilities = c(0.6, 0.3, 0.1)
  )
)

# ------------------------------------------------------------------------------
# Test cases
# ------------------------------------------------------------------------------

test_that("build_sampler returns callable samplers for selected supported distributions", {
  for (spec in supported_specs) {
    sampler <- build_sampler(spec)

    expect_type(sampler, "closure")

    x <- sampler(N)
    expect_equal(length(x), N)
  }
})

test_that("build_sampler errors when distribution is missing", {
  spec <- list(
    mean = 0,
    sd = 1
  )

  expect_error(
    build_sampler(spec),
    "spec must include `distribution`."
  )
})

test_that("build_sampler errors for unknown distributions", {
  spec <- list(
    distribution = "redblueyellow"
  )

  expect_error(
    build_sampler(spec),
    "Unknown distribution: redblueyellow"
  )
})

test_that("build_sampler passes through validation errors from component builders", {
  spec <- list(
    distribution = "normal",
    mean = 0
  )

  expect_error(
    build_sampler(spec)
  )
})
