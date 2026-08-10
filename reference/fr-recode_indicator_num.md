# Ré-encodage en modalités des variables

Permet d'encoder des variables présentes dans la matrice des valeurs en
modalités ajoutables à la matrice des modalités.

## Arguments

- x:

  objet de type
  [`QR_matrix`](https://inseefr.github.io/rjd3qr/reference/QR_matrix.md)
  ou
  [`mQR_matrix`](https://inseefr.github.io/rjd3qr/reference/QR_matrix.md).

- variable_name:

  vecteur de chaînes de caractères contenant les noms des variables à
  recoder.

- breaks:

  voir l'argument éponyme de la fonction
  [`cut`](https://rdrr.io/r/base/cut.html).

- labels:

  voir l'argument éponyme de la fonction
  [`cut`](https://rdrr.io/r/base/cut.html).

- ...:

  autres paramètres de la fonction
  [`cut`](https://rdrr.io/r/base/cut.html).

## Value

La fonction
[`recode_indicator_num()`](https://inseefr.github.io/rjd3qr/reference/recode_indicator_num.md)
renvoie le même objet, enrichi de l'indicateur choisi. Ainsi, si
l'entrée `x` est une matrice QR_matrix, un objet de classe `QR_matrix`
est renvoyé. Si le code d'entrée `x` est une matrice mQR, un objet de la
classe `mQR_matrix` est renvoyé.

## Examples

``` r
# Chemin menant au fichier demetra_m.csv
demetra_path <- file.path(
    system.file("extdata", package = "rjd3qr"),
    "WS/WS_world/Output/SAProcessing-1",
    "demetra_m.csv"
)

# Extraire le bilan qualité à partir du fichier demetra_m.csv
QR <- extract_QR(demetra_path)
#> Multiple column found for extraction of diagnostics.seas-i-qs:2, diagnostics.seas-i-qs
#> Last column selected
#> Multiple column found for extraction of diagnostics.seas-i-f:2, diagnostics.seas-i-f
#> Last column selected

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
