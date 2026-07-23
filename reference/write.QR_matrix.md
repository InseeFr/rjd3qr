# Exporting QR_matrix objects in an Excel file

To export a quality report in an Excel file.

## Usage

``` r
# S3 method for class 'QR_matrix'
write(x, file, auto_format = TRUE, overwrite = TRUE, ...)
```

## Arguments

- x:

  a
  [`QR_matrix`](https://inseefr.github.io/rjd3qr/reference/QR_matrix.md)
  object.

- file:

  a `character` object with the path to the file to export

- auto_format:

  logical indicating whether to format the output (`auto_format = TRUE`
  by default).

- overwrite:

  logical indicating whether to create an Excel file if it doesn't exist
  yet (`overwrite = TRUE` by default)

- ...:

  other unused arguments

## Value

Returns invisibly (via
[`invisible()`](https://rdrr.io/r/base/invisible.html)) a workbook
object created by
[`openxlsx::loadWorkbook()`](https://rdrr.io/pkg/openxlsx/man/loadWorkbook.html)
for further manipulation.

## See also

[Traduction
française](https://inseefr.github.io/rjd3qr/reference/fr-write.QR_matrix.md)

Other QR_matrix functions:
[`QR_matrix()`](https://inseefr.github.io/rjd3qr/reference/QR_matrix.md),
[`extract_QR()`](https://inseefr.github.io/rjd3qr/reference/extract_QR.md),
[`print.QR_matrix()`](https://inseefr.github.io/rjd3qr/reference/print.QR_matrix.md),
[`rbind.QR_matrix()`](https://inseefr.github.io/rjd3qr/reference/rbind.QR_matrix.md),
[`sort`](https://inseefr.github.io/rjd3qr/reference/sort.md),
[`weighted_score()`](https://inseefr.github.io/rjd3qr/reference/weighted_score.md),
[`write.mQR_matrix()`](https://inseefr.github.io/rjd3qr/reference/write.mQR_matrix.md)

## Examples

``` r
# Path leading to a demetra_m matrix
demetra_path <- file.path(
    system.file("extdata", package = "JDCruncheR"),
    "WS/WS_world/Output/SAProcessing-1",
    "demetra_m.csv"
)

# Extract the quality report from the demetra_m file
QR <- extract_QR(demetra_path)
#> Multiple column found for extraction of diagnostics.seas-i-qs:2, diagnostics.seas-i-qs
#> Last column selected
#> Multiple column found for extraction of diagnostics.seas-i-f:2, diagnostics.seas-i-f
#> Last column selected

# Export the Quality Report to an Excel file
write(x = QR, file = tempfile(fileext = ".xlsx"))
```
