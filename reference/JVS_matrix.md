# JVS matrix object

`JVS_matrix()` are creating a quality report based on the Eurostat JVS
Plug-In.

## Usage

``` r
JVS_matrix(x = list())

# S3 method for class 'data.frame'
JVS_matrix(x)

# S3 method for class 'JVS_matrix'
JVS_matrix(x)

# Default S3 method
JVS_matrix(x)
```

## Arguments

- x:

  a `data.frame` containing the output variables' values (test p-values,
  test statistics, etc.) and modalities (Yes/No).

## Value

`JVS_matrix()` creates and returns a `JVS_matrix` object.

## Details

A`JVS_matrix` object is a data.frame with 30 items:

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

## See also

[Traduction
française](https://inseefr.github.io/rjd3qr/reference/fr-JVS_matrix.md)

## Examples

``` r
JVS_data <- data.frame(
    Series = "Series 1",
    Method = "X13",
    Period = 12L,
    Nobs = 300L,
    Start = "2000-01-01",
    End = "2024-12-01",
    Adjustment = "SA",
    `Presence of Seasonality in the Raw Series` = "Yes",
    `Presence of TD effects` = "No",
    `Log-Transformation` = "No",
    `ARIMA Model` = "(0,1,1)(0,1,1)",
    LeapYear = "Yes",
    MovingHoliday = "No",
    NbTD = 0L,
    Noutliers = 1L,
    Outlier1 = "AO (2020-01)",
    Outlier2 = "AO (2018-11)",
    Outlier3 = NA_character_,
    `Residual Seasonality in SA Series (F-test)` = "No",
    `Residual TD Effect` = "No",
    `Q-Stat (for X13)` = "Good",
    `Final Henderson Filter` = "H13",
    `Stage 2 Henderson Filter` = "H13",
    `Seasonal Filter` = "S3X5",
    Quality = "Good",
    `Autocorrelation of order 1 of the SA series` = 0.2,
    `Ljung-Box Test (P-value)` = 0.8,
    `Autocorrelation negative and significant` = "",
    `Irregular Standard-Deviation` = 0.8,
    `Max-Adj` = 2.5
)

# Create a JVS_matrix object
JVS <- JVS_matrix(JVS_data)

# Check the class of the object
class(JVS)
#> [1] "JVS_matrix" "data.frame"
```
