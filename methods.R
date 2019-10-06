library(DBI)

load_data=function(my_file, output){
	con <- dbConnect(RSQLite::SQLite(), dbname=my_file)
	print(dbListTables(con))
	res <- dbSendQuery(con,"SELECT * FROM Test;")
	data=dbFetch(res)
	df=as.data.frame(data)
	output$plot=renderPlot({
		par(oma=c(0,8,4,4))
		plot(df[,2],df[,3],cex.lab=1.5,cex=2,col="red",pch=20,xlab=colnames(df)[2],ylab=colnames(df)[3])
	})
}


		