# ------------------------------------------------------------------------------
# mixture_distribution.R
#
# Simulates values from a mixture of component distributions. Each component must
# define a valid distribution spec and a weight.
#
# Example YAML:
#
# Mass:
#   distribution: mixture
#   components:
#     - distribution: normal
#       mean: 100
#       sd: 15
#       weight: 0.2
#     - distribution: normal
#       mean: 200
#       sd: 15
#       weight: 0.8
# ------------------------------------------------------------------------------

.build_mixture_sampler <- function(spec) {
  # Input validation
  .require_param(spec, "components", "mixture")
  
  if (!is.list(spec$components)) {
    stop("mixture `components` must be a list.")
  }
  
  if (length(spec$components) < 2) {
    stop("mixture requires at least two components.")
  }
  
  weights <- sapply(
    spec$components,
    function(component) component$weight
  )
  
  if (!is.numeric(weights)) {
    stop("mixture component `weight` values must be numeric.")
  }
  
  if (any(is.na(weights))) {
    stop("mixture component `weight` values must not contain NA.")
  }
  
  if (any(weights < 0)) {
    stop("mixture component `weight` values must be non-negative.")
  }
  
  if (sum(weights) <= 0) {
    stop("mixture component `weight` values must sum to a positive value.")
  }
  
  component_specs <- lapply(
    spec$components,
    function(component) {
      component$weight <- NULL
      return(component)
    }
  )
  
  component_samplers <- lapply(
    component_specs,
    build_sampler
  )
  
  # Create sampler
  sampler <- function(n) {
    component_ids <- sample(
      x = seq_along(component_samplers),
      size = n,
      replace = TRUE,
      prob = weights
    )
    
    values <- vector(mode = "list", length = n)
    
    for (component_id in seq_along(component_samplers)) {
      idx <- which(component_ids == component_id)
      n_component <- length(idx)
      
      if (n_component > 0) {
        values[idx] <- as.list(component_samplers[[component_id]](n_component))
      }
    }
    
    values <- unlist(values)
    
    return(values)
  }
  
  return(sampler)
}
