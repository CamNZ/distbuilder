# ==============================================================================
# create-histogram.R
#
# Generate the README histogram from examples/params.yml.
# The first section mirrors the README exactly; the remainder reshapes, plots,
# and saves the histogram.
# ==============================================================================

library(distbuilder)
library(yaml)
library(tidyverse)

set.seed(1234)

# ------------------------------------------------------------------------------
# Code from README
# ------------------------------------------------------------------------------

# Load parameters from YAML
params <- read_yaml("examples/params.yml")

# Create sampler functions
samplers <- lapply(params, build_sampler)

# Simulate data
sim_data <- data.frame(lapply(samplers, function(sampler) sampler(1e4)))

# ------------------------------------------------------------------------------
# Create histogram
# ------------------------------------------------------------------------------

plt <- sim_data %>%
  pivot_longer(
    cols = everything(),
    names_to = "variable",
    values_to = "value"
  ) %>%
  mutate(
    variable = gsub("_", " ", variable),
    variable = stringr::str_to_title(variable)
  ) %>%
  ggplot(aes(x = value)) +
  geom_histogram(bins = 40, colour = "darkgrey", fill = "grey") +
  facet_wrap(~ variable, ncol = 1, scales = "free_x") +
  labs(x = "Value", y = "Count")

# ------------------------------------------------------------------------------
# Save histogram
# ------------------------------------------------------------------------------

ggsave(
  filename = "examples/histogram.png",
  plot = plt,
  width = 5,
  height = 6,
  dpi = 300
)
