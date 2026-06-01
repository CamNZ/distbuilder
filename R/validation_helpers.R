# ------------------------------------------------------------------------------
# Validation helpers.R
# ------------------------------------------------------------------------------

.require_param <- function(spec, param, distribution) {
  if (is.null(spec[[param]])) {
    stop(distribution, " distribution requires `", param, "`.")
  }
}

.check_single_numeric <- function(x, name) {
  if (!is.numeric(x) || length(x) != 1 || is.na(x)) {
    stop(name, " must be a single numeric value.")
  }
}