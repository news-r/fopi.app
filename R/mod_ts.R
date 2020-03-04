# Module UI
  
#' @title   mod_ts_ui and mod_ts_server
#' @description  A shiny Module.
#'
#' @param id shiny id
#' @param input internal
#' @param output internal
#' @param session internal
#'
#' @rdname mod_ts
#'
#' @keywords internal
#' @export 
#' @importFrom shiny NS tagList 
mod_ts_ui <- function(id){
  ns <- NS(id)
  pageContainer(
    pageRow(
      pageColumn(
        uiOutput(ns("country_select_generated"))
      ),
      pageColumn(radioButtons(ns("value"), "Metric", choices = c("rank", "score")), inline = TRUE)
    ),
    echarts4r::echarts4rOutput(ns("trend"))
  )
}
    
# Module Server
    
#' @rdname mod_ts
#' @export
#' @keywords internal
    
mod_ts_server <- function(input, output, session){
  ns <- session$ns

output$country_select_generated <- renderUI({
    cns <- fopi %>% 
      dplyr::arrange(country) %>% 
      dplyr::distinct(country) %>% 
      dplyr::pull(country)

    selectInput(
      ns("country_select"),
      "Select a country",
      choices = cns,
      selected = sample(cns, 1)
    )
  })

  output$trend <- echarts4r::renderEcharts4r({
    req(input$country_select)

    fopi %>% 
      dplyr::mutate(year = as.character(year)) %>% 
      dplyr::arrange(year) %>% 
      dplyr::filter(country == input$country_select) %>% 
      echarts4r::e_charts(year, dispose = FALSE) %>% 
      echarts4r::e_line_(input$value) %>% 
      echarts4r::e_legend(FALSE) %>% 
      echarts4r::e_tooltip(trigger = "axis") %>% 
      echarts4r::e_y_axis(inverse = TRUE)
  })

  output$desc <- renderUI({

    if(input$value == "rank")
      msg <- div(
        "Rank is inverted, the lower the rank the better the country performs",
        "on the index: the freeier the press in said country."
      )
    else 
      msg <- div(
        "The score on the index itself, the lower the better. In 2012, the score could be negative." 
      )

    msg
  })
}
