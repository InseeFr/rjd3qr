# Plug-in JVS - EN

``` r

library("rjd3qr")
#> 
#> Attaching package: 'rjd3qr'
#> The following object is masked from 'package:base':
#> 
#>     write
```

## Introduction

This vignette explains how to create a JVS Quality Report with the
{rjd3qr} package. This only works for v3.

## Definition of the JVS QR

The JVS (Job Vacancy Survey) plug-in is an add-on for the JDemetra+
software.

### Version 2

Version 2 is available on GitHub
[Sace2015](https://github.com/Sace2015):
<https://github.com/Sace2015/EurostatQR>. You will find the [plug-in
documentation](https://github.com/Sace2015/EurostatQR/raw/refs/heads/master/2018-10-26%20A%20PlugIn%20For%20Eurostat%20Job%20Vacancy%20Survey.docx)
on the same repository.

### Version 3

In version 3, the plug-in is hosted on
[jdemetra](https://github.com/jdemetra/)’s GitHub, in the
[jdplus-incubator](https://github.com/jdemetra/jdplus-incubator/)
repository. To download the latest version, go to the
[Releases](https://github.com/jdemetra/jdplus-incubator/releases)
section, then download the plug-in (named
jdplus-eurostat-desktop-plugin).

### Description

The plug-in contains 30 columns:

- **Series**: Name of the series
- **Method**: Seasonal adjustment method used (Tramo-Seats or X13) and
  the specification
- **Period**: Periodicity of the series (12 for monthly and 4 for
  quarterly)
- **Nobs**: Number of observations
- **Start**: Starting date
- **End**: Ending date
- **Adjustment**: Kind of adjustment performed: NSA(non seasonally and
  calendar adjusted), CA (calendar adjusted) or SCA (seasonally and
  calendar adjusted)
- **Presence of Seasonality in the Raw Series**: Result (Yes, No,
  Uncertain) of a a combined test based on 3 tests: the Fisher test, the
  Kruskal-Wallis test and the Ljung-Box test.
- **Presence of TD effects**: Result (Yes or No) of the JD+ Fisher joint
  test.
- **Log-Transformation**: Decomposition model. If “Yes”: A logarithmic
  transformation is done by Tramo-Seats for the complete adjustment; A
  logarithmic transformation is done by X13 for the Reg-Arima part and a
  multiplicative model is used for the decomposition per se.
- **ARIMA Model**: Orders (p,d,q)(P,D,Q) of the ARIMA model
- **LeapYear**: Presence of a Leap Year effect (Yes or No)
- **MovingHoliday**: Presence of an Easter effect (Yes or No)
- **NbTD**: Number of trading-day regressors (including the Leap Year
  regressor)
- **Noutliers**: Total number of outliers
- **Outlier1**, **Outlier2**, **Outlier3**: The 3 main outliers. The
  importance is measured by the absolute value of the t-statistic
  associated with the outlier.
- **Residual Seasonality in SA Series (F-test)**: Presence of residual
  seasonality in the SCA series. The test used here is a Fisher test.
  The test is done at the 5% level.
- **Residual TD Effect**: Presence of residual trading-day effect in the
  SCA series. The test used here is a Fisher test based on the default
  Gregorian trading-day regressors. The test is done at the 5% level.
- **Q-Stat (for X13)**: Final Q statistics (available for X13 only)
- **Final Henderson Filter**: Length of the Henderson filter used in the
  final estimation of the trend-cycle in table D12 (available for X13
  only).
- **Stage 2 Henderson Filter**: Length of the Henderson filter used in
  the provisional estimation of the trend-cycle in table D6 (available
  for X13 only).
- **Seasonal Filter**: Seasonal filter used in the final estimation of
  the seasonal component in table D10 (available for X13-adjusted
  series).
- **Irregular Standard-Deviation**: Standard deviation of the irregular
  defined as (SA - Trend)
- **Quality (for TS)**: JDemetra+ global quality assessment
- **Max-Adj**: Indicator of the “size” of the seasonal and calendar
  adjustment.

``` math
100 \times max(\left | \frac{Y_t - SA_t}{Y_t}\right |)
```

- **Autocorrelation of order 1 of the SA series**: Reports the
  autocorrelation of order 1 of the series $`SA_t - SA_{t-1}`$
- **Normality test (P-value)**: P-value of the Normal test to check if
  the autocorrelation is significant.
- **Negative and significant autocorrelation**: A warning is issued when
  the autocorrelation is negative and significant.

## Creation of the output files

To create a JVS Quality Report, you need to use the JDemetra+ cruncher
in version 3. First, if you do not have downloaded the JDemetra+
cruncher, you can download it from GitHub :
<https://github.com/jdemetra/jdplus-main/releases>. The file you should
download starts with “jwsacruncher-standalone”.

To call the cruncher, you can use the {rjwsacruncher} package with
specific options.

The goal of this step is to generate a demetra_m file containing a lot
of informations on series to study, and also several files containing
the components of the series.

To generate those files, you need to use the cruncher with the following
options:

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
    default_tsmatrix_series = c("y", "s", "sa", "t")
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

At this step, you should have generated 5 files.

## Creation of report JVS

Once the cruncher has generated the correct outputs, the JVS Quality
Report can be generated.

``` r

# Path leading to the directory containing the needed files
dir_path <- system.file(
    "extdata",
    "WS/WS_world/Output/SAProcessing-1",
    package = "rjd3qr"
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

The JVS object is a dataframe containing the quality report. To save it,
you need to export it.

## Export

To export the JVS Quality Report, you need to use the writing function.
The report can be exported as a .csv file:

``` r

write(JVS, file = "path/to/the/export/directory", overwrite = TRUE)
```

By default, the file is names “JobVacancySurveyQR.csv”. To change it,
you can specify a name in the path of the `file` argument:

``` r

write(JVS, file = "path/to/the/export/directory/file_name.csv", overwrite = TRUE)
```

The report can also be exported as a .xlsx file. In this case, it is
necessary to specify it in the `file` argument:

``` r

write(JVS, file = "path/to/the/export/directory/file_name.xlsx", overwrite = TRUE)
```

## Comparison: v3 / R

### X

The column is called “Series” in R.

### Method

The names of the specifications are simply “X13” or “Tramo-Seats” in R,
as there is no detail regarding the type of specification.

### Period, nobs, Start

No differences.

### End

In v3, the dates correspond to the last day of the period, whereas in R
they correspond to the first day.

### Adjustment

No differences.

### Tests

For the tests:

- Presence of Seasonality in the RAW Series
- Presence of TD effects
- Residual Seasonality in SA Series F-test
- Residual TD Effect
- Quality for TS

Very slight differences due to different thresholds between the
interface and the cruncher.

### Log transformation, ARIMA Model, Leapyear, MovingHoliday, NbTD, Noutliers, Outlier1, Outlier2, Outlier3, Q-stat for X13, Stage 2 Henderson Filter, Final Henderson Filter, Seasonal.Filter, Irregular Standard Deviation, Max adj, Autocorrelation of order 1 of the SA series, Normal test, Negative and significant autocorrelation

No differences.
