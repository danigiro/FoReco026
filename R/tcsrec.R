#' @title Heuristic first-temporal-then-cross-sectional cross-temporal forecast reconciliation
#'
#' @description
#' \loadmathjax
#' The cross-temporal forecast reconciliation procedure by
#' Kourentzes and Athanasopoulos (2019) can be viewed as an ensemble
#' forecasting procedure which exploits the simple averaging of different
#' forecasts. First, for each time series the forecasts at any temporal
#' aggregation order are reconciled using temporal hierarchies
#' (\code{\link[FoReco026]{thfrec}()}), then time-by-time cross-sectional
#' reconciliation is performed (\code{\link[FoReco026]{htsrec}()}). The
#' projection matrices obtained at this step are then averaged and used to
#' cross-sectionally reconcile the forecasts obtained at step 1, by this way
#' fulfilling both cross-sectional and temporal constraints.
#'
#' @param basef  (\mjseqn{n \times h(k^\ast+m)}) matrix of base forecasts to be
#' reconciled, \mjseqn{\widehat{\mathbf{Y}}}; \mjseqn{n} is the total number of variables,
#' \mjseqn{m} is the highest time frequency, \mjseqn{k^\ast} is the sum of (a
#' subset of) (\mjseqn{p-1}) factors of \mjseqn{m}, excluding \mjseqn{m}, and
#' \mjseqn{h} is the forecast horizon for the lowest frequency time series.
#' Each row identifies a time series, and the forecasts are ordered as
#' [lowest_freq' ...  highest_freq']'.
#' @param hts_comb,thf_comb Type of covariance matrix (respectively
#' (\mjseqn{n \times n}) and (\mjseqn{(k^\ast + m) \times (k^\ast + m)})) to
#' be used in the cross-sectional and temporal reconciliation. More details in
#' \code{comb} param of \code{\link[FoReco026]{htsrec}()} and
#' \code{\link[FoReco026]{thfrec}()}.
#' @param res (\mjseqn{n \times N(k^\ast + m)}) matrix containing the residuals
#' at all the temporal frequencies ordered [lowest_freq' ...  highest_freq']'
#' (columns) for each variable (row), needed to estimate the covariance matrix
#' when \code{hts_comb =} \code{\{"wls",} \code{"shr",} \code{"sam"\}} and/or
#' \code{hts_comb =} \code{\{"wlsv",} \code{"wlsh",} \code{"acov",}
#' \code{"strar1",} \code{"sar1",} \code{"har1",} \code{"shr",} \code{"sam"\}}.
#' The row must be in the same order as \code{basef}.
#' @param avg If \code{avg = "KA"} (\emph{default}), the final projection
#' matrix \mjseqn{\mathbf{M}} is the one proposed by Kourentzes and
#' Athanasopoulos (2019), otherwise it is calculated as simple average of
#' all the involved projection matrices at step 2 of the procedure (see
#' Di Fonzo and Girolimetto, 2020).
#' @param ... Any other options useful for \code{\link[FoReco026]{htsrec}()} and
#' \code{\link[FoReco026]{thfrec}()}, e.g. \code{m}, \code{C} (or \code{Ut} and
#' \code{nb}), \code{nn} (for non negativity reconciliation only at first step),
#' \code{mse}, \code{corpcor}, \code{type}, \code{sol}, \code{settings},
#' \code{W}, \code{Omega},...
#'
#' @details
#' This function performs a two-step cross-temporal forecast reconciliation using
#' the covariance matrices chosen by the user. If the combinations used by Kourentzes and Athanasopoulos (2019) are
#' wished, \code{thf_comb} must be set equal to either \code{"struc"} or \code{"wlsv"},
#' and \code{hts_comb} equal to either \code{"shr"} or \code{"wls"}.
#'
#' \strong{Warning},
#' the two-step heuristic reconciliation allows considering non negativity constraints only in
#' the first step. This means that non-negativity is not guaranteed in the final reconciled values.
#'
#' @return
#' The function returns a list with two elements:
#' \item{\code{recf}}{(\mjseqn{n \times h(k^\ast + m)}) reconciled forecasts matrix, \mjseqn{\widetilde{\mathbf{Y}}}.}
#' \item{\code{M}}{Matrix which transforms the uni-dimensional reconciled forecasts of step 1 (projection approach) .}
#'
#' @references
#' Di Fonzo, T., and Girolimetto, D. (2023), Cross-temporal forecast reconciliation:
#' Optimal combination method and heuristic alternatives, \emph{International Journal
#' of Forecasting}, 39(1), 39-57.
#'
#' Kourentzes, N., Athanasopoulos, G. (2019), Cross-temporal coherent forecasts
#' for Australian tourism, \emph{Annals of Tourism Research}, 75, 393-409.
#'
#' \enc{Schäfer}{Schafer}, J.L., Opgen-Rhein, R., Zuber, V., Ahdesmaki, M.,
#' Duarte Silva, A.P., Strimmer, K. (2017), \emph{Package `corpcor'}, R
#' package version 1.6.9 (April 1, 2017), \href{https://CRAN.R-project.org/package=corpcor}{https://CRAN.R-project.org/package= corpcor}.
#'
#' \enc{Schäfer}{Schafer}, J.L., Strimmer, K. (2005), A Shrinkage Approach to Large-Scale Covariance
#' Matrix Estimation and Implications for Functional Genomics, \emph{Statistical
#' Applications in Genetics and Molecular Biology}, 4, 1.
#'
#' Stellato, B., Banjac, G., Goulart, P., Bemporad, A., Boyd, S. (2020). OSQP:
#' An Operator Splitting Solver for Quadratic Programs, \emph{Mathematical Programming Computation},
#' 12, 4, 637-672.
#'
#' Stellato, B., Banjac, G., Goulart, P., Boyd, S., Anderson, E. (2019), OSQP:
#' Quadratic Programming Solver using the `OSQP' Library, R package version 0.6.0.3
#' (October 10, 2019), \href{https://CRAN.R-project.org/package=osqp}{https://CRAN.R-project.org/package=osqp}.
#'
#' @keywords heuristic
#' @family reconciliation procedures
#'
#' @examples
#' data(FoReco_data)
#' obj <- tcsrec(FoReco_data$base, m = 12, C = FoReco_data$C,
#'               thf_comb = "acov", hts_comb = "shr", res = FoReco_data$res)
#'
#' @usage tcsrec(basef, thf_comb, hts_comb, res, avg = "KA", ...)
#'
#' @export
tcsrec <- function(basef, thf_comb, hts_comb, res, avg = "KA", ...) {

  arg_input <- list(...)

  if (missing(basef)) {
    stop("the argument basef is not specified", call. = FALSE)
  }

  if(all(names(arg_input)!="m")){
    stop("the argument m is not specified", call. = FALSE)
  }else{
    m <- arg_input$m
  }

  if (missing(thf_comb)) {
    stop("the argument thf_comb is not specified", call. = FALSE)
  }
  if (missing(hts_comb)) {
    stop("the argument hts_comb is not specified", call. = FALSE)
  }

  tools <- thf_tools(m)
  kset <- tools$kset
  m <- tools$m
  kt <- tools$kt

  arg_thf <- names(as.list(args(thfrec)))
  arg_thf <- arg_thf[!(arg_thf %in% c("basef", "keep", "res", "", "comb", "m", "bounds"))]

  ## Step 1: compute the temporally reconciled forecasts for each individual variable
  # (basef -> Y1)
  if (missing(res)) {
    Y1 <- t(apply(basef, 1, function(x) {
      obj <- do.call("thfrec", c(list(basef = x, m = kset, comb = thf_comb),
                                 arg_input[which(names(arg_input) %in% arg_thf)]))
      obj$recf
    }))
  } else {
    Y1 <- t(mapply(function(Y, X) {
      obj <- do.call("thfrec", c(list(basef = Y, m = kset, comb = thf_comb, res = X),
                                 arg_input[which(names(arg_input) %in% arg_thf)]))
      obj$recf
    },
    Y = split(basef, row(basef)), X = split(res, row(res))
    ))
  }

  ## Step 2: compute time by time cross sectional M matrix
  arg_hts <- names(as.list(args(htsrec)))
  arg_hts <- arg_hts[!(arg_hts %in% c("basef", "keep", "res", "", "comb", "nn", "bounds", "nn_type"))]

  # Create list with lenght p, with time by time temporally reconciled forecasts matrices
  h <- NCOL(Y1) / kt
  Y <- lapply(kset, function(x) Y1[, rep(kset, (m/kset) * h) == x, drop = FALSE])

  if (missing(res)) {
    M <- lapply(Y, function(x){
      obj <- do.call("htsrec", c(list(basef = t(x), comb = hts_comb),
                                 arg_input[which(names(arg_input) %in% arg_hts)]))
      return(obj[["M"]])
    })
  } else {
    # Create list with lenght p, with time by time temporally reconciled residuals matrices
    r <- NCOL(res) / kt
    E <- lapply(kset, function(x) res[, rep(kset, (m/kset) * r) == x, drop = FALSE])

    ## list of time by time cross sectional M matrix
    M <- mapply(function(Y, E){
      obj <- do.call("htsrec", c(list(basef = t(Y), comb = hts_comb, res = t(E)),
                                 arg_input[which(names(arg_input) %in% arg_hts)]))
      return(obj[["M"]])
    }, Y = Y, E = E, SIMPLIFY = FALSE
    )
  }

  if (avg == "KA") {
    #meanM <- apply(simplify2array(lapply(M, as.matrix)), c(1, 2), sum) / length(M)
    meanM <- Reduce("+", M)/length(M)
  } else {
    Mw <- mapply(function(a, A) a * A, A = M, a = split(kset, 1:length(kset)), SIMPLIFY = FALSE)
    #meanM <- apply(simplify2array(lapply(Mw, as.matrix)), c(1, 2), sum) / kt
    meanM <- Reduce("+", Mw)/kt
  }

  ## Step 3: Cross-Temporal reconciled forecasts with heuristic
  Y3 <- meanM %*% Y1

  rec_sol <- list()
  rec_sol$recf <- Y3
  rownames(rec_sol$recf) <- if (is.null(rownames(basef))) paste("serie", 1:NROW(rec_sol$recf), sep = "") else rownames(basef)
  colnames(rec_sol$recf) <- paste("k", rep(kset, h * (m/kset)), "h",
                                  do.call("c", as.list(sapply(
                                    (m/kset) * h,
                                    function(x) seq(1:x)
                                  ))),
                                  sep = ""
  )
  rec_sol$M <- meanM
  rec_sol$nn_check <- sum(rec_sol$recf < 0)
  return(rec_sol)
}
