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
	})

	
	#	----------------------------------------------
	#	Go Button
	#	----------------------------------------------
	observeEvent(input$goButton,{
		print(v$file1)
		source("methods.R")
		load_data(v$file1$name, output)		
	})
}