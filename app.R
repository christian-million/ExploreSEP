# Attach Packages ----
library(shiny)
library(ggplot2)

# Read in Business Logic ----
source("R/read.R")
source("R/plot.R")
source("R/filter.R")

# Define UI -----
ui <- fluidPage(

    # Application title
    titlePanel("Explore SEP Data"),

    sidebarLayout(

        # Sidebar Section ----
        sidebarPanel(

            # Create an Input
            selectInput("metric",
                        "Select Metric:",
                        choices = NULL,
                        selected = 300), # <- See the comma

            # Create an Input
            selectInput("group",
                        "Select Disagg Group:",
                        choices = NULL,
                        selected = "Ethnicity"), # <- See the comma

            # Create an Input
            fileInput("file",
                      "Upload SEP File:",
                      accept = c("text/csv",
                                 "text/comma-separated-values,text/plain",
                                 ".csv")) # <- NO COMMA

        ),

        # Main Panel ----
        mainPanel(

            # Set Location of Plot
            plotOutput("plotDI"),

            # Set Location of Table
            tableOutput("tableSEP")

        )
    )
)


# Define Server Logic -----
server <- function(input, output, session) {

    # Raw data takes dependency on input$file
    raw_data <- reactive({

        req(input$file)
        read_SEP(input$file$datapath)

    })

    # Data Function takes dependency on input$metric and input$group
    data <- reactive({

        filter_SEP(raw_data(), input$metric, input$group)

    })

    # Logic to create our plot
    output$plotDI <- renderPlot({

        # Prevent ggplot2 Warning Message
        # https://stackoverflow.com/questions/55604099/can-a-renderplot-output-be-delayed-for-a-few-seconds-till-all-reactive-subsets-a
        shiny::validate(need(input$metric, F), need(input$group, F))

        if (is.null(data())) {
            return(NULL)
        }

        plot_ppg1(data())

    })

    # Logic to create our table
    output$tableSEP <- renderTable({
        if (is.null(data())) {
            return(NULL)
        }

        tbl_SEP(data())

    })

    # When raw data is uploaded, we want to populate the options of our UI
    # Using columns contained within the uploaded data
    observe({

        # Get Choices from Uploaded Data
        metric_choices <- metric_list(raw_data())
        group_choices  <- group_list(raw_data())

        # Update the UI
        updateSelectInput(session,
                          "metric",
                          choices = metric_choices)

        # Update the UI
        updateSelectInput(session,
                          "group",
                          choices = group_choices)

    })

}

# Run the application
shinyApp(ui = ui, server = server)
