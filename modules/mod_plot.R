#
#   Map module
#

#
#   UI, leaflet map output
#

mod_plot_ui <- function(id) {
  ns <- NS(id)
  plotOutput(ns("minimap_plot"), height=180 )
}

#
#   Server
#

mod_plot_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    output$minimap_plot <- renderPlot({
      par(mar=rep(0,4))
      maps::map('world', xlim = c(-20, 55), ylim=c(-34,40))
    })
})}
