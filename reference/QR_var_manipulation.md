# Editing the indicators list

Functions to add indicator (`add_indicator()`), remove indicators
(`remove_indicators()`) or retrain some indicators only
(`retain_indicators()`) to and from
[`QR_matrix`](https://inseefr.github.io/rjd3qr/reference/QR_matrix.md)
or
[`mQR_matrix`](https://inseefr.github.io/rjd3qr/reference/QR_matrix.md)
objects. The series names (column "series") cannot be removed.

## Usage

``` r
remove_indicators(x, ...)

# Default S3 method
remove_indicators(x, ...)

# S3 method for class 'QR_matrix'
remove_indicators(x, ...)

# S3 method for class 'mQR_matrix'
remove_indicators(x, ...)

retain_indicators(x, ...)

# Default S3 method
retain_indicators(x, ...)

# S3 method for class 'QR_matrix'
retain_indicators(x, ...)

# S3 method for class 'mQR_matrix'
retain_indicators(x, ...)

add_indicator(x, indicator, variable_name, ...)

# Default S3 method
add_indicator(x, indicator, variable_name, ...)

# S3 method for class 'QR_matrix'
add_indicator(x, indicator, variable_name, ...)

# S3 method for class 'mQR_matrix'
add_indicator(x, indicator, variable_name, ...)
```

## Arguments

- x:

  a
  [`QR_matrix`](https://inseefr.github.io/rjd3qr/reference/QR_matrix.md)
  or
  [`mQR_matrix`](https://inseefr.github.io/rjd3qr/reference/QR_matrix.md)
  object.

- ...:

  other parameters of the function
  [`merge`](https://rdrr.io/r/base/merge.html) (for `add_indicator`) or
  names of the variable to remove or keep (for `retain_indicators` and
  `remove_indicators`)

- indicator:

  a `vector` or a `data.frame` (cf. details).

- variable_name:

  a string containing the name of the variables to add.

## Value

- `remove_indicators()` returns the same object `x` reduced by the flags
  and variables used as arguments ... So if the input `x` is a
  `QR_matrix`, an object of class `QR_matrix` is returned. If the input
  `x` is a `mQR_matrix`, an object of class `mQR_matrix` is returned.

- `retains_indicators()` returns the same object, with only the chosen
  indicators.

- `add_indicators()` returns the same object, enhanced with the chosen
  indicator. So if the input `x` is a `QR_matrix`, an object of class
  `QR_matrix` is returned. If the input `x` is a `mQR_matrix`, an object
  of class `mQR_matrix` is returned.

## Details

The function `add_indicator()` adds the chosen indicator to the values
matrix of a quality report. Therefore, because said indicator isn't
added in the modalities matrix, it cannot be used to calculate a score
(except for weighting). Before using the added variable for score
calculation, it will have to be coded with the function
[`recode_indicator_num`](https://inseefr.github.io/rjd3qr/reference/recode_indicator_num.md).

The new indicator can be a `vector` or a `data.frame`. In both cases,
its format must allow for pairing:

- a `vector`'s elements must be named and these names must match those
  of the quality report (variable "series");

- a `data.frame` must contain a "series" column that matches with the
  quality report's series.

## See also

[Traduction
française](https://inseefr.github.io/rjd3qr/reference/fr-QR_var_manipulation.md)

Other var QR_matrix manipulation:
[`recode_indicator_num()`](https://inseefr.github.io/rjd3qr/reference/recode_indicator_num.md)

## Examples

``` r
# Path of matrix demetra_m
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

# Add a new indicator
my_alea <- rnorm(nrow(QR$modalities))
names(my_alea) <- QR$modalities$series
QR <- add_indicator(QR, indicator = my_alea, variable_name = "alea")

# Retains indicators
retain_indicators(QR, "alea", "m7") # retaining "alea" and "m7"
#> The quality report matrix has 6 observations
#> There are 2 indicators in the modalities matrix and 3 indicators in the values matrix
#> 
#> The quality report matrix contains the following variables:
#> series  m7  alea
#> 
#> The variables exclusively found in the values matrix are:
#> alea
#> 
#> No score was calculated
retain_indicators(QR, c("alea", "m7")) # Same
#> The quality report matrix has 6 observations
#> There are 2 indicators in the modalities matrix and 3 indicators in the values matrix
#> 
#> The quality report matrix contains the following variables:
#> series  m7  alea
#> 
#> The variables exclusively found in the values matrix are:
#> alea
#> 
#> No score was calculated

# Remove indicators
QR <- remove_indicators(QR, "alea") # Remove "alea"

retain_indicators(QR, "alea")
#> The quality report matrix is empty
# is empty because we removed the alea indicator
```
