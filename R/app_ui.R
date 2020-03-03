#' @import shiny
app_ui <- function() {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # List the first level UI elements here 
    bulmaPage(
      title = "Freedom of Press Index",
      theme = "solar",
      bulmaHero(
        fullheight = TRUE,
        bulmaHeroBody(
          bulmaContainer(
            bulmaTitle("Freedom of Press Index"),
            bulmaSubtitle("Explore the index throughout the countries and the years.")
          )
        )
      ),
      bulmaSection(
        size = "large",
        bulmaColumns(
          bulmaColumn(
            width = 9,
            echarts4r::echarts4rOutput("trend")
          ),
          bulmaColumn(
            width = 3,
            uiOutput("country_select_generated"),
            br(),
            bulmaSelectInput("value", "Select metric", c("rank", "score")),
            br(),
            uiOutput("desc")
          )
        )
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
    golem::favicon()
    # Add here all the external resources
    # If you have a custom.css in the inst/app/www
    # Or for example, you can add shinyalert::useShinyalert() here
    #tags$link(rel="stylesheet", type="text/css", href="www/custom.css")
  )
}
