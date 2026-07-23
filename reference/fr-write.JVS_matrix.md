# Exporter un bilan qualité JVS

La fonction permet d'écrire le bilan qualité JVS dans un fichier csv ou
Excel.

## Arguments

- x:

  un objet
  [`JVS_matrix`](https://inseefr.github.io/rjd3qr/reference/JVS_matrix.md)
  à exporter.

- format:

  Chaîne de caractère qui défini le format d'output. Les choix possibles
  sont `"csv"` (par défault) ou `"xlsx"`.

- export_dir:

  Chemin vers le dossier qui contiendra les exports.

- overwrite:

  Booleen. Est ce qu'un fichier existant doit être ré-écrit ? Par
  défaut, `overwrite = TRUE`.

- ...:

  autres argument non utilisés

## Value

Renvoie de manière invisible (via `invisible(x)`) le même bilan qualité
[`JVS_matrix`](https://inseefr.github.io/rjd3qr/reference/JVS_matrix.md)
que `x`.

## Details

- les fichiers xlsx seront exportées avec le package 'openxlsx'.

- les fichiers csv seront exportées avec le package 'utils'.

## Examples

``` r
# Chemin menant au répertoire contenant le fichier demetra_m et les séries
dir_path <- system.file(
    "extdata", "WS", "WS_world", "Output", "SAProcessing-1",
    package = "JDCruncheR"
)

# Extraire le rapport JVS à partir des fichiers CSV
JVS <- extract_JVS(dir = dir_path)

# Export du rapport JVS dans un fichier Excel
write(JVS, format = "xlsx", export_dir = tempdir(), overwrite = TRUE)

# Export du rapport JVS dans un fichier CSV
write(JVS, format = "csv", export_dir = tempdir(), overwrite = TRUE)
```
