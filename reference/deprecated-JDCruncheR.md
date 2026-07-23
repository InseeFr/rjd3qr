# Deprecated functions

Use [`write()`](https://inseefr.github.io/rjd3qr/reference/write.md)
instead of `export_xslx()`.

## Usage

``` r
export_xlsx(x, ...)
```

## Arguments

- x:

  a
  [`JVS_matrix`](https://inseefr.github.io/rjd3qr/reference/JVS_matrix.md),
  a
  [`QR_matrix`](https://inseefr.github.io/rjd3qr/reference/QR_matrix.md)
  or
  [`mQR_matrix`](https://inseefr.github.io/rjd3qr/reference/QR_matrix.md)
  object.

- ...:

  other parameters of the function
  [`write.QR_matrix`](https://inseefr.github.io/rjd3qr/reference/write.QR_matrix.md)
  or
  [`write.JVS_matrix`](https://inseefr.github.io/rjd3qr/reference/write.JVS_matrix.md).

## Value

`"QR_matrix"`, `"mQR_matrix"` or `"JVS_matrix"` object invisibly.

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
# `export_xlsx` is deprecated.
# Use `write` instead:
write(x = QR, file = tempfile(fileext = ".xlsx"))
write(x = mQR, export_dir = tempdir())
```
