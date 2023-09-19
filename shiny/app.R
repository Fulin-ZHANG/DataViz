library(shiny)
library(shinydashboard)


# load ui elements
source("ui.R")
# load server function
source("server.R")

# Run the application
shinyApp(ui = ui, server = server)
