


embedd_app <- function(app_url){
  
  iframe_html <- create_app_iframe(app_url)
  overall_html <- glue::glue("
<br>
{iframe_html}")
  
  htmltools::HTML(overall_html)
}


#' Create an HTML iframe that embedds the app within the rmarkdown document
#' 
#' @param app_url a URL to a deployed app
#' 
#' @keywords internal
create_app_iframe <- function(app_url){
  # app_id <- paste0("container_", basename(app_url))
  iframe_html <- glue::glue("
<div id=\"container\"
  style=\"position:relative; display:block; width: 100%\">
  <iframe src=\"{app_url}\" 
      style=\"border: 2px solid #007319; width: -webkit-fill-available; height: 660px; position: relative; z-index: 2;\"
      frameborder=\"0\" data-external=\"1\" allowfullscreen = \"\" webkitallowfullscreen = \"true\" mozallowfullscreen = \"true\">
  </iframe>
</div>")
  
  return(iframe_html)
}



#' Create an HTML button to expand the app to full screen
#' 
#' @param app_url a URL to a deployed app
#' 
#' @keywords internal
create_fullscreen_btn <- function(app_url, btn_font_color = "white"){
  icon_max <- fa("maximize", fill = btn_font_color)
  btn_html <- paste(
    "<div class=\"fullscreen-btn-container\"\">",
    glue::glue("<a href=\"{app_url}\" target=\"_blank\" class=\"btn-custom\" role=\"button\">{icon_max} Full Screen</a>"),
    "</div>"
  )
  
  return(HTML(btn_html))
}
