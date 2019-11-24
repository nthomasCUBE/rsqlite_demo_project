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
	
		con <- dbConnect(RSQLite::SQLite(), dbname=input$file1$name)
		my_tables=(dbListTables(con))

		arr=c()
		for(x in 1:length(my_tables)){
			res <- dbSendQuery(con,paste0("SELECT sql FROM sqlite_master WHERE tbl_name = '",my_tables[x],"' AND type = 'table'"))
			data=dbFetch(res)
			arr=c(arr,data)
		}

		updateTextAreaInput(session, "caption",
		      label = "label",
		      value = paste(arr))
		
  	})

	#	----------------------------------------------
	#	Go Button
	#	----------------------------------------------
	observeEvent(input$goButton,{
		print(v$file1)
		source("methods.R")
		my_command=input$text1
		print(c("vis1::",input$vis1))
		load_data(v$file1$name, output, my_command, input$vis1)		
	})
}