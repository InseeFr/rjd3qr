# Export des objets mQR_matrix dans des fichiers Excel

Permet d'exporter dans des fichiers Excel une liste de bilan qualité

## Arguments

- x:

  objet de type
  [`mQR_matrix`](https://inseefr.github.io/rjd3qr/reference/QR_matrix.md)
  à exporter.

- export_dir:

  dossier d'export des résultats.

- layout_file:

  paramètre d'export. Par défaut, (`layout_file = "ByComponent"`) et un
  fichier Excel est exporté par composante de la matrice bilan qualité
  (matrice des modalités ou des valeurs), dont chaque feuille correspond
  à un bilan qualité. Pour avoir un fichier par bilan qualité dont
  chaque feuille correspond à la composante exportée, utiliser
  `layout_file = "ByQRMatrix"`. La modalité
  `layout_file = "AllTogether"` correspond à la création d'un fichier
  avec 2 feuilles par bilan qualité (`Values` et `Modalities`).

- auto_format:

  booléen indiquant s'il faut formatter la sortie (`auto_format = TRUE`
  par défaut).

- overwrite:

  booléen indiquant s'il faut ré-écrire créer le fichier Excel s'il
  existe déjà (`overwrite = TRUE` par défaut)

- ...:

  autres argument non utilisés

## Value

Renvoie de manière invisible (via `invisible(x)`) le même objet
[`mQR_matrix`](https://inseefr.github.io/rjd3qr/reference/QR_matrix.md)
que `x`.

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

# Calculer le score
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
```
