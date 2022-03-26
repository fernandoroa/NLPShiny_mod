NLP repo. with modules - without rhino/box
================

### Context

This shiny repository is a modular version of the one developed by me in
the ds4a (data science for all course) CorrelationOne project challenge.
<https://gitlab.com/ferroao/nlpfeedback> ,
<https://nlpapp-rwjey56xuq-uc.a.run.app>

Credentials for mongodb are not available in this repository, following
ds4a rules.

In the gitlab repository are the python notebook files (models),
‘written’ in group, not only by me.

### Objectives

-   learn to use modules for better coding practices, performance
-   learn rhino/box for better coding practices
-   use shiny.fluent to learn to generate better UIs
-   share in Shiny Conference as an example to community on those
    aspects

### Business problem

The shiny app is connected to a source database of community feedback.
This feedback is provided continuously to NGOs (into the database of a
third part - here as PoC only, not the real database)

App PoC: The feedback should be constantly updated (form page), filtered
(mod. submit), whenever needed tagged (tag module), based on a NLP model
developed using a subset of tagged data (stored in .pkl files).

Finally, for the health and cash service types (models), text can be
subset (mod. services). This way NGOs can attend and prioritize
solutions for communities.

### What is ready ?

-   The module of the selectors, upper left, called submit
-   The module of the table, bottom right
-   The module of the tag button, bottom left: tag
-   The module of the services, bottom left, they handle cash and health
    subsetting after tagging
-   The module map, upper right
-   The module unify, which integrates inputs of submit, tag and
    services for the map and table outputs

### What is missing ?

-   rhino/box (integrate with rhino repository)
-   module form, for adding entries to mongodb in real time
-   module wordcloud
-   translation for classifying Africa community feedback (english)
-   video for Shiny Conference

### Where is python here?

-   See the `Dockerfile`
-   See `requirements`
-   See the `py` folder for scripts developed by me
-   See the tag module in folder `modules` for the calls
    `system("python3...`
