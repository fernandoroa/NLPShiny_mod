sidebar_style <- list(
  root = list(
    height = "100%",
    boxSizing = "border-box",
    border = "1px solid #eee",
    overflowY = "auto"
  )
)

list_link_pages <- list(list(links = list(
  list(
    name = "Main",
    url = "#!/",
    key = "home",
    isExpanded = FALSE
  ),
  list(
    name = "InputForm",
    url = paste0("#!/", "inputform"),
    key = "input_form",
    isExpanded = FALSE
  ),
  list(
    name = "About",
    url = paste0("#!/", "about"),
    key = "about",
    isExpanded = FALSE
  )
)))

sidebar <- tagList(
  Nav(
    groups = list_link_pages,
    initialSelectedKey = "home",
    styles = sidebar_style
  )
)
