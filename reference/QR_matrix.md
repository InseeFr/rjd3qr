# Quality report objects

`mQR_matrix()` and `QR_matrix()` are creating one (or several) quality
report. The function `is.QR_matrix()` and `is.mQR_matrix()` are
functions to test whether an object is a quality report or a list of
quality reports.

## Usage

``` r
QR_matrix(modalities = NULL, values = NULL, score_formula = NULL)

mQR_matrix(x = list(), ...)

# S3 method for class 'QR_matrix'
mQR_matrix(x = QR_matrix(), ...)

# S3 method for class 'mQR_matrix'
mQR_matrix(x = mQR_matrix.default(), ...)

# Default S3 method
mQR_matrix(x = list(), ...)

is.QR_matrix(x)

is.mQR_matrix(x)
```

## Arguments

- modalities:

  a `data.frame` containing the output variables' modalities (Good, Bad,
  etc.)

- values:

  a `data.frame` containing the output variables' values (test p-values,
  test statistics, etc.) Therefore, the values data frame can contain
  more variables than the data frame `modalities`.

- score_formula:

  the formula used to calculate the series score (if defined).

- x:

  a `QR_matrix` object, a `mQR_matrix` object or a list of `QR_matrix`
  objects.

- ...:

  objects of the same type as `x`.

## Value

`QR_matrix()` creates and returns a `QR_matrix` object. `mQR_matrix()`
creates and returns a `mQR_matrix` object (ie. a list of `QR_matrix`
objects). `is.QR_matrix()` and `is.mQR_matrix()` return Boolean values
(`TRUE` or `FALSE`).

## Details

A`QR_matrix` object is a list of three items:

- `modalities`, a `data.frame` containing a set of categorical variables
  (by default: Good, Uncertain, Bad, Severe).

- `values`, a `data.frame` containing the values corresponding to the
  `modalities` indicators (i.e. p-values, statistics, etc.), as well as
  variables for which a modality cannot be defined (e.g. the series
  frequency, the ARIMA model, etc).

- `score_formula` contains the formula used to calculate the series
  score (once the calculus is done).

## See also

[Traduction
française](https://inseefr.github.io/rjd3qr/reference/fr-QR_matrix.md)

Other QR_matrix functions:
[`extract_QR()`](https://inseefr.github.io/rjd3qr/reference/extract_QR.md),
[`print.QR_matrix()`](https://inseefr.github.io/rjd3qr/reference/print.QR_matrix.md),
[`rbind.QR_matrix()`](https://inseefr.github.io/rjd3qr/reference/rbind.QR_matrix.md),
[`sort`](https://inseefr.github.io/rjd3qr/reference/sort.md),
[`weighted_score()`](https://inseefr.github.io/rjd3qr/reference/weighted_score.md)

## Examples

``` r
modalities <- data.frame(
    Quality = c("Good", "Uncertain", "Bad"),
    Seasonality = c("Good", "Good", "Bad")
)

values <- data.frame(
    Quality = c(0.95, 0.75, 0.02),
    Seasonality = c(0.80, 0.60, 0.01),
    Period = c(12L, 12L, 12L)
)

# Create two quality report objects
QR1 <- QR_matrix(
    modalities = modalities,
    values = values
)

QR2 <- QR_matrix(
    modalities = modalities,
    values = values
)

# Test whether an object is a quality report
is.QR_matrix(QR1)
#> [1] TRUE

# Create a list of quality reports
mQR <- mQR_matrix(QR1, QR2)

# Test whether an object is a list of quality reports
is.mQR_matrix(mQR)
#> [1] TRUE
```
