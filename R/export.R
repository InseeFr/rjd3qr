#' @title Ecriture de bilans qualités dans des fichiers
#'
#' @param x Objet de classe \code{\link{JVS_matrix}}, \code{\link{QR_matrix}} ou
#'   \code{\link{mQR_matrix}} à exporter
#' @param file un objet de type \code{character} contenant le chemin menant au
#'   fichier que l'on veut créer
#' @param export_dir Chemin vers le dossier qui contiendra les exports.
#' @param auto_format booléen indiquant s'il faut formatter la sortie
#' (\code{auto_format = TRUE} par défaut).
#' @param layout_file paramètre d'export. Par défaut,
#' (\code{layout_file = "ByComponent"}) et un fichier Excel est exporté par
#' composante de la matrice bilan qualité (matrice des modalités ou des
#' valeurs), dont chaque feuille correspond à un bilan qualité. Pour avoir un
#' fichier par bilan qualité dont chaque feuille correspond à la composante
#' exportée, utiliser \code{layout_file = "ByQRMatrix"}.
#' La modalité \code{layout_file = "AllTogether"} correspond à la création d'un
#' fichier avec 2 feuilles par bilan qualité (\code{Values} et
#' \code{Modalities}).
#' @param overwrite Booléen. Est ce qu'un fichier existant doit être ré-écrit ?
#'   Par défaut, `overwrite = TRUE`.
#' @param verbose Booleen. Est ce que des informations supplémentaires doivent
#'   être affichées ? Valeur par défaut, `TRUE`.
#' @param ... Autre argument non utilisé.
#'
#' @returns
#' Si \code{x} est de classe \code{\link{JVS_matrix}} ou
#' \code{\link{mQR_matrix}}, la fonction retourne de manière invisible (avec
#' `invisible()`) l'objet x.
#' Si \code{x} est de classe \code{\link{QR_matrix}}, la fonction retourne de
#' manière invisible (avec `invisible()`) l'objet un classeur créé par
#' \code{openxlsx::loadWorkbook()} pour une manipulation ultérieure.
#'
#' @details
#' Les objets de classe \code{\link{JVS_matrix}} peuvent être exportés dans des
#' fichiers csv ou Excel (selon l'argument `format`).
#' Les objets de classe \code{\link{QR_matrix}} et \code{\link{mQR_matrix}} ne
#' sont écrits que dans des fichiers Excel.
#'
#' @examples
#' # Chemin menant au répertoire contenant le fichier demetra_m et les séries
#' dir_path <- system.file(
#'     "extdata", "WS", "WS_world", "Output", "SAProcessing-1",
#'     package = "rjd3qr"
#' )
#'
#' # Chemin menant au fichier demetra_m.csv
#' demetra_path <- file.path(dir_path, "demetra_m.csv")
#'
#' # Extraire le bilan qualité à partir du fichier demetra_m.csv
#' QR <- extract_QR(demetra_path)
#'
#' # Export du QR dans un fichier Excel
#' write(x = QR, file = tempfile(fileext = ".xlsx"))
#'
#' # Préparation de 2 bilans qualités
#' QR1 <- compute_score(x = QR, n_contrib_score = 5)
#' QR2 <- compute_score(
#'     x = QR,
#'     score_pond = c(qs_residual_s_on_sa = 5, qs_residual_sa_on_i = 30,
#'                    f_residual_td_on_sa = 10, f_residual_td_on_i = 40,
#'                    oos_mean = 30, residuals_skewness = 15, m7 = 25)
#' )
#' mQR <- mQR_matrix(list(a = QR1, b = QR2))
#'
#' # Export du mQR dans un fichier Excel
#' write(x = mQR, export_dir = tempdir())
#'
#' # Extraire le rapport JVS à partir des fichiers CSV
#' JVS <- extract_JVS(dir = dir_path)
#'
#' # Export du rapport JVS dans un fichier Excel
#' write(JVS, format = "xlsx", export_dir = tempdir(), overwrite = TRUE)
#'
#' # Export du rapport JVS dans un fichier CSV
#' write(JVS, format = "csv", export_dir = tempdir(), overwrite = TRUE)
#'
#' @keywords internal
#' @name fr-write
NULL
#> NULL

