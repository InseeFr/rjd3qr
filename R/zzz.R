#' @keywords internal
.onLoad <- function(libname, pkgname) {
    if (is.null(getOption("rjd3qr.thresholds"))) {
        set_thresholds()
    }
}
