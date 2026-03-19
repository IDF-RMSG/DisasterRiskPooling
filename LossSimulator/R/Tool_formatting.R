#
#' tab_maker
#'
#' Function for conditional colouring, etc. in the tab panel headers.
#' @param n Tab number.
#' @param label Tab name.
#' @param input Tab inputs.
#' @param tab_data Tab data.
#'
#' @return UIs for panel headers.
#' @export
#'
#' @examples
#' output$tool_settings_ui <- renderUI({
#' tab_maker(n = 1, label = 'DATA SELECTION',
#'           input = input,
#'           tab_data = tab_data)
#' })
#' output$data_ui <- renderUI({
#'   tab_maker(n = 2, label = 'DATA MANIPULATION',
#'             input = input,
#'             tab_data = tab_data)
#' })
#' output$input_ui <- renderUI({
#'   tab_maker(n = 3, label = 'SIMULATIONS',
#'             input = input,
#'             tab_data = tab_data)
#' })
tab_maker <- function(n = 1,
                      label = 'DATA SELECTION',
                      input,
                      tab_data){
  label_n <- n
  # Get tab info
  tab_name <- input$tabs
  td <- tab_data$data
  tab_number <- td %>% filter(name == tab_name) %>% .$number
  the_text <- '&#10004;'
  if(tab_number >=n){
    the_color <- '#ff0000'
    the_circle <- 'circle'
  } else {
    the_color <- '#ff0000'
    the_circle <- 'greycircle'
  }
  if(tab_number <= n){
    the_text <- label_n
  }
  HTML(paste0('
    <div style="width: 100%; margin: 0 auto; text-align: center">
    <div class="', the_circle, '">', the_text, '</div>
    <h4 style = "width: 100%; color: ', the_color, '; margin: 0 auto; text-align: center">', label, '</h4>
    </div>'))
}
