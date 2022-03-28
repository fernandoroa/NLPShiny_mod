servicetype_ui <- function(id) {
  ns <- NS(id)

  tagList(
    div(
      id = paste0(id, "_select_UI_id"),
      uiOutput(
        ns(paste0(id, "_select_UI"))
      )
    )
  )
}

servicetype_server <- function(id, vars_unifier, vars_submit) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns
    rv <- reactiveValues(click_count = 0)
    rv$alist <- list()

    observeEvent(vars_unifier[[paste0(id, "_cat")]](), ignoreInit = TRUE, {
      caps_id <- gsub("(^[[:alpha:]])", "\\U\\1", id, perl = TRUE)

      output[[paste0(id, "_select_UI")]] <- renderUI({
        tagList(
          br(),
          div(
            class = "drop-container",
            selectInput(
              ns(paste0(id, "_input")),
              paste0(
                caps_id,
                " tags:"
              ),
              vars_unifier[[paste0(id, "_cat")]]()
            )
          ),
          br(),
          actionButton(ns(paste0(id, "_subset_button")),
            paste(
              "Subset",
              long_type_names[id]
            ),
            icon("table"),
            style = "color: #fff; background-color: #337ab7; border-color: #2e6da4"
          )
        )
      })

      observeEvent(
        input[[paste0(id, "_subset_button")]],
        {
          rv$click_count <- rv$click_count + runif(1, 1, 2)
          session$sendCustomMessage(
            type = "testmessage",
            message = rv$click_count
          )
        },
        ignoreInit = T
      )

      observeEvent(c(
        vars_submit$submit(),
        input[[paste0(id, "_subset_button")]]
      ),
      ignoreInit = T,
      {
        rv$alist$ds_copy <- vars_unifier$dataset_whole()
      }
      )

      observeEvent(input[[paste0(id, "_subset_button")]], ignoreInit = T, {
        rv$alist$dataset_cash_health <- rv$alist$ds_copy[which(rv$alist$ds_copy$nlp_tag %in%
          input[[paste0(id, "_input")]]), ]

        if (file.exists("outfiles/selection.csv")) {
          file.remove("outfiles/selection.csv")
        }

        rv$dataset_subset <- rv$alist$dataset_cash_health

        write.csv(tolower(rv$dataset[, "feedback"]), "outfiles/selection.csv", row.names = T)
      })
    })

    return(
      list(
        dataset_subset = reactive({
          rv[["dataset_subset"]]
        }),
        dataset_not_subset = reactive({
          rv$alist$ds_copy
        }),
        click_count = reactive({
          rv[["click_count"]]
        })
      )
    )
  })
}
