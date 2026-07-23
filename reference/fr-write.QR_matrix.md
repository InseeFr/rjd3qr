# Export des objets QR_matrix dans un fichier Excel

Permet d'exporter un bilan qualité dans un fichier Excel.

## Arguments

- x:

  objet de type
  [`QR_matrix`](https://inseefr.github.io/rjd3qr/reference/QR_matrix.md).

- file:

  un objet de type `character` contenant le chemin menant au fichier que
  l'on veut créer

- auto_format:

  booléen indiquant s'il faut formatter la sortie (`auto_format = TRUE`
  par défaut).

- overwrite:

  booléen indiquant s'il faut ré-écrire créer le fichier Excel s'il
  existe déjà (`overwrite = TRUE` par défaut)

- ...:

  autres argument non utilisés

## Value

Renvoie de manière invisible (via
[`invisible()`](https://rdrr.io/r/base/invisible.html)) un classeur créé
par
[`openxlsx::loadWorkbook()`](https://rdrr.io/pkg/openxlsx/man/loadWorkbook.html)
pour une manipulation ultérieure.

## Examples

``` r
# Chemin menant au fichier demetra_m.csv
demetra_path <- file.path(
    system.file("extdata", package = "JDCruncheR"),
    "WS/WS_world/Output/SAProcessing-1",
    "demetra_m.csv"
)

# Extraire le bilan qualité à partir du fichier demetra_m.csv
QR <- extract_QR(demetra_path)
#> Multiple column found for extraction of diagnostics.seas-i-qs:2, diagnostics.seas-i-qs
#> Last column selected
#> Multiple column found for extraction of diagnostics.seas-i-f:2, diagnostics.seas-i-f
#> Last column selected

# Export du QR dans un fichier Excel
write(x = QR, file = tempfile(fileext = ".xlsx"))
```
