

source("./global.R")

# UI ----------------------------------------------------------------------

ui <- shinydashboardPlus::dashboardPage(
  title = ver_text,
  shinydashboardPlus::dashboardHeader(
    title = "Kyle Barrett", titleWidth = "300px"
  ),
    shinydashboardPlus::dashboardSidebar(
      width = "300px",
      br(), 
      sidebarMenu(
        fluidRow(
          column(12, align="center",
                 tagList(img(src="name_logo.png", height='220px', width='200px'))
          )
        )
      ),
      hr(),
      sidebarMenu(
        id = "main_menu",
        menuItem("Introduction", tabName = "intro", icon = icon("dashboard")),
        menuItem("Software", tabName = "software", icon = icon("file-text-o")),
        menuItem("Publications", tabName = "publications", icon = icon("bar-chart-o"))
      ),
      hr()
    ),
    dashboardBody(
      waiter::use_waiter(),
      shinyjs::useShinyjs(),
      tags$head(
        tags$link(rel = "stylesheet", type = "text/css", href = file.path("css", "kb-shiny.css")),
        tags$style(HTML(jsHeader)),
        tags$script(HTML(jqueryHeader))
      ),
      tabItems(
        tabItem(tabName = "intro", 
                includeMarkdown("script/index.Rmd")),
        tabItem(tabName = "software", 
                includeMarkdown("script/software.Rmd")),
        tabItem(tabName = "publications", 
                includeMarkdown("script/research.Rmd"))
      )
    )
)


# Server ------------------------------------------------------------------


server <- function(input, output) {
  
  
  # Modules -----------------------------------------------------------------
  
  
  # Other Logic -------------------------------------------------------------
  
}

shinyApp(ui, server)
