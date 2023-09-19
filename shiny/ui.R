library(shiny)
library(shinydashboard)
ui <- dashboardPage(
  dashboardHeader(title = "IF36-projet", dropdownMenu(
    type = "tasks", badgeStatus = "success",
    taskItem(
      value = 80, color = "green",
      "Home page"
    ),
    taskItem(
      value = 10, color = "aqua",
      "Question page"
    )
  ), dropdownMenu(
    type = "messages",
    messageItem(
      from = "Develepment Team",
      message = "Hello World"
    )
  )),
  dashboardSidebar(sidebarMenu(
    menuItem("Description du dataset", tabName = "HomePage", icon = icon("dashboard")),
    menuItem("Graphique 1", tabName = "Page_1", icon = icon("bookmark")),
    menuItem("Graphique 2", tabName = "Page_2", icon = icon("bookmark")),
    menuItem("Graphique 3", tabName = "Page_3", icon = icon("bookmark")),
    menuItem("Graphique 4", tabName = "Page_4", icon = icon("dashboard")),
    menuItem("Graphique 5", tabName = "Page_5", icon = icon("dashboard"))
  )),
  dashboardBody(
    tabItems(
      # Home page
      tabItem(
        tabName = "HomePage",
        fluidRow(
          column(12,
            align = "center",
            tags$img(src = "https://camo.githubusercontent.com/b13eaf161bd1a72a9e0c39a896756c483e8bc80841ae2bf7052951c3bb85acfb/68747470733a2f2f696d616765732e756e73706c6173682e636f6d2f70686f746f2d313634303632323330303933302d3665386461613938353336663f69786c69623d72622d312e322e3126713d383526666d3d6a70672663726f703d656e74726f70792663733d73726762", with = "100px", height = "150px")
          ),
          column(12, align = "center", tags$span(style = "color:#66a3ff;font-size:50px;font-weight: bold;", "Data Characteristics"))
        ),
        fluidRow(
          valueBoxOutput("individus"),
          valueBoxOutput("dimensions"),
          infoBox("Number of deferent country", textOutput("countries"), icon = icon("list"),fill = FALSE)
        ),
        fluidRow(
          box(title = "Distribution of age and gender", status = "primary", width = 12, plotOutput("plot_age_distribute")),
          box(title = "Distribution of data with date", status = "primary", width = 12, plotOutput("plot_distribute_time"))
          
        )
      ),
      tabItem(
        tabName = "Page_1",
        h2("Graphique 1"),
        h3("Correlation entre la maniere dont la sante mentale d'un employe interfere avec son travail et son lieu geographique de travail"),
        fluidRow(
          box(
            title = "Histogram", status = "warning", solidHeader = TRUE, collapsible = TRUE,
            plotOutput("plotSchema1")
          ),
          box(
            title = "Select a region", background = "orange",
            selectInput("selectRegion",
              label = h3("Select a region"),
              choices = list("World" = "Country", "USA" = "state"), selected = "Country"
            )
          )
        )
      ), # item

      tabItem(
        tabName = "Page_2",
        h2("Graphique 2"),
        h3("Correlation entre la maniere dont la sante mentale du salarie interfere avec son travail et l'age/le genre des repondants"),
        fluidRow(
          box(
            title = "Schema violin", status = "primary", solidHeader = TRUE, collapsible = TRUE,
            plotOutput("plotSchema2")
          ),
          box(
            title = "Select an attribute", background = "navy",
            selectInput("selectAttribute",
              label = h3("Select an attribute"),
              choices = list("Age" = "age", "Gender" = "gender"), selected = "age"
            )
          )
        )
      ), # item


      # Q7 tab content
      tabItem(
        tabName = "Page_3",
        h2("Graphique 3"),
        h3("Correlation entre le fait qu'un salarie aborde le sujet de ses soucis de sante mentale lors d'un entretien d'embauche et le fait qu'il ait deja ete temoin des consequences negtaives que cela aurait eu pour un autre salarie"),
        fluidRow(
          box(
            title = "correlation between mental health and remote work", status = "info", solidHeader = TRUE, collapsible = TRUE,
            plotOutput("plotQuestion7")
          ),
          box(
            background = "navy",
            selectInput("select",
              label = h3("Select filled way"),
              choices = list("fill" = "fill", "dodge" = "dodge"), selected = "dodge"
            )
          )
        )
      ),

      # Q8 tab content
      tabItem(
        tabName = "Page_4",
        h2("Graphique 4"),
        h3("Correlation entre teletravail et prise de traitement pour des soucis de sante mentale"),
        fluidRow(
          box(
            title = "correlation between mental health and remote work", status = "info", solidHeader = TRUE, collapsible = TRUE,
            plotOutput("plotQuestion8")
          )
        )
      ),

      # Q9 tab content
      tabItem(
        tabName = "Page_5",
        h2("Graphique 5"),
        h2("Les salaries sont-ils plus enclins a parler de leurs problemes de sante mentale avec leurs collegues ou leurs superieurs ?"),
        fluidRow(
          tabBox(
            # The id lets us use input$tabset1 on the server to find the current tab
            id = "tabset_Q9", height = "250px",
            width = 12,
            tabPanel("Tab1", plotOutput("plotQ9_1")),
            tabPanel("Tab2", plotOutput("plotQ9_2")),
            tabPanel("Tab3", plotOutput("plotQ9_3"))
          )
        )
      )
    )
  )
)
