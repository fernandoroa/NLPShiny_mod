#
# table module
#

#' @description module to allow choosing a data.frame name and its feedback from
#' same module different namespace
#' @param
#' @param
#' module namespace, see return, used for feedback
#' @return list with data.frame name (string) selected

table_ui <- function(id) {
  ns <- NS(id)
  DT::dataTableOutput(ns("mytable"))
}

###########################################
#
#   initial table static, starting app
#
###########################################

table_server <- function(id, dataset_init, vars_unifier) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns

    ######################
    #
    #  DT table function
    #
    ######################

    make_table <- function(dataset_init, filtered_cols,
                           loc_u, dontwrap_cols_filt,
                           filtered_cols_sp, new_names) {
      DT::datatable(dataset_init[, filtered_cols],
        colnames = new_names,
        rownames = F,
        extensions = c("Scroller", "ColReorder"), # c('Responsive', 'ColReorder'),
        options = list(
          "pageLength" = 5,
          dom = "ftipR",
          scrollX = TRUE,
          scrollY = TRUE,
          columnDefs = list(list(
            targets = loc_u,
            render = JS("function(data, type, row, meta) {", "return type === 'display' && data.length > 15 ?", "'<span title=\"' + data + '\">' + data.substr(0, 8) + '...</span>' : data;", "}")
          ))
        ) # op
      ) %>%
        formatStyle(dontwrap_cols_filt, "white-space" = "pre") %>%
        formatStyle(columns = filtered_cols_sp, `font-size` = "12px") %>%
        formatRound(columns = c("lat", "lng"), digits = 2)
    }


    output$mytable <- DT::renderDataTable({
      validate(
        need(
          try(inherits(dataset_init, "data.frame")),
          ""
        )
      )

      showModal(modalDialog(
        title = "Making table, please wait",
        "this pop-up will close after completion. Press ESC to wait in shiny app",
        easyClose = TRUE,
        footer = modalButton("Wait in shiny app")
      ))

      extant_cols <- colnames(dataset_init)

      if ("service_point_name" %in% extant_cols) {
        extant_cols_filt <- c(setdiff(extant_cols, "service_point_name"), "Service Point")
      } else {
        extant_cols_filt <- extant_cols
      }

      if ("location_name" %in% extant_cols) {
        extant_cols_filt <- c(setdiff(extant_cols_filt, "location_name"), "location")
      } else {
        extant_cols_filt <- extant_cols_filt
      }

      dontwrap_cols_filt <- intersect(dontwrap_cols, extant_cols_filt)

      first_cols_filt <- intersect(first_cols, extant_cols)

      filtered_cols <- intersect(
        c(
          first_cols_filt,
          setdiff(extant_cols, first_cols_filt)
        ),
        colnames(dataset_init)
      )

      if ("service_point_name" %in% filtered_cols) {
        filtered_cols_sp <- c(setdiff(filtered_cols, "service_point_name"), "Service Point")
      } else {
        filtered_cols_sp <- filtered_cols
      }

      if ("service_type" %in% filtered_cols) {
        filtered_cols_sp <- c(setdiff(filtered_cols_sp, "service_type"), "Service Type")
      }

      if ("location_name" %in% filtered_cols) {
        filtered_cols_sp <- c(setdiff(filtered_cols_sp, "location_name"), "location")
      }

      loc_u <- grep("unique_id", filtered_cols, ignore.case = TRUE) - 1

      removeModal()

      if (!"location_name" %in% extant_cols) {
        new_names <- c(
          "Service Point" = "service_point_name",
          "Service Type" = "service_type"
        )
      } else {
        new_names <- c(
          "Service Point" = "service_point_name",
          "Service Type" = "service_type",
          "location" = "location_name"
        )
      }

      make_table(
        dataset_init, filtered_cols,
        loc_u, dontwrap_cols_filt,
        filtered_cols_sp, new_names
      )
    })

    observeEvent(c(vars_unifier$dataset()),
      ignoreInit = T,
      {
        dataset <- vars_unifier$dataset()

        extant_cols <- colnames(dataset)

        if ("service_point_name" %in% extant_cols) {
          extant_cols_filt <- c(setdiff(extant_cols, "service_point_name"), "Service Point")
        } else {
          extant_cols_filt <- extant_cols
        }

        if ("location_name" %in% extant_cols) {
          extant_cols_filt <- c(setdiff(extant_cols_filt, "location_name"), "location")
        } else {
          extant_cols_filt <- extant_cols_filt
        }

        dontwrap_cols_filt <- intersect(dontwrap_cols, extant_cols_filt)

        first_cols_filt <- intersect(first_cols, extant_cols)

        filtered_cols <- intersect(
          c(
            first_cols_filt,
            setdiff(extant_cols, first_cols_filt)
          ),
          colnames(dataset)
        )

        if ("service_point_name" %in% filtered_cols) {
          filtered_cols_sp <- c(setdiff(filtered_cols, "service_point_name"), "Service Point")
        } else {
          filtered_cols_sp <- filtered_cols
        }

        if ("service_type" %in% filtered_cols) {
          filtered_cols_sp <- c(setdiff(filtered_cols_sp, "service_type"), "Service Type")
        }

        if ("location_name" %in% filtered_cols) {
          filtered_cols_sp <- c(setdiff(filtered_cols_sp, "location_name"), "location")
        }

        loc_u <- grep("unique_id", filtered_cols, ignore.case = TRUE) - 1

        if (!"location_name" %in% extant_cols) {
          new_names <- c(
            "Service Point" = "service_point_name",
            "Service Type" = "service_type"
          )
        } else {
          new_names <- c(
            "Service Point" = "service_point_name",
            "Service Type" = "service_type",
            "location" = "location_name"
          )
        }

        output$mytable <- DT::renderDataTable(
          {
            make_table(
              dataset, filtered_cols,
              loc_u, dontwrap_cols_filt,
              filtered_cols_sp, new_names
            )
          },
          server = F
        )
      }
    )
  })
}
