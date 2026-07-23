# Ecriture de bilans qualités dans des fichiers

Ecriture de bilans qualités dans des fichiers

## Arguments

- x:

  un objet
  [`JVS_matrix`](https://inseefr.github.io/rjd3qr/reference/JVS_matrix.md),
  [`QR_matrix`](https://inseefr.github.io/rjd3qr/reference/QR_matrix.md)
  ou
  [`mQR_matrix`](https://inseefr.github.io/rjd3qr/reference/QR_matrix.md)

- ...:

  d'autres paramètres utilisées par les fonctions
  [`write.QR_matrix`](https://inseefr.github.io/rjd3qr/reference/write.QR_matrix.md)
  ou
  [`write.JVS_matrix`](https://inseefr.github.io/rjd3qr/reference/write.JVS_matrix.md).

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