#' @title Writing Quality Reports to Files
#'
#' @param x An object of class \code{\link{JVS_matrix}},
#'   \code{\link{QR_matrix}}, or \code{\link{mQR_matrix}} to export.
#' @param file A \code{character} object containing the path to the file to be
#'   created.
#' @param export_dir Path to the directory that will contain the exported files.
#' @param auto_format Boolean indicating whether to format the output
#'   (\code{auto_format = TRUE} by default).
#' @param layout_file Export parameter. By default,
#'   (\code{layout_file = "ByComponent"}) and an Excel file is exported for
#'   each component of the quality report matrix (modalities or values matrix),
#'   where each sheet corresponds to a quality report. To have one file per
#'   quality report, with each sheet corresponding to the exported component,
#'   use \code{layout_file = "ByQRMatrix"}. The modality
#'   \code{layout_file = "AllTogether"} corresponds to creating a file with 2
#'   sheets per quality report (\code{Values} and \code{Modalities}).
#' @param overwrite Boolean. Should an existing file be overwritten?
#'   By default, \code{overwrite = TRUE}.
#' @param verbose Boolean indicating whether to print additional information.
#'   Default is `TRUE`.
#' @param ... Other unused arguments.
#'
#' @returns
#' If \code{x} is of class \code{\link{JVS_matrix}} or
#' \code{\link{mQR_matrix}}, the function invisibly returns (with
#' `invisible()`) the object \code{x}.
#' If \code{x} is of class \code{\link{QR_matrix}}, the function invisibly
#' returns (with `invisible()`) a workbook object created by
#' \code{openxlsx::loadWorkbook()} for further manipulation.
#'
#' @details
#' Objects of class \code{\link{JVS_matrix}} can be exported to
#' CSV or Excel files (depending on the `format` argument).
#' Objects of class \code{\link{QR_matrix}} and \code{\link{mQR_matrix}} are
#' only written to Excel files.
#'
#' @examples
#' # Path to the directory containing the demetra_m file and series
#' dir_path <- system.file(
#'     "extdata", "WS", "WS_world", "Output", "SAProcessing-1",
#'     package = "rjd3qr"
#' )
#'
#' # Path to the demetra_m.csv file
#' demetra_path <- file.path(dir_path, "demetra_m.csv")
#'
#' # Extract the quality report from the demetra_m.csv file
#' QR <- extract_QR(demetra_path)
#'
#' # Export the QR to an Excel file
#' write(x = QR, file = tempfile(fileext = ".xlsx"))
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
#' # Export the mQR to an Excel file
#' write(x = mQR, export_dir = tempdir())
#'
#' # Extract the JVS report from CSV files
#' JVS <- extract_JVS(dir = dir_path)
#'
#' # Export the JVS report to an Excel file
#' write(JVS, format = "xlsx", export_dir = tempdir(), overwrite = TRUE)
#'
#' # Export the JVS report to a CSV file
#' write(JVS, format = "csv", export_dir = tempdir(), overwrite = TRUE)
#'
#' @name write
#' @seealso [Traduction française][fr-write()]
#' @export
write <- function(x, ...) {
    UseMethod("write", x)
}

#' @exportS3Method write default
#' @method write default
#' @export
write.default <- function(x, ...) {
    stop(
        "A JVS_matrix, QR_matrix or mQR_matrix object is required!",
        call. = FALSE
    )
}

#' @importFrom openxlsx addWorksheet
#' @importFrom openxlsx createWorkbook
#' @importFrom openxlsx saveWorkbook
#' @importFrom openxlsx writeData
#' @importFrom tools file_ext
#'
#' @rdname write
#' @exportS3Method write QR_matrix
#' @method write QR_matrix
#' @export
write.QR_matrix <- function(
    x,
    file,
    auto_format = TRUE,
    overwrite = TRUE,
    ...
) {
    ext <- tools::file_ext(file)
    if (!nzchar(ext)) {
        file <- paste0(file, ".xslx")
    } else if (ext != "xlsx") {
        stop("The format of the file must be .xlsx .", call. = FALSE)
    }

    wb_qr <- openxlsx::createWorkbook(
        title = "QR for WS",
        subject = "Seasonal Adjustment"
    )

    openxlsx::addWorksheet(wb = wb_qr, sheetName = "Modalities")
    openxlsx::addWorksheet(wb = wb_qr, sheetName = "Values")

    openxlsx::writeData(
        wb = wb_qr,
        sheet = "Modalities",
        x = x[["modalities"]],
        headerStyle = if (auto_format) header_style else NULL
    )
    openxlsx::writeData(
        wb = wb_qr,
        sheet = "Values",
        x = x[["values"]],
        headerStyle = if (auto_format) header_style else NULL
    )

    if (auto_format) {
        wb_qr <- apply_BQ_style(
            wb = wb_qr,
            x = x,
            values_sheet = "Values",
            modalities_sheet = "Modalities"
        )
    }

    openxlsx::saveWorkbook(wb = wb_qr, file = file, overwrite = overwrite)

    return(invisible(wb_qr))
}

