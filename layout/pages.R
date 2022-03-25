input_form_page <- tagList(
  div(
    class = "grid-form",
    wellPanel(
      div(
        class = "parent",
        form_ui("mod_form")
      )
    )
  )
)

card1 <- div(
  Stack(
    tokens = list(childrenGap = 15),
    Text(
      variant = "xLarge",
      "Welcome, this example was built with modules, shiny.fluent, shiny.router and shiny.semantic !",
      block = F
    ),
    Text(
      "shiny.fluent is a package that allows you to build Shiny apps using Microsoft's Fluent ui."
    ),
    Text(
      "shiny.router allows the functioning of the different pages at the left."
    ),
    Text(
      "shiny.semantic allows beautiful tabs in this example."
    )
  )
)

about_page <- tagList(
  wellPanel(
    style = "max-width:1000px", # class="grid-form",
    div(
      style = "padding:20px;",
      card1
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
                menu = "Table",
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
                      # verbatimTextOutput("irisText"
                      #                    , height = 640
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
  route("about", about_page)
))
