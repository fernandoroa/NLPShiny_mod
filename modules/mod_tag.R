#
# tag module
#

#' @description module to allow choosing a data.frame name and its feedback from
#' same module different namespace
#' @param
#' @param
#' module namespace, see return, used for feedback
#' @return list with data.frame name (string) selected

tag_ui <- function(id) {
  ns <- NS(id)
  tagList(
    div(
      style = "padding:25px 0 0 0;max-width:266px;", class = "tag-container",
      actionButton(ns("tag_button"), "NLP in action, tag the feedback!", icon("tag"),
        style = "color: #fff; background-color: #337ab7; border-color: #2e6da4"
      ),
      div(
        style = "text-align:center;color:#A8A8A8;",
        helpText("add tag column to table")
      )
    )
  )
}

tag_server <- function(id, vars_unifier) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns

    rv <- reactiveValues()

    observeEvent(input$tag_button, ignoreInit = T, {
      if (file.exists("outfiles/cash_df.csv")) {
        file.remove("outfiles/cash_df.csv")
      }

      if (file.exists("outfiles/health_df.csv")) {
        file.remove("outfiles/health_df.csv")
      }

      shinyjs::disable("tag_button")

      dataset <- vars_unifier$dataset_whole()

      #
      #   initial datasets
      #

      if (file.exists("outfiles/selection.csv")) {
        file.remove("outfiles/selection.csv")
      }

      write.csv(tolower(dataset[, "feedback"]), "outfiles/selection.csv", row.names = T)

      #
      #   make dfs for tagging
      #

      health_df <- as.data.frame(dataset[which(dataset$service_type == "Healthcare"), "feedback"])

      cash_df <- as.data.frame(dataset[which(dataset$service_type == "Cash Transfer"), "feedback"])

      if (nrow(cash_df) > 0) {
        write.csv(cash_df, "outfiles/cash_df.csv", row.names = T)
        system("python3 py/load_model.py pkl/model_SVC.pkl pkl/tfidf_cash.pkl outfiles/cash_df.csv outfiles/cash_out.txt")
        cash_tags <- readLines("outfiles/cash_out.txt")
        # dataset$nlp_tag <- as.character(NA)

        if (!"nlp_tag" %in% colnames(dataset)) {
          dataset$nlp_tag <- as.character(NA)
        }

        dataset[which(dataset$service_type == "Cash Transfer"), ]$nlp_tag <- cash_tags
        rv$cash_cat <- unique(cash_tags)
        shinyjs::show("cash_select_UI_id", asis = T)
      }

      if (nrow(health_df) > 0) {
        write.csv(health_df, "outfiles/health_df.csv", row.names = T)
        system("python3 py/load_model.py pkl/model_SVH.pkl pkl/tfidf_health.pkl outfiles/health_df.csv outfiles/health_out.txt")
        health_tags <- readLines("outfiles/health_out.txt")

        if (!"nlp_tag" %in% colnames(dataset)) {
          dataset$nlp_tag <- as.character(NA)
        }

        dataset[which(dataset$service_type == "Healthcare"), ]$nlp_tag <- health_tags
        rv$health_cat <- unique(health_tags)
        shinyjs::show("health_select_UI_id", asis = T)
      }

      rv$dataset_tag <- dataset
    })

    return(
      list(
        dataset_tag = reactive({
          rv$dataset_tag
        }),
        cash_cat = reactive({
          rv$cash_cat
        }),
        health_cat = reactive({
          rv$health_cat
        })
      )
    )
  })
}
