logo <- img(src = "appsilon-logo.png", class = "logo")

far_items <- list(
  list(
    key = "info",
    text = "Repo",
    ariaLabel = "Info",
    iconOnly = F,
    href = "https://github.com/Appsilon/possible_example",
    iconProps = list(
      iconName = "Info"
    )
  )
)

command_bar <- CommandBar(
  far_items = far_items,
  style = list(width = "100%")
)

title <- div(Text(variant = "xLarge", "Community feedback tagging with NLP"),
  class = "title",
  style = "align: center; white-space:nowrap;"
)

header_right <- tagList(
  IconButton.shinyInput("button", iconProps = list("iconName" = "CollapseMenu")),
  title, command_bar
)

header_left <- tagList(logo)

footer <- Stack(
  horizontal = T,
  tokens = list(childrenGap = 150),
  Text(variant = "large", "Built with ❤ by Appsilon", block = TRUE),
  Text(variant = "medium", nowrap = FALSE, "If you'd like to learn more, react out to us at hello@appsilon.com")
)
