
### No use for this yet ###
# File paths are incorrect for the time being


# source("./global.R")
source(here::here("app","global.R"))

# UI ----------------------------------------------------------------------

index_ui <- shinydashboardPlus::dashboardPage(
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
      tags$style(HTML(cssHeader)),
      tags$script(HTML(jqueryHeader))
    ),
    tabItems(
      tabItem(tabName = "intro", 
              includeHTML(intro_page_html)
      ),
      tabItem(tabName = "software", 
              # inclRmd("script/software.Rmd")
              includeHTML(software_page_html)
      ),
      tabItem(tabName = "publications", 
              # inclRmd("script/research.Rmd")
              includeHTML(research_page_html)
      )
    )
  )
)



# ui_code <- cat(as.character(index_ui)) %>% capture.output()
# 
# index_file <- here::here("index.html")
# writeLines(as.character(index_ui), index_file)

# browseURL(index_file)
# Server ------------------------------------------------------------------


server <- function(input, output) {
  
}


shinyApp(index_ui, server)