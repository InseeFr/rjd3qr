# Manipulation de la liste des indicateurs

Permet d'ajouter des indicateurs (fonction `add_indicator`), retirer des
indicateurs (fonction
[`remove_indicators()`](https://inseefr.github.io/rjd3qr/reference/QR_var_manipulation.md))
ou de n'en retenir que certains (fonction
[`retain_indicators()`](https://inseefr.github.io/rjd3qr/reference/QR_var_manipulation.md))
d'objets
[`QR_matrix`](https://inseefr.github.io/rjd3qr/reference/QR_matrix.md)
ou
[`mQR_matrix`](https://inseefr.github.io/rjd3qr/reference/QR_matrix.md).
Le nom des séries (colonne "series") ne peut être enlevé.

## Arguments

- x:

  objet de type
  [`QR_matrix`](https://inseefr.github.io/rjd3qr/reference/QR_matrix.md)
  ou
  [`mQR_matrix`](https://inseefr.github.io/rjd3qr/reference/QR_matrix.md).

- indicator:

  un `vector` ou un `data.frame` (voir détails).

- variable_name:

  chaîne de caractères contenant les noms des nouvelles variables.

- ...:

  autres paramètres de la fonction
  [`merge`](https://rdrr.io/r/base/merge.html) (pour `add_inidcator`) et
  les noms des variables à retirer ou conserver (pour
  `remove_indicators` et `retain_idicators`).

## Value

Cette fonction

- [`remove_indicators()`](https://inseefr.github.io/rjd3qr/reference/QR_var_manipulation.md)
  renvoie le même objet `x` réduit par les drapeaux et les variables
  utilisés comme arguments ... Donc si l'entrée `x` est une matrice
  `QR_matrix`, un objet de la classe `QR_matrix` est renvoyé. Si le code
  d'entrée `x` est une matrice mQR, un objet de la classe `mQR_matrix`
  est renvoyé.

- `retains_indicators()` renvoie le même objet, avec seulement les
  indicateurs choisis.

- `add_incicators` renvoie le même objet, enrichi de l'indicateur
  choisi. Ainsi, si l'entrée `x` est une matrice QR, un objet de la
  classe `QR_matrix` est renvoyé. Si le code d'entrée `x` est une
  matrice mQR, un objet de la classe `mQR_matrix` est renvoyé.

## Details

La fonction
[`add_indicator()`](https://inseefr.github.io/rjd3qr/reference/QR_var_manipulation.md)
permet d'ajouter un indicateur dans la matrice des valeurs du bilan
qualité. L'indicateur n'est donc pas ajouté dans la matrice des
modalités et ne peut être utilisé dans le calcul du score (sauf pour le
pondérer). Pour l'utiliser dans le calcul du score, il faudra d'abord le
recoder avec la fonction
[`recode_indicator_num`](https://inseefr.github.io/rjd3qr/reference/recode_indicator_num.md).

L'indicateur à ajouter peut être sous deux formats : `vector` ou
`data.frame`. Dans les deux cas, il faut que les valeurs à ajouter
puissent être associées aux bonnes séries dans la matrice du bilan
qualité :

- dans le cas d'un `vector`, les éléments devront être nommés et les
  noms doivent correspondre à ceux présents dans le bilan qualité
  (variable "series") ;

- dans le cas d'un `data.frame`, il devra contenir une colonne "series"
  avec les noms des séries correspondantes.

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

# Ajouter un nouvel indicateur
my_alea <- rnorm(nrow(QR$modalities))
names(my_alea) <- QR$modalities$series
QR <- add_indicator(QR, indicator = my_alea, variable_name = "alea")

# Retenir certains indicateurs
retain_indicators(QR, "alea", "m7") # Retiens les indicateurs "alea" et "m7"
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
retain_indicators(QR, c("alea", "m7")) # Pareil
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

# Retirer des indicateurs
QR <- remove_indicators(QR, "alea") # Retirer "alea"

retain_indicators(QR, "alea") # est vide car l'indicateur "alea" a été retiré
#> The quality report matrix is empty
```
