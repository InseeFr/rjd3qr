#' @title Deprecated functions
#'
#' @description
#' Use [write()] instead of `export_xslx()`.
#'
#' @inheritParams write
#'
#' @returns \code{"QR_matrix"}, \code{"mQR_matrix"} or \code{"JVS_matrix"}
#' object invisibly.
#'
#' @examples
#' # Path leading to a demetra_m matrix
#' demetra_path <- file.path(
#'     system.file("extdata", package = "rjd3qr"),
#'     "WS/WS_world/Output/SAProcessing-1",
#'     "demetra_m.csv"
#' )
#'
#' # Extract the quality report from the demetra_m file
#' QR <- extract_QR(demetra_path)
#'
#' # Compute the scores
#' QR1 <- compute_score(x = QR, n_contrib_score = 5)
#' QR2 <- compute_score(
#'     x = QR,
#'     score_pond = c(qs_residual_s_on_sa = 5, qs_residual_sa_on_i = 30,
#'                    f_residual_td_on_sa = 10, f_residual_td_on_i = 40,
#'                    oos_mean = 30, residuals_skewness = 15, m7 = 25)
#' )
#' mQR <- mQR_matrix(list(a = QR1, b = QR2))
#'
#' # Export the Multiple Quality Report to an Excel file
#' # `export_xlsx` is deprecated.
#' # Use `write` instead:
#' write(x = QR, file = tempfile(fileext = ".xlsx"))
#' write(x = mQR, export_dir = tempdir())
#'
#' @name deprecated-rjd3qr
#' @export
export_xlsx <- function(x, ...) {
    .Deprecated("write")
    write(x, ...)
}
