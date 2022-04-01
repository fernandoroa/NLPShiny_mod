NLP repo. with modules - without rhino/box
================

<img src=readme_logo.png align="right" width="12%" hspace="50">

### App

<https://nlp-kwwxur3qea-uc.a.run.app>

### Context

This shiny repository is a modular version of the one developed by me in
the ds4a (data science for all course) CorrelationOne project challenge.
\[<https://gitlab.com/ferroao/nlpfeedback> ,
<https://nlpapp-rwjey56xuq-uc.a.run.app>\]

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

### Python

##### Which model is used and how?

The python model is precomputed, saved in .pkl files, see folder `pkl`,
and loaded by python scripts in folder `py`, from a call in the R module
`tag`. The pertinent python notebook developed in group is on the gitlab
repository, see above. In the notebook, the accepted model is SVC

##### Where is python?

-   `Dockerfile` file
-   `requirements.txt` file
-   `py` folder for scripts developed by me
-   models are saved in `.pkl` files (`pkl` folder)
-   See the `tag` module in folder `modules` for the calls
    `system("python3...`

### What is ready ?

-   The module of the selectors, upper left, called submit
-   The module of the table, bottom right
-   The module of the tag button, bottom left: tag
-   The module of the services, bottom left, they handle cash and health
    subsetting after tagging
-   The module map, upper right
-   The module unify, which integrates inputs of submit, tag and
    services for the map and table outputs
-   module form, for adding entries to mongodb in real time
-   Third page with workflow (How to)

### What is missing ?

-   rhino/box (integrate with rhino repository) (optional, Marek)
-   module wordcloud
-   translation for classifying Africa community feedback (english)
-   video for Shiny Conference

### Working app in cloudRun

-   <https://nlp-kwwxur3qea-uc.a.run.app>
-   For details look at `cloudRun.md`
