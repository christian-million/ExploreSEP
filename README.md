# SEP Explorer Demo App

This app is a demonstration of the Shiny framework for the R Working Group - an informal group of CCC IR professionals learning R together.

# Run the App on your Computer

Steps:

-   Download this repository

-   Open R; Set this repo as working directory

-   Ensure "shiny" and "ggplot2" are installed

-   Run "app.R"

    -   via console: Run `shiny::runApp("app.R")`

    -   via RStudio: Open the "app.R" file and click the "Run App" button in the IDE

-   Use "Upload SEP File" button to "Upload" SEP data ("SEP_2022_summary_baseline_year...")

    -   NOTE: For the

    -   NOTE: As long as you are running this app on your local computer (where you normally store your SEP data), you're not **actually** uploading your data to another server - which is a good thing. Always abide by your organizations data security practices.

-   Use the "Select Metric:" and "Select Disagg Group:" inputs to change the resulting graph.

# Overview of Files

-   `app.R`: This is where all of the logic to our Shiny App exists

-   `R/`: The `R/` folder contains files that captures our business logic into code

    -   `R/read.R` contains functions to read in the SEP csv

    -   `R/plot.R` contains functions to plot a subset of our SEP data

    -   `R/filter.R` contains functions to filter our SEP data
