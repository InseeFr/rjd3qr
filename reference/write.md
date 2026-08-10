# Writing Quality Reports to Files

Writing Quality Reports to Files

## Usage

``` r
write(x, ...)

# S3 method for class 'QR_matrix'
write(x, file, auto_format = TRUE, overwrite = TRUE, ...)

# S3 method for class 'JVS_matrix'
write(
  x,
  file = file.path(tempdir(), "JobVacancySurveyQR.csv"),
  overwrite = TRUE,
  verbose = TRUE,
  ...
)

# S3 method for class 'mQR_matrix'
write(
  x,
  export_dir,
  layout_file = c("ByComponent", "ByQRMatrix", "AllTogether"),
  auto_format = TRUE,
  overwrite = TRUE,
  ...
)
```

## Arguments

- x:

  An object of class
  [`JVS_matrix`](https://inseefr.github.io/rjd3qr/reference/JVS_matrix.md),
  [`QR_matrix`](https://inseefr.github.io/rjd3qr/reference/QR_matrix.md),
  or
  [`mQR_matrix`](https://inseefr.github.io/rjd3qr/reference/QR_matrix.md)
  to export.

- ...:

  Other unused arguments.

- file:

  A `character` object containing the path to the file to be created.

- auto_format:

  Boolean indicating whether to format the output (`auto_format = TRUE`
  by default).

- overwrite:

  Boolean. Should an existing file be overwritten? By default,
  `overwrite = TRUE`.

- verbose:

  Boolean indicating whether to print additional information. Default is
  `TRUE`.

- export_dir:

  Path to the directory that will contain the exported files.

- layout_file:

  Export parameter. By default, (`layout_file = "ByComponent"`) and an
  Excel file is exported for each component of the quality report matrix
  (modalities or values matrix), where each sheet corresponds to a
  quality report. To have one file per quality report, with each sheet
  corresponding to the exported component, use
  `layout_file = "ByQRMatrix"`. The modality
  `layout_file = "AllTogether"` corresponds to creating a file with 2
  sheets per quality report (`Values` and `Modalities`).

## Value

If `x` is of class
[`JVS_matrix`](https://inseefr.github.io/rjd3qr/reference/JVS_matrix.md)
or
[`mQR_matrix`](https://inseefr.github.io/rjd3qr/reference/QR_matrix.md),
the function invisibly returns (with
[`invisible()`](https://rdrr.io/r/base/invisible.html)) the object `x`.
If `x` is of class
[`QR_matrix`](https://inseefr.github.io/rjd3qr/reference/QR_matrix.md),
the function invisibly returns (with
[`invisible()`](https://rdrr.io/r/base/invisible.html)) a workbook
object created by
[`openxlsx::loadWorkbook()`](https://rdrr.io/pkg/openxlsx/man/loadWorkbook.html)
for further manipulation.

## Details

Objects of class
[`JVS_matrix`](https://inseefr.github.io/rjd3qr/reference/JVS_matrix.md)
can be exported to CSV or Excel files (depending on the `format`
argument). Objects of class
[`QR_matrix`](https://inseefr.github.io/rjd3qr/reference/QR_matrix.md)
and
[`mQR_matrix`](https://inseefr.github.io/rjd3qr/reference/QR_matrix.md)
are only written to Excel files.

## See also

[Traduction
française](https://inseefr.github.io/rjd3qr/reference/fr-write.md)

## Examples

``` r
# Path to the directory containing the demetra_m file and series
dir_path <- system.file(
    "extdata", "WS", "WS_world", "Output", "SAProcessing-1",
    package = "rjd3qr"
)

# Path to the demetra_m.csv file
demetra_path <- file.path(dir_path, "demetra_m.csv")

# Extract the quality report from the demetra_m.csv file
QR <- extract_QR(demetra_path)
#> Multiple column found for extraction of diagnostics.seas-i-qs:2, diagnostics.seas-i-qs
#> Last column selected
#> Multiple column found for extraction of diagnostics.seas-i-f:2, diagnostics.seas-i-f
#> Last column selected

# Export the QR to an Excel file
write(x = QR, file = tempfile(fileext = ".xlsx"))

# Prepare 2 quality reports
QR1 <- compute_score(x = QR, n_contrib_score = 5)
QR2 <- compute_score(
    x = QR,
    score_pond = c(qs_residual_s_on_sa = 5, qs_residual_sa_on_i = 30,
                   f_residual_td_on_sa = 10, f_residual_td_on_i = 40,
                   oos_mean = 30, residuals_skewness = 15, m7 = 25)
)
mQR <- mQR_matrix(list(a = QR1, b = QR2))

# Export the mQR to an Excel file
write(x = mQR, export_dir = tempdir())

# Extract the JVS report from CSV files
JVS <- extract_JVS(dir = dir_path)

# Export the JVS report to an Excel file
write(JVS, format = "xlsx", export_dir = tempdir(), overwrite = TRUE)
#> The JVS report will be exported to /tmp/RtmpT7JJje/JobVacancySurveyQR.csv.
#> The file already exists and will be overwritten.

# Export the JVS report to a CSV file
write(JVS, format = "csv", export_dir = tempdir(), overwrite = TRUE)
#> The JVS report will be exported to /tmp/RtmpT7JJje/JobVacancySurveyQR.csv.
#> The file already exists and will be overwritten.
```
