input_form_page <- tagList(
  div(
    class = "grid-form",
      div(
        class = "parent",
        form_ui("mod_form")
      )
  )
)

intro_page <- tagList(
  div(style="margin-left:4px;",
      br(),
      h2("Introduction")
      ,br(),
      div(style="max-width:33vw;",
        segment(style="padding:20px;",
                div(
                  Stack(
                    tokens = list(childrenGap = 15),
                    Text(
                      variant = "xLarge",
                      "Business problem",
                      block = F
                    ),
                    lapply(card7list, function(x) {Text(x)
                    })
                  )
                )
        ),
        segment(style="padding:20px;",
                div(
                  Stack(
                    tokens = list(childrenGap = 15),
                    Text(
                      variant = "xLarge",
                      "Which model is used and how?",
                      block = F
                    ),
                    lapply(card8list, function(x) {Text(x)
                    })
                  )
                )
        )
      ),
  )
)

howto_page <- tagList(
  div(style="margin-left:4px;",
      br(),
      h2("Pages functionality")
      ,br()
  ),
  splitLayout(style = "background:#FFFFFF;",
    tagList(
  div(style="margin-left:5px;",
    h4("First page: Tag feedback")
  ),
  div(
    class = "grid-mini-1-up",
      segment(style="padding:20px;",
        card1
      ),
      segment(style="padding:20px 10px 0 10px;",
        card2
      )
    ),
  div(
    class = "grid-mini-1-down",
    segment(style="padding:20px;",
            card3
    ),
    segment(style="padding:20px;",
            card4
    )
  )
  ),
  tagList(
    div(style="margin-left:5px;",
      h4("2nd page: Database")
    ),
    div(
      class = "grid-mini-2",
      div(class="seg5",
      segment(style="padding:20px;min-height:240px;",
              card5
      )
      ),
      div(class="seg6",
      segment(style="padding:20px;",
              card6
      )
    )
   )
  )
 )
)

main_page <- tagList(
  div(
    class = "grid-inside-up",
    segment(
      filter_ui("mod_filter")
    ),
    div(
      class = "map-container",
      mod_map_ui("nsMap")
    )
  ),
  div(
    class = "grid-inside-down",
    div(
      class = "downleft",
      tag_ui("mod_tag"),
      servicetype_ui("cash"),
      servicetype_ui("health")
    ),
    div(
      class = "downright", # style="max-height:35vh;width:63vw;",
      semanticPage(
        tabset(
          tabs =
            list(
              list(
                menu = "Feedback and metadata",
                content =
                  tagList(
                    div(
                      table_ui("mod_table")
                    )
                  )
              ),
              list(
                menu = "Details",
                content =
                  tagList(
                    div(
                      style = "padding:20px;",
                      card1
                    )
                  )
              )
            ),
          active = "second_tab",
          id = "exampletabset"
        )
      )
    )
  )
)

pages <- c(list(
  route("/", main_page),
  route("inputform", input_form_page),
  route("howto", howto_page),
  route("intro", intro_page)
))
