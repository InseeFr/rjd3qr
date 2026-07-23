# Writing QR to files

Writing QR to files

## Usage

``` r
write(x, ...)
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

If `x` is a
[`JVS_matrix`](https://inseefr.github.io/rjd3qr/reference/JVS_matrix.md)
or a
[`mQR_matrix`](https://inseefr.github.io/rjd3qr/reference/QR_matrix.md),
the function returns invisibly (via `invisible(x)`) the same object as
`x`. Else if `x` is a
[`QR_matrix`](https://inseefr.github.io/rjd3qr/reference/QR_matrix.md),
the function returns invisibly (via
[`invisible()`](https://rdrr.io/r/base/invisible.html)) a workbook
object created by
[`openxlsx::loadWorkbook()`](https://rdrr.io/pkg/openxlsx/man/loadWorkbook.html)
for further manipulation.

## See also

[Traduction
française](https://inseefr.github.io/rjd3qr/reference/fr-write.md)