#' @importFrom utils write.table
#' @importFrom openxlsx addWorksheet
#' @importFrom openxlsx createWorkbook
#' @importFrom openxlsx saveWorkbook
#' @importFrom openxlsx writeData
#'
#' @rdname write
#' @exportS3Method write JVS_matrix
#' @method write JVS_matrix
#' @export
write.JVS_matrix <- function(
    x,
    file = file.path(tempdir(), "JobVacancySurveyQR.csv"),
    overwrite = TRUE,
    verbose = TRUE,
    ...
) {
    if (dir.exists(file)) {
        file <- file.path(file, "JobVacancySurveyQR.csv")
    } else if (!dir.exists(dirname(path = file))) {
        dir.create(dirname(path = file), recursive = TRUE)
    }

    extension <- tools::file_ext(file)
    if (!nzchar(extension)) {
        file <- paste0(file, ".csv")
        extension <- "csv"
    } else if (!extension %in% c("csv", "xlsx")) {
        stop(
            extension,
            " is not accepted. ",
            "Only .csv and .xlsx format are accepted.",
            call. = FALSE
        )
    }

    if (file.exists(file) && !overwrite) {
        if (verbose) {
            warning(
                "The file already exists. ",
                "To overwrite it, use the argument `overwrite = TRUE`.",
                call. = FALSE
            )
        }
        return(invisible(x))
    }

    if (verbose) {
        message("The JVS report will be exported to ", file, ".")
        if (file.exists(file)) {
            message("The file already exists and will be overwritten.")
        }
    }

    if (extension == "csv") {
        utils::write.table(
            x = x,
            file = file,
            sep = ";",
            dec = ",",
            quote = FALSE,
            row.names = FALSE,
            col.names = TRUE,
            fileEncoding = "utf-8",
            na = ""
        )
    } else if (extension == "xlsx") {
        wb_jvs <- openxlsx::createWorkbook(title = "JVSQR")
        openxlsx::addWorksheet(wb = wb_jvs, sheetName = "JVS")
        openxlsx::writeData(
            wb = wb_jvs,
            sheet = "JVS",
            x = x,
            headerStyle = header_style
        )

        openxlsx::saveWorkbook(
            wb = wb_jvs,
            file = file,
            overwrite = overwrite
        )
    } else {
        stop("Wrong extension.", call. = FALSE)
    }
    return(invisible(x))
}

