#
#   Map module
#

#
#   UI, leaflet map output
#

mod_map_ui <- function(id) {
  ns <- NS(id)
  leafletOutput(ns("map")) # , height=400 )
}

#
#   Server
#

#' @param consensusSel      dataset processed by mod. unifier
#' @param varsTable,        input from DT, to get row clicked. mod. Table
#' @param varsCountry    , get coordinates of selected country. mod. Country

mod_map_server <- function(id, dataset_init, idx, vars_unifier) {
  moduleServer(id, function(input, output, session) {
    output$map <- renderLeaflet({
      center_init <- "Cundinamarca"

      types_in_dataset <- sort(unique(dataset_init$service_type))

      idx <- sapply(
        types_in_dataset,
        function(x) {
          grep(x,
            ser_list[[1]],
            ignore.case = TRUE
          )
        }
      )

      filtered_service <- ser_list[[1]][idx]

      filter_color <- color_list12[idx]

      pal <- colorFactor(
        palette = filter_color,
        filtered_service
      )

      js_functions2 <- js_functions[idx]

      lng1 <- col_states_coord[which(col_states_coord$state %in% center_init), ]$lng
      lat1 <- col_states_coord[which(col_states_coord$state %in% center_init), ]$lat

      build_map(dataset_init, lng1, lat1, js_functions2, pal)
    }) # output map

    #####################################
    #
    #   MAP updater / observer of buttons
    #
    ####################################

    observeEvent(vars_unifier$dataset(),
      ignoreInit = T,
      {
        output$map <- renderLeaflet({
          validate(
            need(
              try(inherits(vars_unifier$dataset(), "data.frame")), ""
            )
          )

          #

          dataset <- vars_unifier$dataset()

          types_in_dataset <- sort(unique(dataset$service_type))

          idx <- sapply(
            types_in_dataset,
            function(x) {
              grep(x,
                ser_list[[as.numeric(vars_unifier$region())]],
                ignore.case = TRUE
              )
            }
          )

          filtered_colors <- color_list12[idx]

          filtered_service <- ser_list[[as.numeric(vars_unifier$region())]][idx]

          js_functions2 <- js_functions[idx]

          pal <- colorFactor(
            palette = filtered_colors,
            filtered_service
          )
          #

          build_map(dataset, vars_unifier$lng(), vars_unifier$lat(), js_functions2, pal)
        }) # map output
      }
    ) # observeEvent
  })
}
