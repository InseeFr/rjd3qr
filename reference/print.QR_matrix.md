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
[`weighted_score()`](https://inseefr.github.io/rjd3qr/reference/weighted_score.md),
[`write.QR_matrix()`](https://inseefr.github.io/rjd3qr/reference/write.QR_matrix.md),
[`write.mQR_matrix()`](https://inseefr.github.io/rjd3qr/reference/write.mQR_matrix.md)