#' @importFrom openxlsx addWorksheet
#' @importFrom openxlsx createWorkbook
#' @importFrom openxlsx saveWorkbook
#' @importFrom openxlsx writeData
#'
#' @rdname write
#' @exportS3Method write mQR_matrix
#' @method write mQR_matrix
#' @export
write.mQR_matrix <- function(
    x,
    export_dir,
    layout_file = c("ByComponent", "ByQRMatrix", "AllTogether"),
    auto_format = TRUE,
    overwrite = TRUE,
    ...
) {
    #by component = 1file / component (different QR in same file) = 2 files
    #by QRMatrix = 1file / QR (different component in same file)
    #All together = All Qr and components in same file

    layout_file <- match.arg(layout_file)
    export_dir <- normalizePath(export_dir)

    if (layout_file == "ByQRMatrix") {
        for (id_qr in seq_along(x)) {
            qr_matrix <- x[[id_qr]]
            name <- ifelse(
                test = is.null(names(x)) || !nzchar(names(x)[id_qr]),
                yes = paste0("QR_", id_qr),
                no = names(x)[id_qr]
            )
            write(
                x = qr_matrix,
                file = file.path(export_dir, paste0(name, ".xlsx")),
                auto_format = auto_format,
                overwrite = overwrite
            )
        }
    } else if (layout_file == "ByComponent") {
        wb_modalities <- openxlsx::createWorkbook(
            title = "Modalities of the QR",
            subject = "Seasonal Adjustment"
        )
        wb_values <- openxlsx::createWorkbook(
            title = "Values of the QR",
            subject = "Seasonal Adjustment"
        )

        for (id_qr in seq_along(x)) {
            qr_matrix <- x[[id_qr]]
            name <- ifelse(
                test = is.null(names(x)) || !nzchar(names(x)[id_qr]),
                yes = paste0("QR_", id_qr),
                no = names(x)[id_qr]
            )

            openxlsx::addWorksheet(wb = wb_modalities, sheetName = name)
            openxlsx::addWorksheet(wb = wb_values, sheetName = name)

            openxlsx::writeData(
                wb = wb_modalities,
                sheet = name,
                x = qr_matrix[["modalities"]],
                headerStyle = if (auto_format) header_style else NULL
            )
            openxlsx::writeData(
                wb = wb_values,
                sheet = name,
                x = qr_matrix[["values"]],
                headerStyle = if (auto_format) header_style else NULL
            )
            if (auto_format) {
                wb_modalities <- apply_BQ_style(
                    wb = wb_modalities,
                    x = qr_matrix,
                    modalities_sheet = name
                )
                wb_values <- apply_BQ_style(
                    wb = wb_values,
                    x = qr_matrix,
                    values_sheet = name
                )
            }
        }

        file_modalities <- file.path(export_dir, "modalities.xlsx")
        file_values <- file.path(export_dir, "values.xlsx")

        openxlsx::saveWorkbook(
            wb = wb_modalities,
            file = file_modalities,
            overwrite = overwrite
        )
        openxlsx::saveWorkbook(
            wb = wb_values,
            file = file_values,
            overwrite = overwrite
        )
    } else if (layout_file == "AllTogether") {
        wb_mqr <- openxlsx::createWorkbook(
            title = "Multiple QR",
            subject = "Seasonal Adjustment"
        )

        for (id_qr in seq_along(x)) {
            qr_matrix <- x[[id_qr]]
            name <- ifelse(
                test = is.null(names(x)) ||
                    !nzchar(names(x)[id_qr]) ||
                    sum(names(x) == names(x)[id_qr]) > 1L,
                yes = paste0("QR_", id_qr),
                no = names(x)[id_qr]
            )

            openxlsx::addWorksheet(
                wb = wb_mqr,
                sheetName = paste0(name, "_modalities")
            )
            openxlsx::addWorksheet(
                wb = wb_mqr,
                sheetName = paste0(name, "_values")
            )

            openxlsx::writeData(
                wb = wb_mqr,
                sheet = paste0(name, "_modalities"),
                x = qr_matrix[["modalities"]],
                headerStyle = if (auto_format) header_style else NULL
            )
            openxlsx::writeData(
                wb = wb_mqr,
                sheet = paste0(name, "_values"),
                x = qr_matrix[["values"]],
                headerStyle = if (auto_format) header_style else NULL
            )
            if (auto_format) {
                wb_mqr <- apply_BQ_style(
                    wb = wb_mqr,
                    x = qr_matrix,
                    modalities_sheet = paste0(name, "_modalities"),
                    values_sheet = paste0(name, "_values")
                )
            }
        }

        openxlsx::saveWorkbook(
            wb = wb_mqr,
            file = file.path(export_dir, "mQR.xlsx"),
            overwrite = overwrite
        )
    }

    return(invisible(x))
}

#' @importFrom openxlsx createStyle
header_style <- openxlsx::createStyle(
    fontColour = "#ffffff",
    fgFill = "#4F80BD",
    textDecoration = "Bold",
    borderColour = "grey30"
)

#' @importFrom openxlsx createStyle
severe_style <- openxlsx::createStyle(
    fontColour = "#ffffff",
    fgFill = "black",
    bgFill = "black",
    borderColour = "grey30",
    border = "TopBottomLeftRight"
)

#' @importFrom openxlsx createStyle
bad_style <- openxlsx::createStyle(
    fontColour = "#9C0006",
    fgFill = "#FFC7CE",
    bgFill = "#FFC7CE",
    borderColour = "grey30",
    border = "TopBottomLeftRight"
)

#' @importFrom openxlsx createStyle
good_style <- openxlsx::createStyle(
    fontColour = "#006100",
    fgFill = "#C6EFCE",
    bgFill = "#C6EFCE",
    borderColour = "grey30",
    border = "TopBottomLeftRight"
)

