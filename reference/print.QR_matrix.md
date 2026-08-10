# Printing QR_matrix and mQR_matrix objects

To print information on a QR_matrix or mQR_matrix object.

## Usage

``` r
# S3 method for class 'QR_matrix'
print(x, print_variables = TRUE, print_score_formula = TRUE, ...)

# S3 method for class 'mQR_matrix'
print(x, score_statistics = TRUE, ...)
```

## Arguments

- x:

  a
  [`mQR_matrix`](https://inseefr.github.io/rjd3qr/reference/QR_matrix.md)
  or
  [`mQR_matrix`](https://inseefr.github.io/rjd3qr/reference/QR_matrix.md)
  object.

- print_variables:

  logical indicating whether to print the indicators' name (including
  additionnal variables).

- print_score_formula:

  logical indicating whether to print the formula with which the score
  was calculated (when calculated).

- ...:

  other unused arguments.

- score_statistics:

  logical indicating whether to print the statistics in the
  [`mQR_matrix`](https://inseefr.github.io/rjd3qr/reference/QR_matrix.md)
  scores (when calculated).

## Value

the `print` method prints a
[`mQR_matrix`](https://inseefr.github.io/rjd3qr/reference/QR_matrix.md)
or
[`mQR_matrix`](https://inseefr.github.io/rjd3qr/reference/QR_matrix.md)
object and returns it invisibly (via `invisible(x)`).

## See also

[Traduction
française](https://inseefr.github.io/rjd3qr/reference/fr-print.QR_matrix.md)

Other QR_matrix functions:
[`QR_matrix()`](https://inseefr.github.io/rjd3qr/reference/QR_matrix.md),
[`extract_QR()`](https://inseefr.github.io/rjd3qr/reference/extract_QR.md),
[`rbind.QR_matrix()`](https://inseefr.github.io/rjd3qr/reference/rbind.QR_matrix.md),
[`sort`](https://inseefr.github.io/rjd3qr/reference/sort.md),
[`weighted_score()`](https://inseefr.github.io/rjd3qr/reference/weighted_score.md)

## Examples

``` r
# Path of matrix demetra_m
demetra_path <- file.path(
    system.file("extdata", package = "rjd3qr"),
    "WS/WS_world/Output/SAProcessing-1",
    "demetra_m.csv"
)

# Extract the quality report from the demetra_m file
QR <- extract_QR(file = demetra_path)
#> Multiple column found for extraction of diagnostics.seas-i-qs:2, diagnostics.seas-i-qs
#> Last column selected
#> Multiple column found for extraction of diagnostics.seas-i-f:2, diagnostics.seas-i-f
#> Last column selected

print(QR)
#> The quality report matrix has 6 observations
#> There are 18 indicators in the modalities matrix and 20 indicators in the values matrix
#> 
#> The quality report matrix contains the following variables:
#> series  residuals_homoskedasticity  residuals_skewness  residuals_kurtosis  residuals_normality  residuals_independency  qs_residual_s_on_sa  f_residual_s_on_sa  qs_residual_sa_on_i  f_residual_sa_on_i  f_residual_td_on_sa  f_residual_td_on_i  oos_mean  oos_mse  q  q_m2  m7  pct_outliers  frequency  arima_model
#> 
#> The variables exclusively found in the values matrix are:
#> frequency  arima_model
#> 
#> No score was calculated


# Prepare 2 quality reports
QR1 <- compute_score(x = QR, n_contrib_score = 5)
QR2 <- compute_score(
    x = QR,
    score_pond = c(qs_residual_s_on_sa = 5, qs_residual_sa_on_i = 30,
                   f_residual_td_on_sa = 10, f_residual_td_on_i = 40,
                   oos_mean = 30, residuals_skewness = 15, m7 = 25)
)
mQR <- mQR_matrix(list(a = QR1, b = QR2))

print(mQR)
#> The object contains 2 quality report(s)
#> 2 quality reports are named: a  b
#> The average score over all quality reports is 28.3333
#> The smallest score is 0 and the greatest is 195
#> 
#> 
#> The quality report n.1 (a) has an average score of 43.3333
#> The smallest score is 0 and the greatest is 195
#> 
#> 
#> The quality report n.2 (b) has an average score of 13.3333
#> The smallest score is 0 and the greatest is 40
```
