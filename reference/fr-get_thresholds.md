# Obtenir tous les seuils (par défaut)

Obtenir tous les seuils (par défaut)

## Arguments

- test_name:

  Chaîne de caractères. Le nom du test pour lequel obtenir les seuils.

- default:

  Booléen. (par défaut, TRUE) Si TRUE, les seuils par défaut seront
  retournés. Si FALSE, les seuils actuellement utilisés seront
  retournés.

## Value

Renvoie de manière invisible les seuils de `test_name`. Si `test_name`
est manquant, la fonction retourne tous les seuils.

## Details

Si `test_name` est manquant, tous les seuils seront retournés.

## Examples

``` r

# Obtenir tous les seuils par défaut
get_thresholds(default = TRUE)
#> $qs_residual_s_on_sa
#>    Severe       Bad Uncertain      Good 
#>     0.001     0.010     0.050       Inf 
#> 
#> $qs_residual_sa_on_i
#>    Severe       Bad Uncertain      Good 
#>     0.001     0.010     0.050       Inf 
#> 
#> $f_residual_s_on_sa
#>    Severe       Bad Uncertain      Good 
#>     0.001     0.010     0.050       Inf 
#> 
#> $f_residual_sa_on_i
#>    Severe       Bad Uncertain      Good 
#>     0.001     0.010     0.050       Inf 
#> 
#> $f_residual_td_on_sa
#>    Severe       Bad Uncertain      Good 
#>     0.001     0.010     0.050       Inf 
#> 
#> $f_residual_td_on_i
#>    Severe       Bad Uncertain      Good 
#>     0.001     0.010     0.050       Inf 
#> 
#> $residuals_independency
#>       Bad Uncertain      Good 
#>      0.01      0.10       Inf 
#> 
#> $residuals_homoskedasticity
#>       Bad Uncertain      Good 
#>      0.01      0.10       Inf 
#> 
#> $residuals_skewness
#>       Bad Uncertain      Good 
#>      0.01      0.10       Inf 
#> 
#> $residuals_kurtosis
#>       Bad Uncertain      Good 
#>      0.01      0.10       Inf 
#> 
#> $residuals_normality
#>       Bad Uncertain      Good 
#>      0.01      0.10       Inf 
#> 
#> $oos_mean
#>       Bad Uncertain      Good 
#>      0.01      0.10       Inf 
#> 
#> $oos_mse
#>       Bad Uncertain      Good 
#>      0.01      0.10       Inf 
#> 
#> $m7
#>   Good    Bad Severe 
#>      1      2    Inf 
#> 
#> $q
#> Good  Bad 
#>    1  Inf 
#> 
#> $q_m2
#> Good  Bad 
#>    1  Inf 
#> 
#> $pct_outliers
#>      Good Uncertain       Bad 
#>         3         5       Inf 
#> 
#> $grade
#>      Good Uncertain       Bad    Severe 
#>         0         1         3         5 
#> 

# Obtenir tous les seuils actuellement utilisés
get_thresholds(default = FALSE)
#> $qs_residual_s_on_sa
#>    Severe       Bad Uncertain      Good 
#>     0.001     0.010     0.050       Inf 
#> 
#> $qs_residual_sa_on_i
#>    Severe       Bad Uncertain      Good 
#>     0.001     0.010     0.050       Inf 
#> 
#> $f_residual_s_on_sa
#>    Severe       Bad Uncertain      Good 
#>     0.001     0.010     0.050       Inf 
#> 
#> $f_residual_sa_on_i
#>    Severe       Bad Uncertain      Good 
#>     0.001     0.010     0.050       Inf 
#> 
#> $f_residual_td_on_sa
#>    Severe       Bad Uncertain      Good 
#>     0.001     0.010     0.050       Inf 
#> 
#> $f_residual_td_on_i
#>    Severe       Bad Uncertain      Good 
#>     0.001     0.010     0.050       Inf 
#> 
#> $residuals_independency
#>       Bad Uncertain      Good 
#>      0.01      0.10       Inf 
#> 
#> $residuals_homoskedasticity
#>       Bad Uncertain      Good 
#>      0.01      0.10       Inf 
#> 
#> $residuals_skewness
#>       Bad Uncertain      Good 
#>      0.01      0.10       Inf 
#> 
#> $residuals_kurtosis
#>       Bad Uncertain      Good 
#>      0.01      0.10       Inf 
#> 
#> $residuals_normality
#>       Bad Uncertain      Good 
#>      0.01      0.10       Inf 
#> 
#> $oos_mean
#>       Bad Uncertain      Good 
#>      0.01      0.10       Inf 
#> 
#> $oos_mse
#>       Bad Uncertain      Good 
#>      0.01      0.10       Inf 
#> 
#> $m7
#>   Good    Bad Severe 
#>      1      2    Inf 
#> 
#> $q
#> Good  Bad 
#>    1  Inf 
#> 
#> $q_m2
#> Good  Bad 
#>    1  Inf 
#> 
#> $pct_outliers
#>      Good Uncertain       Bad 
#>         3         5       Inf 
#> 
#> $grade
#>      Good Uncertain       Bad    Severe 
#>         0         1         3         5 
#> 

# Obtenir les seuils actuellement utilisés pour le test "oos_mean"
get_thresholds(test_name = "oos_mean", default = FALSE)
#>       Bad Uncertain      Good 
#>      0.01      0.10       Inf 
```
