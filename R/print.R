#' @title Affichage des objets QR_matrix et mQR_matrix
#'
#' @description
#' Pour afficher un objet QR_matrix ou mQR_matrix.
#'
#' @param x objet de type \code{\link{mQR_matrix}} ou \code{\link{mQR_matrix}}.
#' @param print_variables booléen pour imprimer ou non les noms des indicateurs
#' (supplémentaire inclus).
#' @param print_score_formula booléen pour imprimer ou non la formule qui a
#' servi à calculer le score (le cas échéant).
#' @param score_statistics booléen pour imprimer ou non des statistiques sur les
#' scores de la \code{\link{mQR_matrix}} (le cas échéant).
#' @param ... autres arguments non utilisés.
#' @returns la méthode \code{print} imprime un objet \code{\link{mQR_matrix}} ou
#' \code{\link{mQR_matrix}} et le renvoie de manière invisible (via
#' \code{invisible(x)}).
#' @encoding UTF-8
#' @keywords internal
#' @name fr-print.QR_matrix
NULL
#> NULL

#' @title Printing QR_matrix and mQR_matrix objects
#'
#' @description
#' To print information on a QR_matrix or mQR_matrix object.
#'
#' @param x a \code{\link{mQR_matrix}} or \code{\link{mQR_matrix}} object.
#' @param print_variables logical indicating whether to print the indicators'
#' name (including additionnal variables).
#' @param print_score_formula logical indicating whether to print the formula
#' with which the score was calculated (when calculated).
#' @param score_statistics logical indicating whether to print the statistics
#' in the \code{\link{mQR_matrix}} scores (when calculated).
#' @param ... other unused arguments.
#'
#' @returns the \code{print} method prints a \code{\link{mQR_matrix}} or
#' \code{\link{mQR_matrix}} object and returns it invisibly (via
#' \code{invisible(x)}).
#'
#' @examples
#' # Path of matrix demetra_m
#' demetra_path <- file.path(
#'     system.file("extdata", package = "rjd3qr"),
#'     "WS/WS_world/Output/SAProcessing-1",
#'     "demetra_m.csv"
#' )
#'
#' # Extract the quality report from the demetra_m file
#' QR <- extract_QR(file = demetra_path)
#'
#' print(QR)
#'
#'
#' # Prepare 2 quality reports
#' QR1 <- compute_score(x = QR, n_contrib_score = 5)
#' QR2 <- compute_score(
#'     x = QR,
#'     score_pond = c(qs_residual_s_on_sa = 5, qs_residual_sa_on_i = 30,
#'                    f_residual_td_on_sa = 10, f_residual_td_on_i = 40,
#'                    oos_mean = 30, residuals_skewness = 15, m7 = 25)
#' )
#' mQR <- mQR_matrix(list(a = QR1, b = QR2))
#'
#' print(mQR)
#'
#' @importFrom stats sd
#'
#' @encoding UTF-8
#' @family QR_matrix functions
#' @exportS3Method print QR_matrix
#' @method print QR_matrix
#' @name print.QR_matrix
#' @seealso [Traduction française][fr-print.QR_matrix()]
#' @export
print.QR_matrix <- function(
    x,
    print_variables = TRUE,
    print_score_formula = TRUE,
    ...
) {
    nb_var <- nrow(x[["modalities"]])
    nb_var_modalities <- ncol(x[["modalities"]])
    nb_var_values <- ncol(x[["values"]])

    if (
        is.null(nb_var) ||
            is.null(nb_var_modalities) ||
            is.null(nb_var_values) ||
            nb_var * nb_var_modalities * nb_var_values == 0L
    ) {
        cat("The quality report matrix is empty")
        return(invisible(x))
    }
    cat(sprintf(
        ngettext(
            nb_var,
            "The quality report matrix has %d observations",
            "The quality report matrix has %d observations"
        ),
        nb_var
    ))
    cat("\n")
    cat(sprintf(
        ngettext(
            nb_var_modalities,
            "There are %d indicators in the modalities matrix",
            "There are %d indicators in the modalities matrix"
        ),
        nb_var_modalities
    ))
    cat(sprintf(
        ngettext(
            nb_var_values,
            " and %d indicators in the values matrix",
            " and %d indicators in the values matrix"
        ),
        nb_var_values
    ))
    cat("\n")
    if (print_variables) {
        cat("\n")
        names_var_modalities <- colnames(x[["modalities"]])
        names_var_values <- colnames(x[["values"]])
        names_var_values_sup <- names_var_values[
            !names_var_values %in% names_var_modalities
        ]
        names_var_modalities <- paste(names_var_values, collapse = "  ")
        names_var_values_sup <- paste(names_var_values_sup, collapse = "  ")

        cat(sprintf(
            "The quality report matrix contains the following variables:\n%s\n",
            names_var_modalities
        ))
        cat("\n")
        if (any(nzchar(names_var_values_sup))) {
            cat(sprintf(
                "The variables exclusively found in the values matrix are:\n%s",
                names_var_values_sup
            ))
        } else {
            cat("There's no additionnal variable in the values matrix")
        }
        cat("\n")
        if (length(names_var_values_sup) > 1L) {
            pat <- ngettext(
                length(names_var_values_sup),
                "There's no additionnal variable in the values matrix",
                "The variables exclusively found in the values matrix are:\n%s"
            )
            cat(sprintf(
                pat,
                names_var_values_sup
            ))
        }

        cat("\n")
    }

    score_value <- extract_score(x, format_output = "vector")
    if (is.null(score_value)) {
        cat("No score was calculated")
        return(invisible(x))
    }
    cat(sprintf(
        "The smallest score is %1g and the greatest is %2g\n",
        min(score_value, na.rm = TRUE),
        max(score_value, na.rm = TRUE)
    ))
    cat(sprintf(
        "The average score is %1g and its standard deviation is %2g",
        mean(score_value, na.rm = TRUE),
        stats::sd(score_value, na.rm = TRUE)
    ))
    if (print_score_formula && !is.null(x[["score_formula"]])) {
        cat("\n\n")
        cat(sprintf(
            "The following formula was used to calculate the score:\n%s",
            as.character(x[["score_formula"]])
        ))
    }
    return(invisible(x))
}

