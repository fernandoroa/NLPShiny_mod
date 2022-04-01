library(shiny.fluent)
library(shiny.router)
library(purrr)
library(shiny)
library(shiny.semantic)
library(shinyjs)
library(data.table)
library(leaflet)
library(DT)
library(mongolite)
library(dplyr)
library(maps)

if (file.exists("outfiles/cash_df.csv")) {
  file.remove("outfiles/cash_df.csv")
}

if (file.exists("outfiles/health_df.csv")) {
  file.remove("outfiles/health_df.csv")
}

source("helper/objects_NLP.R")
source("helper/functions_NLP.R")

source("mongo/mongo.R")
source("mongo/mongo_fun.R")

dataset_init <- basic_colombia()

source("modules/mod_map.R")
source("modules/mod_submit.R")
source("modules/mod_table.R")
source("modules/mod_unify.R")
source("modules/mod_tag.R")
source("modules/mod_services.R")
source("modules/mod_form.R")
source("modules/mod_plot.R")

source("layout/headers_footer.R")
source("layout/pages.R")
source("layout/sidebar.R")

#
# ui
#

router <- purrr::lift(make_router)(pages)

layout <- div(
  class = "grid-container",
  div(class = "header_left", header_left),
  div(class = "header_right", header_right),
  div(class = "sidenav", sidebar, id = "sidebar_id"),
  div(class = "main", router$ui),
  div(class = "footer", footer)
)

ui <- fluidPage(
  useShinyjs(),
  tags$head(
    tags$link(href = "style.css", rel = "stylesheet", type = "text/css"),
  ),
  shiny::tags$body(
    dir = "ltr",
    layout
  )
)

#
#   server
#

server <- function(input, output, session) {
  router$server(input, output, session)
  
  mod_plot_server("minimap")

  #
  #   inputs
  #

  vars_submit <- submit_server("mod_submit")

  #
  # tag
  #

  vars_tag <- tag_server("mod_tag", vars_unifier)

  #
  #   services
  #
  
  vars_cash <- servicetype_server("cash", vars_unifier, vars_submit)

  vars_health <- servicetype_server("health", vars_unifier, vars_submit)

  #
  #  gather and unify
  #

  vars_unifier <- unifier_server(
    "ns_unifier", dataset_init,
    vars_submit, vars_tag,
    vars_cash,
    vars_health
  )

  #
  #   map
  #

  mod_map_server("nsMap", dataset_init, idx, vars_unifier)

  #
  # table
  #

  table_server("mod_table", dataset_init, vars_unifier)

  #
  # form
  #

  form_server("mod_form", vars_unifier)

  observeEvent(input$button, {
    shinyjs::toggle("sidebar_id")
  })
}

shinyApp(ui, server)
