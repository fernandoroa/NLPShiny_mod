NLP repo. with modules - without rhino/box
================

### Context

This shiny repository is a modular version of the one developed by me in
the ds4a CorrelationOne project.
<https://gitlab.com/ferroao/nlpfeedback> ,
<https://nlpapp-rwjey56xuq-uc.a.run.app>

Credentials are not available in this repository, following ds4a rules.

In that repository are the python notebook files, ‘written’ in group.

### Objectives

-   learn to use modules for better coding practices, performance
-   learn rhino/box for better coding practices
-   use shiny.fluent to learn to generate better UIs
-   share in Shiny Conference as an example to community on those
    aspects

### Business problem

The shiny app is connected to a database of community feedback: This
feedback is provided to NGOs through a third part.

App PoC: The feedback should be constantly updated (form page), whenever
needed tagged (tag module), based on a NLP model developed using a
subset of tagged data (stored in .pkl files).

So, for the health and cash service types (models), text can be
classified (mod. tag) and subset (mod. services).

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

-   rhino/box
-   module form, for adding entries to mongodb in real time
-   module wordcloud
-   integrate with rhino repository
-   translation for classifying Africa community feedback

### Recent developments

For the last two weeks, only 20% of time was dedicated to this, and box
(rhino) is very different, so 2 days of rhino, which is little for me.
