#' @import shiny
app_server <- function(input, output, session) {
  utils::data("fopi", package = "fopi")

  echarts4r::e_common(
    theme = "vintage"
  )

  output$country_select_generated <- renderUI({
    cns <- fopi %>% 
      dplyr::arrange(country) %>% 
      dplyr::distinct(country) %>% 
      dplyr::pull(country)

    bulmaSelectInput(
      "country_select",
      "Select a country",
      choices = cns
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
