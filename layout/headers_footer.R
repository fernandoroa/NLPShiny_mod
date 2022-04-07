logo <- img(src = "logoNLP.png", class = "logo")

far_items <- list(
  list(
    key = "info",
    text = "About",
    ariaLabel = "Info",
    iconOnly = F,
    href = "https://github.com/Appsilon/NLPShiny/tree/mod_and_rhino",
    iconProps = list(
      iconName = "Info"
    )
  )
)

command_bar <- CommandBar(
  farItems = far_items,
  style = list(width = "80%")
)

title <- div(Text(variant = "xLarge", "Community feedback tagging using NLP"),
  class = "title",
  style = "align: center; white-space:nowrap;"
)

header_right <- tagList(
  title, command_bar
)

header_left <- tagList(logo,
                       div(style="margin-left:auto;",
                       IconButton.shinyInput("button", 
                                             iconProps = 
                                               list("iconName" = "CollapseMenu")
                       )
                       )
                       )

footer <- Stack(
  horizontal = T,
  tokens = list(childrenGap = 150),
  Text(variant = "large", "Built by Fernando Roa & Patrick Alverga", block = TRUE),
  Text(variant = "medium", nowrap = FALSE, 
       "Backbone based on https://github.com/Appsilon/shiny.fluent")
)
