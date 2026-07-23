# Exporting mQR_matrix objects in Excel files

To export several quality reports in Excel files

## Usage

``` r
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

  a
  [`mQR_matrix`](https://inseefr.github.io/rjd3qr/reference/QR_matrix.md)
  object to export.

- export_dir:

  export directory.

- layout_file:

  export parameter. By default, (`layout_file = "ByComponent"`) and an
  Excel file is exported for each part of the quality report matrix
  (modalities and values matrices). To group both modalities and values
  reports/sheets into a single Excel file, use the option
  `layout_file = "ByQRMatrix"`. With `AllTogether`, all the QR and
  components are in the same file.

- auto_format:

  logical indicating whether to format the output (`auto_format = TRUE`
  by default).

- overwrite:

  logical indicating whether to create an Excel file if it doesn't exist
  yet (`overwrite = TRUE` by default)

- ...:

  other unused arguments

## Value

Returns invisibly (via `invisible(x)`) the same
[`mQR_matrix`](https://inseefr.github.io/rjd3qr/reference/QR_matrix.md)
object as `x`.

## See also

[Traduction
française](https://inseefr.github.io/rjd3qr/reference/fr-write.mQR_matrix.md)

Other QR_matrix functions:
[`QR_matrix()`](https://inseefr.github.io/rjd3qr/reference/QR_matrix.md),
[`extract_QR()`](https://inseefr.github.io/rjd3qr/reference/extract_QR.md),
[`print.QR_matrix()`](https://inseefr.github.io/rjd3qr/reference/print.QR_matrix.md),
[`rbind.QR_matrix()`](https://inseefr.github.io/rjd3qr/reference/rbind.QR_matrix.md),
[`sort`](https://inseefr.github.io/rjd3qr/reference/sort.md),
[`weighted_score()`](https://inseefr.github.io/rjd3qr/reference/weighted_score.md),
[`write.QR_matrix()`](https://inseefr.github.io/rjd3qr/reference/write.QR_matrix.md)

## Examples

``` r
# Path leading to the demetra_m.csv file
demetra_path <- file.path(
    system.file("extdata", package = "JDCruncheR"),
    "WS/WS_world/Output/SAProcessing-1",
    "demetra_m.csv"
)

# Extraction of the QR from the demetra_m.csv file
QR <- extract_QR(demetra_path)
#> Multiple column found for extraction of diagnostics.seas-i-qs:2, diagnostics.seas-i-qs
#> Last column selected
#> Multiple column found for extraction of diagnostics.seas-i-f:2, diagnostics.seas-i-f
#> Last column selected

# Compute the scores
QR1 <- compute_score(x = QR, n_contrib_score = 5)
QR2 <- compute_score(
    x = QR,
    score_pond = c(qs_residual_s_on_sa = 5, qs_residual_sa_on_i = 30,
                   f_residual_td_on_sa = 10, f_residual_td_on_i = 40,
                   oos_mean = 30, residuals_skewness = 15, m7 = 25)
)
mQR <- mQR_matrix(list(a = QR1, b = QR2))

# Export the Multiple Quality Report to an Excel file
write(x = mQR, export_dir = tempdir())

```
