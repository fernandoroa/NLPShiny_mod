
#
# unifier module server only
#

#' @description this module watches both main dataset selectors to produce an
#' updated universal selection. In addition it observes the form (page) to
#' update the data.frame selected
#' @param vars_unifier      set of objects shared among modules
#' @return list with data.frame and categ. and numeric variables

unifier_server <- function(id, dataset_init, vars_filter,
                           vars_tag, vars_cash, vars_health) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns
    center_init <- "Cundinamarca"
    lng1 <- col_states_coord[which(col_states_coord$state %in% center_init), ]$lng
    lat1 <- col_states_coord[which(col_states_coord$state %in% center_init), ]$lat

    values <- reactiveValues(
      dataset = dataset_init,
      dataset_whole = dataset_init,
      cash_cat = F,
      region = 1,
      lat = lat1,
      lng = lng1,
      active_tag = 0
    )

    observe({
      values[["dataset"]] <- vars_filter$dataset()
      values[["dataset_whole"]] <- vars_filter$dataset()

      values[["region"]] <- vars_filter$region()
      values[["lat"]] <- vars_filter$lat()
      values[["lng"]] <- vars_filter$lng()
      values[["dataset_not_subset"]] <- NULL
      values[["allow_sub"]] <- vars_filter$allow_sub()

      shinyjs::enable("mod_tag-tag_button", asis = T)
    }) %>% bindEvent(vars_filter$submit(), ignoreInit = T)

    observe({
      values[["dataset"]]       <- vars_tag$dataset_tag()
      values[["dataset_whole"]] <- vars_tag$dataset_tag()
      values[["cash_cat"]]      <- vars_tag$cash_cat()
      values[["health_cat"]]    <- vars_tag$health_cat()
      values[["active_tag"]]    <- values$active_tag + 1
      
    }) %>% bindEvent(vars_tag$tag_active(), ignoreInit = T)

    observe({
      values[["dataset"]] <- vars_cash$dataset_subset()
    }) %>% bindEvent(vars_cash$dataset_subset(), ignoreInit = T)

    observe({
      values[["dataset"]] <- vars_health$dataset_subset()
    }) %>% bindEvent(vars_health$dataset_subset(), ignoreInit = T)

    return(
      list(
        active_tag = reactive({
          values$active_tag
        }),
        dataset = reactive({
          values$dataset
        }),
        dataset_whole = reactive({
          values$dataset_whole
        }),
        cash_cat = reactive({
          values$cash_cat
        }),
        health_cat = reactive({
          values$health_cat
        }),
        region = reactive({
          values$region
        }),
        lat = reactive({
          values$lat
        }),
        lng = reactive({
          values$lng
        }),
        allow_sub = reactive(values$allow_sub)
      )
    )
  })
}
