suppressPackageStartupMessages({
  library(tidyverse)
  library(shiny)
  library(shinydashboard)
  library(shinydashboardPlus)
  library(shinyWidgets)
})


app_version <- "0.0.0.9000"

# Header Text
ver_text <- sprintf("Version %s", app_version)


# Js for header -----------------------------------------------------------

cssHeader <-  '.myClass { font-size: 14px;line-height: 50px;text-align: right;
              padding: 0 15px;overflow: hidden;color: white;float: right !important;}'

jqueryHeader <- paste0('$(document).ready(function() {
                 $("header").find("nav").append(\'<span class="myClass">',
                 ver_text,'</span>\');})')


# Source modules and functions --------------------------------------------

# source all functions in functions folder
func_dir <- here::here("app/functions")
functions <- list.files(func_dir)
for(function.i in functions){
  source(file.path(func_dir, function.i))
}

# source modules
# modules <- list.files("modules")
# for(module.i in modules){
#   source(file.path("modules", module.i))
# }



# Rmarkdown Tabs ----------------------------------------------------------

# intro_page_html <- rmarkdown::render(here::here("intro.Rmd"), "html_document", quiet = TRUE)
# software_page_html <- rmarkdown::render(here::here("software.Rmd"), "html_document", quiet = TRUE)
# research_page_html <- rmarkdown::render(here::here("research.Rmd"), "html_document", quiet = TRUE)

intro_page_html <- here::here("intro.html")
software_page_html <- here::here("software.html")
research_page_html <- here::here("research.html")

# intro_page_html <- rmarkdown::render(here::here("app/script/intro.Rmd"), "html_document", quiet = TRUE)
# software_page_html <- rmarkdown::render(here::here("app/script/software.Rmd"), "html_document", quiet = TRUE)
# research_page_html <- rmarkdown::render(here::here("app/script/research.Rmd"), "html_document", quiet = TRUE)

# Source Data Setup Script ------------------------------------------------

# source(file.path("script", "data-setup.R"))

gc()