#' @importFrom openxlsx createStyle
uncertain_style <- openxlsx::createStyle(
    fontColour = "#9c6a00",
    fgFill = "#ffeec7",
    bgFill = "#ffeec7",
    borderColour = "grey30",
    border = "TopBottomLeftRight"
)

#' @importFrom openxlsx createStyle
border_style <- openxlsx::createStyle(
    border = "TopBottomLeftRight",
    borderColour = "grey30"
)

#' @importFrom openxlsx createStyle
rowname_style <- openxlsx::createStyle(
    fontColour = "black",
    fgFill = "orange",
    textDecoration = "bold"
)

#' @importFrom openxlsx conditionalFormatting
#' @importFrom openxlsx addStyle
apply_BQ_style <- function(
    wb,
    x,
    values_sheet = NULL,
    modalities_sheet = NULL
) {
    if (!is.null(modalities_sheet)) {
        # Apply BQ style cell Modalities
        openxlsx::conditionalFormatting(
            wb = wb,
            sheet = modalities_sheet,
            rule = '=="Bad"',
            style = bad_style,
            cols = seq_len(ncol(x[["modalities"]])),
            rows = 1L + seq_len(nrow(x[["modalities"]]))
        )
        openxlsx::conditionalFormatting(
            wb = wb,
            sheet = modalities_sheet,
            rule = '=="Good"',
            style = good_style,
            cols = seq_len(ncol(x[["modalities"]])),
            rows = 1L + seq_len(nrow(x[["modalities"]]))
        )
        openxlsx::conditionalFormatting(
            wb = wb,
            sheet = modalities_sheet,
            rule = '=="Uncertain"',
            style = uncertain_style,
            cols = seq_len(ncol(x[["modalities"]])),
            rows = 1L + seq_len(nrow(x[["modalities"]]))
        )
        openxlsx::conditionalFormatting(
            wb = wb,
            sheet = modalities_sheet,
            rule = '=="Severe"',
            style = severe_style,
            cols = seq_len(ncol(x[["modalities"]])),
            rows = 1L + seq_len(nrow(x[["modalities"]]))
        )

        # Appliquer les styles aux bordures
        openxlsx::addStyle(
            wb = wb,
            sheet = modalities_sheet,
            style = border_style,
            cols = seq_len(ncol(x[["modalities"]])),
            rows = 1L + seq_len(nrow(x[["modalities"]])),
            gridExpand = TRUE
        )

        # Appliquer les styles aux noms de ligne (1ère colonne)
        openxlsx::addStyle(
            wb = wb,
            sheet = modalities_sheet,
            style = rowname_style,
            cols = 1L,
            rows = 1L + seq_len(nrow(x[["modalities"]])),
            gridExpand = TRUE
        )
    }

    if (!is.null(values_sheet)) {
        # Appliquer les styles aux bordures
        openxlsx::addStyle(
            wb = wb,
            sheet = values_sheet,
            style = border_style,
            cols = seq_len(ncol(x[["values"]])),
            rows = 1L + seq_len(nrow(x[["values"]])),
            gridExpand = TRUE
        )

        # Apply BQ style cell Modalities
        for (id_col in seq_len(ncol(x[["values"]]))) {
            name_col <- colnames(x[["values"]])[id_col]
            if (name_col %in% colnames(x[["modalities"]])) {
                for (id_row in seq_len(nrow(x[["values"]]))) {
                    cell_value <- as.character(x[["modalities"]][
                        id_row,
                        name_col
                    ])
                    cell_style <- switch(
                        cell_value,
                        Bad = bad_style,
                        Good = good_style,
                        Uncertain = uncertain_style,
                        Severe = severe_style,
                        NULL
                    )
                    if (!is.null(cell_style)) {
                        openxlsx::addStyle(
                            wb = wb,
                            sheet = values_sheet,
                            style = cell_style,
                            rows = id_row + 1L,
                            cols = id_col,
                            gridExpand = FALSE
                        )
                    }
                }
            }
        }

        # Appliquer les styles aux noms de ligne (1ère colonne)
        openxlsx::addStyle(
            wb = wb,
            sheet = values_sheet,
            style = rowname_style,
            cols = 1L,
            rows = 1L + seq_len(nrow(x[["values"]])),
            gridExpand = TRUE
        )
    }

    return(wb)
}
