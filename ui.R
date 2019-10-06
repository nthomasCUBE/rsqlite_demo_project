library(shiny)
library(shinyalert)
library(shinyBS)
library(shinyjs)
library(shinythemes)

options(stringsAsFactors=FALSE)
options(stringsAsFactors=FALSE)
options(shiny.maxRequestSize = 50*1024^2)

ui <- fluidPage(  

tags$head(
	tags$style(HTML("
	.shiny-output-error {
	visibility: hidden;
}
.a {
    color: #555;
    cursor: default;
    background-color: #ff000044;
    border: 1px solid #ddd;
    border-bottom-color: transparent;
}
body {
	background-color: #23443333;
	font-size: 22px;
}
input {
  font-family: 'Lobster', cursive;
  font-weight: 500;
  line-height: 1.1;
  color: #ad1d28;
}
button {
   background-color: #ff0000;
   color: #ff0000;
}
body, label, input, button, select { 
	font-family: 'Arial';
}"))
  ), 
   useShinyjs(), useShinyalert(), 
	sidebarLayout(
		sidebarPanel(
		tabsetPanel(id = "tabset",
		tabPanel("SQLite demo",
			fileInput("file1", "SQLite database", multiple = TRUE, accept = c("text/text", ".db",".sqlite")),
			textInput("text1","SQL command",value="",width=NULL,placeholder="Enter SQL command..."),
			textAreaInput("caption", "Content", "", height = "300px"),
			actionButton("goButton", "Analyse dataset!")))),
		mainPanel(
			useShinyjs(),
			plotOutput(outputId = "plot")
		)
	)
)