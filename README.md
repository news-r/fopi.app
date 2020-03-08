
# fopi.app

<img src="./inst/logo/logo.png" align="right" height = 250>

<!-- badges: start -->
[![Build status](https://ci.appveyor.com/api/projects/status/ag7d9c622s5sq9ee?svg=true)](https://ci.appveyor.com/project/JohnCoene/fopi-app)
<!-- badges: end -->

An application to visualise the Freedom of Press Index, a deployed version is accessible at: [app.news-r.org/app/fopi-app](https://app.news-r.org/app/fopi-app)

## Docker

Pull the public image and run it.

```r
docker pull jcoenep/fopiapp
docker run --rm -p 3000:3838 jcoenep/fopiapp
```

Then visit `http://localhost:3000/`.

## R

Install the package from Github.

``` r
# install.packages("remotes")
remotes::install_github("news-r/fopi.app")
```

Run the app.

``` r
fopi.app::run_fopi()
```

