# Objets de classe JVS_matrix

Un objet
[`JVS_matrix()`](https://inseefr.github.io/rjd3qr/reference/JVS_matrix.md)
est créé d'après le modèle du plug-in d'Eurostat JVS.

## Arguments

- x:

  un `data.frame` contenant les résultats des tests(p-values,
  statistiques, etc.) et des modalitéss (Yes/No) en cas de présence
  d'une variable ou d'un indicateur.

## Value

[`JVS_matrix()`](https://inseefr.github.io/rjd3qr/reference/JVS_matrix.md)
renvoie un objet de classe
[`JVS_matrix`](https://inseefr.github.io/rjd3qr/reference/JVS_matrix.md).

## Details

Un objet de classe
[`JVS_matrix`](https://inseefr.github.io/rjd3qr/reference/JVS_matrix.md)
est un data.frame avec 30 colonnes :

- Series

- Method

- Period

- Nobs

- Start

- End

- Adjustment

- Presence of Seasonality in the Raw Series

- Presence of TD effects

- Log-Transformation

- ARIMA Model

- LeapYear

- MovingHoliday

- NbTD

- Noutliers

- Outlier1

- Outlier2

- Outlier3

- Residual Seasonality in SA Series (F-test)

- Residual TD Effect

- Q-Stat (for X13)

- Final Henderson Filter

- Stage 2 Henderson Filter

- Seasonal Filter

- Quality

- Autocorrelation of order 1 of the SA series

- Ljung-Box Test (P-value)

- Autocorrelation negative and significant

- Irregular Standard-Deviation

- Max-Adj
