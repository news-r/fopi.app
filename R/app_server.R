#' @import shiny
app_server <- function(input, output, session) {
  utils::data("fopi", package = "fopi")

  echarts4r::e_common(
    font_family = "Playfair Display",
    theme = "vintage"
  )

  callModule(mod_ts_server, "ts")

}
