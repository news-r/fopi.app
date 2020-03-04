#' @import shiny
app_ui <- function() {

  options <- list(
    sectionsColor = c('#2f2f2f', '#2f2f2f', '#f9f7f1')
  )

  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # List the first level UI elements here 
    pagePiling(
      sections.color = c('#2f2f2f', '#2f2f2f', '#f9f7f1'),
      opts = options,
      menu = c(
        "Home" = "home",
        "Map" = "map",
        "Time series" = "ts"
      ),
      pageSectionImage(
        center = TRUE,
        img = "www/img/crowd.jpg",
        menu = "home",
        h1("Freedom of Press Index", class = "header shadow-dark"),
        h3("Visualisation", class = "header shadow-dark"),
        h4(
          class = "shadow-light",
          tags$a("The code", href = "https://github.com/news-r/fopi.app", target = "_blank", class = "link"),
          "|",
          tags$a("The API", href = "https://github.com/news-r/fopi", target = "_blank", class = "link")
        )
      ),
      pageSection(
        center = TRUE,
        menu = "map",
        h1("Map")
      ),
      pageSection(
        center = TRUE,
        menu = "ts",
        mod_ts_ui("ts")
      )
    )
  )
}

#' @import shiny
golem_add_external_resources <- function(){
  
  addResourcePath(
    'www', system.file('app/www', package = 'fopi.app')
  )
 
  tags$head(
    golem::activate_js(),
    golem::favicon(),
    tags$link(rel="stylesheet", type="text/css", href="www/css/style.css")
  )
}
