# Ecriture de bilans qualités dans des fichiers

Ecriture de bilans qualités dans des fichiers

## Arguments

- x:

  Objet de classe
  [`JVS_matrix`](https://inseefr.github.io/rjd3qr/reference/JVS_matrix.md),
  [`QR_matrix`](https://inseefr.github.io/rjd3qr/reference/QR_matrix.md)
  ou
  [`mQR_matrix`](https://inseefr.github.io/rjd3qr/reference/QR_matrix.md)
  à exporter

- file:

  un objet de type `character` contenant le chemin menant au fichier que
  l'on veut créer

- export_dir:

  Chemin vers le dossier qui contiendra les exports.

- auto_format:

  booléen indiquant s'il faut formatter la sortie (`auto_format = TRUE`
  par défaut).

- layout_file:

  paramètre d'export. Par défaut, (`layout_file = "ByComponent"`) et un
  fichier Excel est exporté par composante de la matrice bilan qualité
  (matrice des modalités ou des valeurs), dont chaque feuille correspond
  à un bilan qualité. Pour avoir un fichier par bilan qualité dont
  chaque feuille correspond à la composante exportée, utiliser
  `layout_file = "ByQRMatrix"`. La modalité
  `layout_file = "AllTogether"` correspond à la création d'un fichier
  avec 2 feuilles par bilan qualité (`Values` et `Modalities`).

- overwrite:

  Booléen. Est ce qu'un fichier existant doit être ré-écrit ? Par
  défaut, `overwrite = TRUE`.

- verbose:

  Booleen. Est ce que des informations supplémentaires doivent être
  affichées ? Valeur par défaut, `TRUE`.

- ...:

  Autre argument non utilisé.

## Value

Si `x` est de classe
[`JVS_matrix`](https://inseefr.github.io/rjd3qr/reference/JVS_matrix.md)
ou
[`mQR_matrix`](https://inseefr.github.io/rjd3qr/reference/QR_matrix.md),
la fonction retourne de manière invisible (avec
[`invisible()`](https://rdrr.io/r/base/invisible.html)) l'objet x. Si
`x` est de classe
[`QR_matrix`](https://inseefr.github.io/rjd3qr/reference/QR_matrix.md),
la fonction retourne de manière invisible (avec
[`invisible()`](https://rdrr.io/r/base/invisible.html)) l'objet un
classeur créé par
[`openxlsx::loadWorkbook()`](https://rdrr.io/pkg/openxlsx/man/loadWorkbook.html)
pour une manipulation ultérieure.

## Details

Les objets de classe
[`JVS_matrix`](https://inseefr.github.io/rjd3qr/reference/JVS_matrix.md)
peuvent être exportés dans des fichiers csv ou Excel (selon l'argument
`format`). Les objets de classe
[`QR_matrix`](https://inseefr.github.io/rjd3qr/reference/QR_matrix.md)
et
[`mQR_matrix`](https://inseefr.github.io/rjd3qr/reference/QR_matrix.md)
ne sont écrits que dans des fichiers Excel.

## Examples

``` r
# Chemin menant au répertoire contenant le fichier demetra_m et les séries
dir_path <- system.file(
    "extdata", "WS", "WS_world", "Output", "SAProcessing-1",
    package = "rjd3qr"
)

# Chemin menant au fichier demetra_m.csv
demetra_path <- file.path(dir_path, "demetra_m.csv")

# Extraire le bilan qualité à partir du fichier demetra_m.csv
QR <- extract_QR(demetra_path)
#> Multiple column found for extraction of diagnostics.seas-i-qs:2, diagnostics.seas-i-qs
#> Last column selected
#> Multiple column found for extraction of diagnostics.seas-i-f:2, diagnostics.seas-i-f
#> Last column selected

# Export du QR dans un fichier Excel
write(x = QR, file = tempfile(fileext = ".xlsx"))

# Préparation de 2 bilans qualités
QR1 <- compute_score(x = QR, n_contrib_score = 5)
QR2 <- compute_score(
    x = QR,
    score_pond = c(qs_residual_s_on_sa = 5, qs_residual_sa_on_i = 30,
                   f_residual_td_on_sa = 10, f_residual_td_on_i = 40,
                   oos_mean = 30, residuals_skewness = 15, m7 = 25)
)
mQR <- mQR_matrix(list(a = QR1, b = QR2))

# Export du mQR dans un fichier Excel
write(x = mQR, export_dir = tempdir())

# Extraire le rapport JVS à partir des fichiers CSV
JVS <- extract_JVS(dir = dir_path)

# Export du rapport JVS dans un fichier Excel
write(JVS, format = "xlsx", export_dir = tempdir(), overwrite = TRUE)
#> The JVS report will be exported to /tmp/Rtmp4uXWm0/JobVacancySurveyQR.csv.

# Export du rapport JVS dans un fichier CSV
write(JVS, format = "csv", export_dir = tempdir(), overwrite = TRUE)
#> The JVS report will be exported to /tmp/Rtmp4uXWm0/JobVacancySurveyQR.csv.
#> The file already exists and will be overwritten.
```
