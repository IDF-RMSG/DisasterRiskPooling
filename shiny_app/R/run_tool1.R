#' Run WB Tool 1 shiny app locally
#'
#' Use this function to run the Tool 1 shiny app on your local machine
#'
#' @import shiny
#'
#' @export
#' @examples
#' run_tool1()
run_tool1 <- function(){
  appDir <- system.file("shiny-app", "Tool1", package = "WBTool1")
  if (appDir == ""){
    stop("Could not find example directory. Try re-installing 'WBTool1'.", call. = FALSE)
  }
  shiny::runApp(appDir, display.mode = "normal")
}
 library(shiny)
 
 ui <- fluidPage(
   
 )
 
 server <- function(input, output, session) {
   
 }
 
 shinyApp(ui, server)
 
 