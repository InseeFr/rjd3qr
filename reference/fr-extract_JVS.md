# Création d'un rapport JVS

Créé un rapport JVS à partir des fichiers de sortie de JDemetra+. Les
fichiers de sortie peuvent être générés avec l'interface graphique ou
avec le cruncher et sont des fichiers CSV contenant la matrice de
diagnostics et les séries de sortie.

## Arguments

- dir:

  Chemin vers le dossier contenant les fichiers demetra_m.csv,
  series_y.csv, series_sa.csv, series_s.csv et series_t.csv.

- demetra_m:

  Un data.frame contenant la matrice de diagnostics. Si manquant ou
  `NULL`, le fichier est recherché dans `dir`.

- y:

  Un data.frame contenant la série initiale. Si manquant ou `NULL`, le
  fichier est recherché dans `dir`.

- sa:

  Un data.frame contenant la série CVS. Si manquant ou `NULL`, le
  fichier est recherché dans `dir`.

- s:

  Un data.frame contenant la composante saisonnière du modèle. Si
  manquant ou `NULL`, le fichier est recherché dans `dir`.

- t:

  Un data.frame contenant la composante de tendance du modèle. Si
  manquant ou `NULL`, le fichier est recherché dans `dir`.

- ...:

  Autres paramètres à passer à `read_demetra_m()` tels que `sep` (le
  séparateur utilisé dans le fichier CSV. Par défaut, `sep = ";"`) et
  `dec` (le séparateur décimal utilisé dans le fichier CSV. Par défaut,
  `dec = ","`).

## Value

Un objet de classe
[`JVS_matrix`](https://inseefr.github.io/rjd3qr/reference/JVS_matrix.md).

## Details

Cette fonction génère un rapport JVS à partir des outputs de JDemetra+.
Les sorties nécessaires sont la matrice de diagnostics demetra_m
(généralement issue du fichier *demetra_m.csv*) et les séries y, sa, s
et t (généralement lues depuis les fichiers CSV des séries).

Tous ces fichiers peuvent être générés en lançant le cruncher (fonctions
`cruncher_and_param`).

Pour plus d'informations sur la génération des sorties, voir la vignette
: `browseVignettes(package = "rjd3qr")`

Si les séries sont fournies, elles doivent être des `data.frame` avec
les dates dans la première colonne et les valeurs des séries dans les
autres colonnes.

Cette fonction retourne un objet de type
[`JVS_matrix`](https://inseefr.github.io/rjd3qr/reference/JVS_matrix.md),
qui est un `data.frame` contenant plusieurs indications sur l'ajustement
saisonnier de la série.

Si tous les data.frames (`demetra_m`, `y`, `sa`, `s` et `t`) sont
fournis, l'argument `dir` est ignoré. Sinon, `dir` doit pointer vers le
répertoire contenant les fichiers CSV correspondants.

## Examples

``` r
# Chemin menant au dossier contenant les fichiers d'output :
dir_path <- system.file(
    "extdata",
    "WS/WS_world/Output/SAProcessing-1",
    package = "rjd3qr"
)

# Extraction du rapport JVS :
JVS <- extract_JVS(dir = dir_path)
```
