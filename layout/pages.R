input_form_page <- tagList(
  div(
    class = "grid-form",
      div(
        class = "parent",
        form_ui("mod_form")
      )
  )
)

card1 <- div(
  Stack(
    tokens = list(childrenGap = 15),
    Text(
      variant = "xLarge",
      "filter feedback database",
      block = F
    ),
    Text(
      "Here you can choose"
    ),
    Text(
      "- region: Colombia/Africa"
    ),
    Text(
      "- service types: only Healthcare and Cash can be tagged"
    ),
    Text(
      "- dates, sample size and user satisfaction"
    )
  )
)

card2 <- div(
  Stack(
    tokens = list(childrenGap = 0),
    Text(
      variant = "xLarge",
      "Map of selected feedback",
      block = F
    ),
    mod_plot_ui("minimap")
  )
)

card3 <- div(
  Stack(
    tokens = list(childrenGap = 15),
    Text(
      variant = "xLarge",
      "Tag",
      block = F
    ),
    Text(
      "- Use the tag button after filtering database"
    ),
    Text(
      "- After that, subset with the cash or health buttons"
    )
  )
)

card4 <- div(
  Stack(
    tokens = list(childrenGap = 15),
    Text(
      variant = "xLarge",
      "Feedback table",
      block = F
    ),
    Text(
      "- After tagging, a new column will appear"
    ),
    Text(
      "- After subsetting, your selection will be here"
    )
  )
)

card5 <- div(
  Stack(
    tokens = list(childrenGap = 15),
    Text(
      variant = "xLarge",
      "Input form",
      block = F
    ),
    Text(
      "- Example data to feed the mongo database"
    ),
    Text(
      "- The mongo db is remote, it is hosted on mongo Atlas"
    )
  )
)

card6 <- div(
  Stack(
    tokens = list(childrenGap = 15),
    Text(
      variant = "xLarge",
      "Action buttons",
      block = F
    ),
    Text(
      "- Upload form data to the database"
    ),
    Text(
      "- Remove last entry from the mongo db"
    )
  )
)

intro_page <- tagList(
  div(style="margin-left:4px;",
      br(),
      h2("Introduction")
      ,br()
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
      submit_ui("mod_submit")
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
