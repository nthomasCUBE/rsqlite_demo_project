library(shiny)
library(shinyalert)
library(shinyBS)
library(shinyjs)
library(shinythemes)

options(stringsAsFactors=FALSE)

server <- function(input, output, session)
{
	v <- reactiveValues(file1=NULL)

	#	----------------------------------------------
	#	SQL Table Load
	#	----------------------------------------------
	observeEvent(input$file1,{
		v$file1=input$file1
		shinyalert(title = "SQLite database was uploaded!", type = "success")
		 updateTextAreaInput(session, "caption",
		      label = "label",
		      value = "value")
  	})

	
	#	----------------------------------------------
	#	Go Button
	#	----------------------------------------------
	observeEvent(input$goButton,{
		print(v$file1)
		source("methods.R")
		my_command=input$text1
		load_data(v$file1$name, output, my_command)		
	})
}