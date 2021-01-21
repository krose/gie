gie R Package
================

## gie

gie is an R package for wrapping the Gas Infrastructure Europe (GIE)
REST API.

## API Key

The official documentation from GIE can be found
[here](https://agsi.gie.eu/GIE_API_documentation_v003.pdf)

Before proceeding with the examples you need to get a token / API key
from the [GIE homepage](https://agsi.gie.eu/#/api). On the API page you
can lookup EIC codes for the companies and facilities.

Before proceeding with the examples you need to get a token / API key
from the GIE homepage. Save the token to a file you name “.Renviron” and
save the file to your working directory. If you end up saving the file
as .Renviron.txt or similar, you have made a mistake.

The .Renviron file content should look something like this:

    GIE_PAT = "<your-token>"

Before you proceed, you need to RESTART R. R reads the .Renviron file on
start-up, so to make sure everything works, you need to restart R.

You can also add the snippet below to the beginning of your script, but
the solution above is advised as it’s not good practice to add tokens to
your scripts.

    Sys.setenv(GIE_PAT = "<your-token>")

## EIC Codes

You can find the EIC codes here:

  - Gas: <https://agsi.gie.eu/#/api>
  - LNG: <https://alsi.gie.eu/#/api>

## Installation

Simply install from GitHub.

``` 

remotes::install_github("krose/gie")
```

## Usage

There are four functions. The paramters in the functions are
upper-/lower-case sensitive.

The first function gets the aggregated historical data for Europe or Non
Europe.

``` r
library(tidyverse)
library(gie)

ne_gas <- gie_gas_aggregate("ne")
eu_lng <- gie_lng_aggregate("eu")

glimpse(ne_gas)
```

    ## Observations: 3,672
    ## Variables: 11
    ## $ status             <chr> "C", "C", "C", "C", "C", "C", "C", "C", "C"...
    ## $ gasDayStartedOn    <date> 2021-01-19, 2021-01-18, 2021-01-17, 2021-0...
    ## $ gasInStorage       <dbl> 180.6985, 182.1949, 183.5723, 184.8516, 185...
    ## $ full               <dbl> 56.45, 56.91, 57.35, 57.75, 58.09, 58.41, 5...
    ## $ trend              <dbl> -0.47, -0.45, -0.40, -0.34, -0.32, -0.30, -...
    ## $ injection          <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0...
    ## $ withdrawal         <dbl> 1493.49, 1430.99, 1285.72, 1091.42, 1015.68...
    ## $ workingGasVolume   <dbl> 320.1275, 320.1475, 320.0759, 320.0759, 320...
    ## $ injectionCapacity  <dbl> 2351.31, 2347.99, 2344.32, 2341.70, 2340.91...
    ## $ withdrawalCapacity <dbl> 2093.48, 2105.99, 2115.39, 2124.21, 2130.90...
    ## $ info               <lgl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,...

``` r
glimpse(eu_lng)
```

    ## Observations: 3,308
    ## Variables: 7
    ## $ status          <chr> "E", "E", "E", "E", "E", "E", "E", "C", "C", "...
    ## $ gasDayStartedOn <date> 2021-01-19, 2021-01-18, 2021-01-17, 2021-01-1...
    ## $ lngInventory    <dbl> 4078.30, 4158.88, 4233.01, 4366.25, 4454.46, 4...
    ## $ sendOut         <dbl> 1571.2, 1761.7, 1597.1, 1653.7, 1791.9, 1814.6...
    ## $ dtmi            <dbl> 8990.24, 9215.24, 9215.24, 9215.24, 9215.24, 9...
    ## $ dtrs            <dbl> 6539.3, 6809.2, 6809.2, 6809.2, 6809.2, 6809.2...
    ## $ info            <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA...

The second function gets the aggregated historical data for a specific
country.

``` r
nl <- gie_gas_country("NL")
gb <- gie_lng_country("GB")
glimpse(nl)
```

    ## Observations: 3,672
    ## Variables: 11
    ## $ status             <chr> "E", "E", "E", "E", "E", "E", "E", "E", "E"...
    ## $ gasDayStartedOn    <date> 2021-01-19, 2021-01-18, 2021-01-17, 2021-0...
    ## $ gasInStorage       <dbl> 77.4202, 78.3812, 79.6650, 80.9170, 82.3222...
    ## $ full               <dbl> 53.84, 54.50, 55.40, 56.27, 57.25, 58.19, 5...
    ## $ trend              <dbl> -0.72, -0.89, -0.87, -0.98, -0.95, -0.85, -...
    ## $ injection          <dbl> 66.85, 66.85, 96.61, 66.85, 77.41, 40.83, 6...
    ## $ withdrawal         <dbl> 1100.69, 1348.62, 1348.38, 1471.86, 1443.12...
    ## $ workingGasVolume   <dbl> 143.8067, 143.8067, 143.8067, 143.8067, 143...
    ## $ injectionCapacity  <dbl> 1290.73, 1289.57, 1288.35, 1287.13, 1285.89...
    ## $ withdrawalCapacity <dbl> 2413.90, 2416.96, 2420.19, 2423.41, 2426.68...
    ## $ info               <lgl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,...

The third function gets the historical data for a specific company
wihtin a country. You can lookup the EIC codes from the API webpage.

``` r
eic_gas <- gie_gas_eic("AT", "25X-GSALLC-----E")
eic_lng <- gie_lng_eic("PL", "53XPL000000PLNG6")

glimpse(eic_gas)
```

    ## Observations: 2,082
    ## Variables: 11
    ## $ status             <chr> "C", "C", "C", "C", "C", "C", "C", "C", "C"...
    ## $ gasDayStartedOn    <date> 2021-01-19, 2021-01-18, 2021-01-17, 2021-0...
    ## $ gasInStorage       <dbl> 14.2159, 14.4120, 14.6172, 14.8221, 15.0268...
    ## $ full               <dbl> 66.68, 67.60, 68.56, 69.53, 70.49, 71.45, 7...
    ## $ trend              <dbl> -0.92, -0.96, -0.96, -0.96, -0.97, -0.91, -...
    ## $ injection          <dbl> 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0...
    ## $ withdrawal         <dbl> 196.11, 205.19, 204.97, 204.62, 205.81, 193...
    ## $ workingGasVolume   <dbl> 21.3189, 21.3189, 21.3189, 21.3189, 21.3189...
    ## $ injectionCapacity  <dbl> 184.66, 184.66, 184.66, 184.66, 184.66, 184...
    ## $ withdrawalCapacity <dbl> 208.98, 208.98, 208.98, 208.98, 208.98, 208...
    ## $ info               <lgl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,...

``` r
glimpse(eic_lng)
```

    ## Observations: 1,695
    ## Variables: 7
    ## $ status          <chr> "C", "C", "C", "C", "C", "C", "C", "C", "C", "...
    ## $ gasDayStartedOn <date> 2021-01-19, 2021-01-18, 2021-01-17, 2021-01-1...
    ## $ lngInventory    <dbl> 75.71, 85.36, 97.63, 109.56, 121.17, 133.28, 1...
    ## $ sendOut         <dbl> 55.0, 74.0, 75.0, 75.0, 75.0, 75.0, 75.0, 73.0...
    ## $ dtmi            <dbl> 320, 320, 320, 320, 320, 320, 320, 320, 320, 3...
    ## $ dtrs            <dbl> 162.8, 162.8, 162.8, 162.8, 162.8, 162.8, 162....
    ## $ info            <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA...

The last and fourth function gets the historical data for a specific
facility from a company wihtin a country. You can lookup the different
EIC codes from the API webpage.

``` r
eic_gas <- gie_gas_company_eic(country_code = "DE",
                       eic_code = "21W000000000100J",
                       eic_company_code = "21X000000001368W")
eic_lng <- gie_lng_company_eic(country_code = "IT",
                       eic_code = "59W0000000000011",
                       eic_company_code = "26X00000117915-0")
glimpse(eic_gas)
```

    ## Observations: 1,847
    ## Variables: 11
    ## $ status             <chr> "C", "C", "C", "C", "C", "C", "C", "C", "C"...
    ## $ gasDayStartedOn    <date> 2021-01-19, 2021-01-18, 2021-01-17, 2021-0...
    ## $ gasInStorage       <dbl> 1.7020, 1.7020, 1.7020, 1.7008, 1.7008, 1.7...
    ## $ full               <dbl> 77.89, 77.89, 77.89, 77.84, 77.84, 77.84, 7...
    ## $ trend              <dbl> 0.00, 0.00, 0.05, 0.00, 0.00, 0.00, 0.00, -...
    ## $ injection          <dbl> 0.0, 0.0, 1.2, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0...
    ## $ withdrawal         <dbl> 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 3...
    ## $ workingGasVolume   <dbl> 2.1851, 2.1851, 2.1851, 2.1851, 2.1851, 2.1...
    ## $ injectionCapacity  <dbl> 210.67, 210.67, 210.67, 210.67, 210.67, 210...
    ## $ withdrawalCapacity <dbl> 361.15, 361.15, 361.15, 361.15, 361.15, 361...
    ## $ info               <lgl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,...

``` r
glimpse(eic_lng)
```

    ## Observations: 3,308
    ## Variables: 7
    ## $ status          <chr> "C", "C", "C", "C", "C", "C", "C", "C", "C", "...
    ## $ gasDayStartedOn <date> 2021-01-19, 2021-01-18, 2021-01-17, 2021-01-1...
    ## $ lngInventory    <dbl> 10.23, 10.24, 10.26, 10.29, 10.30, 10.31, 10.3...
    ## $ sendOut         <dbl> 0.1, 0.1, 0.1, 0.1, 0.1, 0.2, 0.2, 0.2, 0.2, 0...
    ## $ dtmi            <dbl> 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40...
    ## $ dtrs            <dbl> 119.5, 119.5, 119.5, 119.5, 119.5, 119.5, 119....
    ## $ info            <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA...

## Future Development

If needed, params for ‘from’, ‘till’ and ‘limit’ can be implemented.
