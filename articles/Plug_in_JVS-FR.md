# Plug-in JVS - FR

``` r

library("JDCruncheR")
#> 
#> Attaching package: 'JDCruncheR'
#> The following object is masked from 'package:base':
#> 
#>     write
```

## Introduction

This vignette explains how to create a JVS Quality Report with the
{JDCruncheR} package. This only works for v3.

## Definition of the JVS QR

Le plug-in JVS (Job Vacancy Survey) est un plug-in additionnel du
logiciel JDemetra+.

### Version 2

En version 2, il est disponible sur le GitHub
[Sace2015](https://github.com/Sace2015) :
<https://github.com/Sace2015/EurostatQR>. Vous trouverez la
[documentation du
plug-in](https://github.com/Sace2015/EurostatQR/raw/refs/heads/master/2018-10-26%20A%20PlugIn%20For%20Eurostat%20Job%20Vacancy%20Survey.docx)
sur ce même repo.

### Version 3

En version 3, le plug-in est hebergé sur le GitHub de
[jdemetra](https://github.com/jdemetra/), sur le repo
[jdplus-incubator](https://github.com/jdemetra/jdplus-incubator/). Pour
récupérer la dernière version, il faut aller dans la partie
[Releases](https://github.com/jdemetra/jdplus-incubator/releases), puis
télécharger le plug-in (nommé jdplus-eurostat-desktop-plugin).

### Dsecription

Le plug-in contient 30 colonnes :

- **Series** : le nom de la série
- **Method** : l’algorithme d’ajustement (Tramo-Seats ou X13) et la
  spécification
- **Period** : la fréquence de nos séries (12 pour mensuelle et 4 pour
  trimestrielle)
- **Nobs** : le nombre d’observation
- **Start** : la date de début de nos séries
- **End** : la date de fin de nos séries
- **Adjustment** : le type d’ajustement effectué (CVS, CJO ou CVS-CJO)
- **Presence of Seasonality in the Raw Series** : Y a t-il de la
  saisonnalité dans les séries brutes ?
- **Presence of TD effects** : Y a t-il des effets de calendrier dans
  les séries brute ?
- **Log-Transformation** : Les séries ont-elles été log-transformés
  (modèle additif ou multiplicatif) ?
- **ARIMA Model** : le modèle ARIMA du pré-ajustement
- **LeapYear** : Y a t-il présence d’un effet année bissextile ?
- **MovingHoliday** : Y a t-il présence d’un effet de Pâques ?
- **NbTD** : le nombre de régresseurs de calendrier
- **Noutliers** : le nombre d’outliers
- **Outlier1**, **Outlier2**, **Outlier3** : Les 3 outliers les plus
  importants
- **Residual Seasonality in SA Series (F-test)** : Présence de
  saisonnalité résiduelle dans les séries désaisonnalisées
- **Residual TD Effect** : Présence d’effet de calendrier dans les
  séries désaisonnalisées
- **Q-Stat (for X13)** : Statistique Q finale (pour les séries ajustées
  par X13)
- **Final Henderson Filter** : Longueur du filtre d’Henderson final
  (pour les séries ajustées par X13)
- **Stage 2 Henderson Filter** : Longueur du filtre d’Henderson utilisé
  dans l’estimation provisoire de la tendance cycle dans la table D10
  (pour les séries ajustées par X13)
- **Seasonal Filter** : Filtre saisonnier (pour les séries ajustées par
  X13)
- **Irregular Standard-Deviation** : Ecart type de la composante
  irrégulière (définie par $`SA - T`$)
- **Quality (for TS)** : Critère de qualité de JDemetra+
- **Max-Adj** : Indicateur de la taille de l’ajustement CVS et CJO

``` math
100 \times max(\left | \frac{Y_t - SA_t}{Y_t}\right |)
```

- **Autocorrelation of order 1 of the SA series** : Autocorrelation de
  la série ajustée
- **Normal Test (P-value)** : Test de normalité
- **Autocorrelation negative and significant** : Affichage d’un warning
  dans le cas d’autocorrelation négatives et significatives

## Création des sorties de JDemetra+

Pour créer un rapport de qualité JVS, vous devez utiliser le cruncher
JDemetra+ version 3. Tout d’abord, si vous n’avez pas encore téléchargé
le cruncher JDemetra+, vous pouvez le télécharger depuis GitHub :
<https://github.com/jdemetra/jdplus-main/releases>. Le fichier à
télécharger commence par “jwsacruncher-standalone”.

Pour lancer le cruncher, vous pouvez utiliser le package {rjwsacruncher}
avec des options spécifiques.

L’objectif de cette étape est de générer un fichier demetra_m contenant
de nombreuses informations sur les séries à étudier, ainsi que plusieurs
fichiers contenant les séries composantes (y, sa, s et t).

Pour générer ces fichiers, voici les options à utiliser :

``` r

library("rjwsacruncher")

options(
    is_cruncher_v3 = TRUE,
    default_matrix_item = c(
        "span.start",
        "span.end",
        "log",
        "span.n",
        "regression.nout",
        "regression.ntd",
        "m-statistics.m7",
        "decomposition.seasonal-filters",
        "decomposition.trend-filter",
        "decomposition.d7-trend-filter",
        "quality.summary",
        "regression.lp",
        "regression.leaster",
        "diagnostics.seas-sa-ac1:3",
        "diagnostics.seas-sa-ac1",
        "diagnostics.seas-lin-combined",
        "regression.out(*)",
        "regression.td-ftest:3",
        "residuals.lb:3",
        "diagnostics.td-sa-last:2",
        "diagnostics.seas-sa-f:2",
        "arima.p", "arima.d", "arima.q", "arima.bp", "arima.bd", "arima.bq",
        "m-statistics.q", "m-statistics.q-m2"
    ),
    default_tsmatrix_series = c(
        "decomposition.y_cmp",
        "decomposition.s_cmp",
        "decomposition.sa_cmp",
        "decomposition.t_cmp"
    )
)

cruncher_and_param(
    workspace = "path/to/the/workspace/file.xml",
    cruncher_bin_directory = "path/to/the/cruncher/v3/bin/directory",
    csv_layout = "vtable",
    short_column_headers = FALSE,
    refreshall = FALSE,
    v3 = TRUE,
    delete_existing_file = TRUE,
    policy = "None"
)
```

Après avoir lancé ce code là, vous devriez avoir généré 5 fichiers.

## Creation du rapport JVS

Uns fois le cruncher lancé et les outputs générés, on peut créer notre
rapport JVS :

``` r

# Chemin menant au dossier contenant les fichiers CSV
dir_path <- system.file(
    "extdata",
    "WS/WS_world/Output/SAProcessing-1",
    package = "JDCruncheR"
)

JVS <- extract_JVS(dir = dir_path)
```

| Series                    | Method | Period | Nobs | Start      | End        | Adjustment |
|:--------------------------|:-------|-------:|-----:|:-----------|:-----------|:-----------|
| Siachen Glacier (frozen)  | X13    |     12 |  300 | 2000-01-01 | 2024-12-01 | SCA        |
| Nagorno-Karabakh (frozen) | X13    |     12 |  300 | 2000-01-01 | 2024-12-01 | SA         |
| Mongolia (frozen)         | X13    |     12 |  300 | 2000-01-01 | 2024-12-01 | SA         |
| India (frozen)            | X13    |     12 |  300 | 2000-01-01 | 2024-12-01 | SCA        |
| Nepal (frozen)            | X13    |     12 |  300 | 2000-01-01 | 2024-12-01 | SA         |
| Philippines (frozen)      | X13    |     12 |  300 | 2000-01-01 | 2024-12-01 | SA         |

L’objet JVS est un dataframe contenant notre rapport JVS. pour
l’enregistrer il faut l’écrire dans un fichier.

## Export

Pour exporter le rapport de qualité JVS, vous devez utiliser la fonction
`write`. Le rapport peut être exporté sous forme de fichier .csv :

``` r

write(JVS, format = "csv", export_dir = "chemin/vers/le/répertoire/d'export", overwrite = TRUE)
```

Le rapport peut être exporté sous forme de fichier .xlsx :

``` r

write(JVS, format = "xlsx", export_dir = "chemin/vers/le/répertoire/d'export", overwrite = TRUE)
```

## Comparaison : v3 / R

### X

Dans R, cette colonne s’appelle “Series”.

### Method

Dans R, les noms des spécifications sont simplement “X13” ou
“Tramo-Seats”, car aucune précision n’est donnée quant au type de
spécification dans l’output du cruncher.

### Period, nobs, Start

Aucune différence.

### End

Dans la version 3, les dates correspondent au dernier jour de la
période, tandis que dans R, elles correspondent au premier jour de la
période.

### Adjustment

Aucune différence.

### Tests

Pour les tests :

- Presence of Seasonality in the RAW Series
- Presence of TD effects
- Residual Seasonality in SA Series F-test
- Residual TD Effect

Très légères différences dues à des seuils différents entre l’interface
et le cruncher.

### Log transformation, ARIMA Model, Leapyear, MovingHoliday, NbTD, Noutliers, Outlier1, Outlier2, Outlier3, Q-stat for X13, Stage 2 Henderson Filter, Final Henderson Filter, Seasonal.Filter

Aucune différence.

### Irregular Standard Deviation

Il existe de légères différences entre la version v3 (qui utilise le
nombre correct de degrés de liberté) et le code R, qui utilise `df = 1`
(par défault avec la fonction
[`sd()`](https://rdrr.io/r/stats/sd.html)). Dans les prochaines versions
du plug-in JVS, les résultats seront identiques entre la version R et la
verions de jdplus-incubator.

### Quality for TS, Max adj, Autocorrelation of order 1 of the SA series

Aucune différence.

### Normal test

Le test est effectué à l’aide de R de base et peut présenter de légères
différences (de l’ordre de 10\*\*4).

### Negative and significant autocorrelation

Aucune différence.
