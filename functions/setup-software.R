


#' Gather about sections from each app and return their paths relative to the current working directory
#' 
#' Used in `docs/index.Rmd`
#' 
#' @param shiny_dir directory containing shiny apps. Assumes an `about.Rmd` file is in the first level (`app_name/about.Rmd`).
#' @param current_dir current working directory.
#' @param overwrite Logical (T/F). If `TRUE`, overwrite existing **generated** about sections (in `/docs`).
#' 
#' @keywords internal
get_about_sections <- function(shiny_dir = here::here("shiny_apps"), current_dir = getwd(), overwrite = TRUE){
  
  shiny_apps <- fs::dir_ls(shiny_dir, recurse = FALSE)
  
  # Get about sections and deployment URLs
  about_mds <- fs::dir_ls(shiny_apps, recurse = 1, glob = "*about.md")
  deploy_urls <- fs::dir_ls(shiny_apps, recurse = 1, glob = "*deployment_url.txt") %>% 
    purrr::map_chr(readLines) %>% suppressWarnings()
  
  ### Checks ###
  # Make sure each app has exactly one deployment URL
  checkmate::assert_true(length(deploy_urls) == length(shiny_apps))
  # Make sure each app has exactly one about section
  checkmate::assert_true(all(dirname(about_mds) == shiny_apps))
  
  # Read in markdown about sections
  about_lines <- purrr::map(about_mds, ~{
    lines <- .x %>% readLines() %>% suppressMessages() %>% trim_empty_quotes() %>%
      paste(collapse = "\n")
  })
  
  # Organize output
  about_sections <- tibble::tibble(
    shiny_app_dir = dirname(about_mds), 
    deploy_url = deploy_urls,
    src_about_md = about_mds, 
    app_description = unname(about_lines)
  )
  
  about_sections <- about_sections %>%
    dplyr::mutate(
      app_id = 1:n(),
      shiny_app_dir = basename(shiny_app_dir),
      src_about_md = as.character(fs::path_rel(src_about_md, current_dir)),
      app_name = format_app_name(shiny_app_dir, reverse = TRUE)
    ) %>%
    dplyr::relocate(app_id, app_name)
  
  
  # Create formatted about sections, including app iframe and buttons
  list_data <- split(about_sections, seq(nrow(about_sections)))
  gen_about_rmds <- purrr::map_chr(list_data, ~{
    create_about_section(
      deployment_url = .x$deploy_url,
      app_name = .x$app_name,
      app_description = .x$app_description,
      overwrite = overwrite
    )
  })
  
  about_sections <- about_sections %>% dplyr::mutate(about_rmd = as.character(fs::path_rel(gen_about_rmds, current_dir))) %>%
    dplyr::select(-c(app_description, deploy_url))
  
  return(about_sections)
}

#' Creates an about section rmarkdown document that embeds the app and other HTML buttons
#' 
#' @param deployment_url URL to deployed app. This is wrapped in an `iframe`.
#' @param app_name User facing app name.
#' @param app_description App description. To be included in the `Description` tab of the app.
#' @param overwrite Logical (T/F). If `TRUE`, overwrite existing **generated** about sections (in `/docs`).
#' 
#' @keywords internal
create_about_section <- function(
    deployment_url = "<deployment_url>",
    app_name = "app name",
    app_description = "app description",
    overwrite = FALSE
){
  about_template <- here::here("script", "about_template.qmd")
  about_lines <- readLines(about_template) %>% paste(collapse = "\n")
  about_lines <- about_lines %>% glue::glue(.open = "{{", .close = "}}")
  
  # Temporary directory for quarto docs
  about_dir <- tempfile(pattern = "about_tabs-")
  if(!fs::dir_exists(about_dir)) fs::dir_create(about_dir)
  
  about_name <- paste0(format_app_name(app_name), "-about.qmd")
  about_path <- file.path(about_dir, about_name)
  # about_path <- here::here("docs", about_name)
  
  
  if(!fs::file_exists(about_path) || isTRUE(overwrite)){
    writeLines(about_lines, about_path)
  }else{
    message(glue::glue("File Exists: {about_path}\n Skipping over. Pass `overwrite = TRUE` to overwrite"))
  }
  
  about_path <- fs::path_real(about_path)
  
  return(about_path)
}

#' Formats app name to about.Rmd file path name
#'
#' Replaces spaces with dashes (`-`) and makes everything lowercase
#'
#' @param app_name character string.
#' @param reverse Logical (T/F). If `TRUE`, reverse the operation and capitalize the first letter of each word.
#'
#' @keywords internal
format_app_name <- function(app_name, reverse = FALSE){
  new_names <- if(isTRUE(reverse)){
    gsub("-", " ", app_name) %>% stringr::str_to_title()
  }else{
    gsub(" ", "-", app_name) %>% stringr::str_to_lower()
  }
  
  return(new_names)
}

#' Trim empty quotes from beginning and end of a vector
#' 
#' @param lines a vector of character elements
#' 
#' @keywords internal
trim_empty_quotes <- function(lines) {
  while (length(lines) > 0 && lines[1] == "") {
    lines <- lines[-1]  # Remove empty quote at the beginning if present
  }
  while (length(lines) > 0 && lines[length(lines)] == "") {
    lines <- lines[-length(lines)]  # Remove empty quote at the end if present
  }
  return(lines)
}
