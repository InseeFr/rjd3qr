# Exporting JVS_matrix objects in CSV or Excel files

To export several quality reports in CSV or Excel files

## Usage

``` r
# S3 method for class 'JVS_matrix'
write(
  x,
  format = c("csv", "xlsx"),
  export_dir = tempdir(),
  overwrite = TRUE,
  ...
)
```

## Arguments

- x:

  a
  [`JVS_matrix`](https://inseefr.github.io/rjd3qr/reference/JVS_matrix.md)
  object to export.

- format:

  output format. One of `"csv"` or `"xlsx"`. The default is `"csv"`.

- export_dir:

  export directory.

- overwrite:

  logical indicating whether to create a CSV or Excel file if it doesn't
  exist yet (`overwrite = TRUE` by default)

- ...:

  other unused arguments

## Value

Returns invisibly (via `invisible(x)`) the same
[`JVS_matrix`](https://inseefr.github.io/rjd3qr/reference/JVS_matrix.md)
object as `x`.

## Details

- xlsx files will be exported with the package 'openxlsx'.

- csv files will be exported with the package 'utils'.

## See also

[Traduction
française](https://inseefr.github.io/rjd3qr/reference/fr-write.JVS_matrix.md)

Other JVS_matrix functions:
[`extract_JVS()`](https://inseefr.github.io/rjd3qr/reference/extract_JVS.md)

## Examples

``` r
# Path leading to the needed CSV files demetra_m and series
dir_path <- file.path(
    system.file("extdata", package = "JDCruncheR"),
    "WS/WS_world/Output/SAProcessing-1"
)

# Extract the JVS report from the CSV files
JVS <- extract_JVS(dir = dir_path)

# Export of the JVS report in an Excel file
write(JVS, format = "xlsx", export_dir = tempdir(), overwrite = TRUE)

# Export of the JVS report in a CSV file
write(JVS, format = "csv", export_dir = tempdir(), overwrite = TRUE)
```