#' @exportS3Method print mQR_matrix
#' @method print mQR_matrix
#' @rdname print.QR_matrix
#' @export
print.mQR_matrix <- function(x, score_statistics = TRUE, ...) {
    if (length(x) == 0L) {
        cat("List without a quality report")
        return(invisible(x))
    }
    cat(sprintf(
        ngettext(
            length(x),
            "The object contains %d quality report(s)",
            "The object contains %d quality report(s)"
        ),
        length(x)
    ))
    cat("\n")
    bq_names <- names(x)
    bq_names[is.na(bq_names)] <- ""
    if (is.null(bq_names) || all(is.na(bq_names))) {
        cat("No quality report is named")
        return(invisible(x))
    }
    bq_names_na <- sum(is.na(bq_names))
    bq_valid_names <- bq_names[!is.na(bq_names)]
    cat(sprintf(
        ngettext(
            length(bq_valid_names),
            "%d quality report is named: %s",
            "%d quality reports are named: %s"
        ),
        length(bq_valid_names),
        paste(bq_valid_names, collapse = "  ")
    ))

    if (length(bq_names_na) > 1L) {
        cat("\n")
        cat(sprintf(
            ngettext(
                bq_names_na,
                "%d quality report isn't named",
                "%d quality reports aren't named"
            ),
            bq_names_na
        ))
    }
    if (score_statistics) {
        cat("\n")
        score_values <- extract_score(x, format_output = "vector")
        all_score <- do.call(c, score_values)
        if (is.null(all_score)) {
            cat("No quality report has a calculated score")
            return(invisible(x))
        }
        cat(sprintf(
            "The average score over all quality reports is %g\n",
            mean(all_score, na.rm = TRUE)
        ))
        cat(sprintf(
            "The smallest score is %1g and the greatest is %2g\n",
            min(all_score, na.rm = TRUE),
            max(all_score, na.rm = TRUE)
        ))

        for (i in seq_along(score_values)) {
            cat("\n\n")
            score_value <- score_values[[i]]

            bq_name <- bq_names[i]
            if (is.null(bq_name) || is.na(bq_name)) {
                bq_name <- ""
            } else {
                bq_name <- paste0(" (", bq_name, ")")
            }

            if (is.null(score_value)) {
                cat(
                    "There is no calculated score for the quality report n.",
                    i,
                    bq_name
                )
            } else {
                cat(sprintf(
                    "The quality report n.%d%s has an average score of %g\n",
                    i,
                    bq_name,
                    mean(score_value, na.rm = TRUE)
                ))
                cat(sprintf(
                    "The smallest score is %1g and the greatest is %2g\n",
                    min(score_value, na.rm = TRUE),
                    max(score_value, na.rm = TRUE)
                ))
            }
        }
    }

    return(invisible(x))
}
