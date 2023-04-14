suppressPackageStartupMessages({
  library(tidyverse)
  library(shinydashboard)
  library(shinydashboardPlus)
  library(shinyWidgets)
  library(shinyjs)
})


app_version <- "0.0.0.9000"

# Header Text
ver_text <- sprintf("Version %s", app_version)


# Js for header -----------------------------------------------------------

jsHeader <-  '.myClass { font-size: 14px;line-height: 50px;text-align: right;
              padding: 0 15px;overflow: hidden;color: white;float: right !important;}'

jqueryHeader <- paste0('$(document).ready(function() {
                 $("header").find("nav").append(\'<span class="myClass">',
                 ver_text,'</span>\');})')


# Source modules and functions --------------------------------------------

# # source all functions in functions folder
# functions <- list.files("functions")
# for(function.i in functions){
#   source(file.path("functions", function.i))
# }
# 
# # # source modules
# modules <- list.files("modules")
# for(module.i in modules){
#   source(file.path("modules", module.i))
# }


# Source Data Setup Script ------------------------------------------------

# source(file.path("script", "data-setup.R"))

gc()