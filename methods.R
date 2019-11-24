library(ggplot2)
library(grid)
library(gridExtra)
library(DBI)

load_data=function(my_file, output, sql_command, vis_type){
	con <- dbConnect(RSQLite::SQLite(), dbname=my_file)
	print(dbListTables(con))
	print(sql_command)
	res <- dbSendQuery(con,sql_command)
	data=dbFetch(res)
	df=as.data.frame(data)
	
	if(vis_type=="dotplot"){
		output$plot=renderPlot({

			if(dim(df)[2]==3){
				par(oma=c(0,8,4,4))
				plot(df[,2],df[,3],cex.lab=1.5,cex=2,col="red",pch=20,xlab=colnames(df)[2],ylab=colnames(df)[3])
				print("2 conditions, correlation is used")
			}else if(dim(df)[2]>3){
				print("More conditions - PCA needed")
				M=df[,2:dim(df)[2]]
				for(x in 1:dim(M)[2]){
					M[,x]=as.numeric(M[,x])
				}
				df_pca <- prcomp(M)
				df_out <- as.data.frame(df_pca$x)
				p<-ggplot(df_out,aes(x=PC1,y=PC2))
				p<-p+geom_point()
				print(p)
			}else{
				print("Insufficient dimension (e.g. conditions")
			}
		})
	}else{
		output$plot=renderPlot({
			print(df)
			A=(unlist(df[,2:dim(df)[2]]))
			B=c()
			for(x in 2:dim(df)[2]){
				B=c(B,rep(colnames(df)[x],length(A)))
			}
			df_n=data.frame(expr=A,condition=B)
			print(df_n)
			#boxplot(df[,2:dim(df)[2]],names=colnames(df)[2:length(colnames(df))])
			p <- ggplot(df_n, aes(x=condition, y=expr, color=condition)) +   geom_boxplot()	
			p <- p + geom_jitter(shape=16, position=position_jitter(0.2))
			print(p)
		})
	}
}


		