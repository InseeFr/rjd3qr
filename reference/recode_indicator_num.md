# Converting "values variables" into "modalities variables"

To transform variables from the values matrix into categorical variables
that can be added into the modalities matrix.

## Usage

``` r
recode_indicator_num(
  x,
  variable_name,
  breaks = c(0, 0.01, 0.05, 0.1, 1),
  labels = c("Good", "Uncertain", "Bad", "Severe"),
  ...
)

# S3 method for class 'QR_matrix'
recode_indicator_num(
  x,
  variable_name,
  breaks = c(0, 0.01, 0.05, 0.1, 1),
  labels = c("Good", "Uncertain", "Bad", "Severe"),
  ...
)

# S3 method for class 'mQR_matrix'
recode_indicator_num(
  x,
  variable_name,
  breaks = c(0, 0.01, 0.05, 0.1, 1),
  labels = c("Good", "Uncertain", "Bad", "Severe"),
  ...
)
```

## Arguments

- x:

  a
  [`QR_matrix`](https://inseefr.github.io/rjd3qr/reference/QR_matrix.md)
  or
  [`mQR_matrix`](https://inseefr.github.io/rjd3qr/reference/QR_matrix.md)
  object.

- variable_name:

  a vector of strings containing the names of the variables to convert.

- breaks:

  see function [`cut`](https://rdrr.io/r/base/cut.html).

- labels:

  see function [`cut`](https://rdrr.io/r/base/cut.html).

- ...:

  other parameters of the [`cut`](https://rdrr.io/r/base/cut.html)
  function.

## Value

The function `recode_indicator_num()` returns the same object, enhanced
with the chosen indicator. So if the input `x` is a QR_matrix, an object
of class `QR_matrix` is returned. If the input `x` is a mQR_matrix, an
object of class `mQR_matrix` is returned.

## See also

[Traduction
française](https://inseefr.github.io/rjd3qr/reference/fr-recode_indicator_num.md)

Other var QR_matrix manipulation:
[`QR_var_manipulation`](https://inseefr.github.io/rjd3qr/reference/QR_var_manipulation.md)

## Examples

``` r
# Path to the demetra_m.csv file
demetra_path <- file.path(
    system.file("extdata", package = "rjd3qr"),
    "WS/WS_world/Output/SAProcessing-1",
    "demetra_m.csv"
)

# Extract the quality report from the demetra_m file
QR <- extract_QR(demetra_path)
#> Multiple column found for extraction of diagnostics.seas-i-qs:2, diagnostics.seas-i-qs
#> Last column selected
#> Multiple column found for extraction of diagnostics.seas-i-f:2, diagnostics.seas-i-f
#> Last column selected

# Recode residuals_skewness
QR2 <- recode_indicator_num(QR, variable_name = "residuals_skewness",
                            breaks = c(0.0, 0.01, 0.05, 0.1, 1.0),
                            labels = c("Good", "Uncertain", "Bad", "Severe")
)

QR$modalities$residuals_skewness
#> [1] Good      Good      Good      Good      Uncertain Good     
#> Levels: Bad < Uncertain < Good
QR2$modalities$residuals_skewness
#> [1] Severe    Severe    Severe    Severe    Uncertain Severe   
#> Levels: Good Uncertain Bad Severe
```
