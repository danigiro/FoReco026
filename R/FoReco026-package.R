#' FoReco: forecast reconciliation
#'
#' An R package offering classical (bottom-up and top-down), and modern (optimal and heuristic combination)
#' forecast reconciliation procedures for cross-sectional, temporal, and cross-temporal
#' linearly constrained time series.
#'
#' @author Tommaso Di Fonzo and Daniele Girolimetto, Department of Statistical Sciences, University of Padua (Italy).
#'
#' @details
#' The \code{FoReco} package is designed for forecast reconciliation, a
#' post-forecasting process aimed to improve the accuracy of the base
#' forecasts for a system of linearly constrained (e.g. hierarchical/grouped) time series.
#' The main functions are:
#'
#' \describe{
#'   \item{\code{\link[FoReco026]{htsrec}():}}{cross-sectional (contemporaneous) forecast reconciliation.}
#'   \item{\code{\link[FoReco026]{thfrec}():}}{forecast reconciliation for a single time series through temporal hierarchies.}
#'   \item{\code{\link[FoReco026]{lccrec}():}}{level conditional forecast reconciliation for genuine hierarchical/grouped time series.}
#'   \item{\code{\link[FoReco026]{tdrec}():}}{top-down (cross-sectional, temporal, cross-temporal) forecast reconciliation for genuine hierarchical/grouped time series.}
#'   \item{\code{\link[FoReco026]{ctbu}():}}{bottom-up cross-temporal forecast reconciliation.}
#'   \item{\code{\link[FoReco026]{tcsrec}():}}{heuristic first-temporal-then-cross-sectional cross-temporal forecast reconciliation.}
#'   \item{\code{\link[FoReco026]{cstrec}():}}{heuristic first-cross-sectional-then-temporal cross-temporal forecast reconciliation.}
#'   \item{\code{\link[FoReco026]{iterec}():}}{heuristic iterative cross-temporal forecast reconciliation.}
#'   \item{\code{\link[FoReco026]{octrec}():}}{optimal combination cross-temporal forecast reconciliation.}
#' }
#'
#' @references
#' Di Fonzo, T., and Girolimetto, D. (2023), Cross-temporal forecast reconciliation:
#' Optimal combination method and heuristic alternatives, \emph{International Journal
#' of Forecasting}, 39(1), 39-57 \doi{10.1016/j.ijforecast.2021.08.004}.
#'
#' Di Fonzo, T., Girolimetto, D. (2022), Forecast combination based forecast reconciliation:
#' insights and extensions, \emph{International Journal of Forecasting}, in press.
#'
#' Girolimetto, D., Athanasopoulos, G., Di Fonzo, T., and Hyndman, R. J. (2023),
#' Cross-temporal Probabilistic Forecast Reconciliation, \doi{10.48550/arXiv.2303.17277}.
#'
#' @import mathjaxr
#'
"_PACKAGE"

.onAttach <- function(...) {
  packageStartupMessage(cli::rule(
    right = paste0("FoReco ", utils::packageVersion("FoReco"))
  ))
}


