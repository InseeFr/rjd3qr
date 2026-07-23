# Définir les valeurs des seuils

Définir les valeurs des seuils

## Arguments

- test_name:

  Chaîne de caractères. Le nom du test à mettre à jour.

- thresholds:

  Vecteur numérique nommé. Les valeurs supérieures de chaque seuil d'un
  test.

## Value

Renvoie de manière invisible la liste de tous les seuils actuellement en
vigueur (donc mis à jour). C'est une liste d'item avec les différentes
modalités ("Good", "Uncertain", "Bad", "Severe", "Poor"...) et leur
seuils associés.

## Details

Si `test_name` est manquant, l'argument `thresholds` n'est pas utilisé
et tous les seuils seront réinitialisés à leurs valeurs par défaut.

Si `test_name` est fourni mais que l'argument `thresholds` est manquant,
seuls les seuils du test `test_name` seront réinitialisés à leurs
valeurs par défaut.

Enfin, si `test_name` et `thresholds` sont tous deux fournis, seuls les
seuils du test `test_name` seront mis à jour avec les valeurs spécifiées
dans `thresholds`.

## Examples

``` r

# Définir les seuils pour le test "m7"
set_thresholds(
    test_name = "m7",
    thresholds = c(Bon = 0.8, Mauvais = 1.4, Sévère = Inf)
)

# Réinitialiser les seuils du test "oos_mean" à leurs valeurs par défaut
set_thresholds(test_name = "oos_mean")

# Réinitialiser tous les seuils à leurs valeurs par défaut
set_thresholds()
```
