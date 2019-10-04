#install.packages("RSQLite")

options(stringsAsFactors=FALSE)

library(DBI)

con <- dbConnect(RSQLite::SQLite(), ":memory:")

#	----------------------------------------------------------------
#
#	Creating the SQL Table
#
#	----------------------------------------------------------------
data=read.csv("data.txt",sep="\t",header=T)
cmd="CREATE TABLE table1 (";
cn=colnames(data)
cn_all=""
for(x in 1:length(cn)){
	cmd=paste0(cmd,cn[x])
	cmd=paste0(cmd," int")
	cn_all=paste0(cn_all,cn[x])
	if(x!=(length(cn))){
		cmd=paste0(cmd,",")
		cn_all=paste0(cn_all,",")
	}
}
cmd=paste0(cmd,");")
print(cmd)
res <- dbSendQuery(con, cmd)

#	----------------------------------------------------------------
#
#	Storing the entries within the SQL Table
#
#	----------------------------------------------------------------
for(x in 1:dim(data)[1]){
	cmd=paste0("INSERT INTO table1 (")
	cmd=paste0(cmd,cn_all)
	cmd=paste0(cmd,") VALUES(")
	for(y in 1:length(cn)){
		cmd=paste0(cmd,data[x,y])
		if(y!=(length(cn))){
			cmd=paste0(cmd,",")
		}
	}
	cmd=paste0(cmd,");");
	print(cmd)
	dbBegin(con)
	res <- dbSendQuery(con, cmd)
	dbClearResult(res)
	dbCommit(con)
}
dbListTables(con)

res <- dbSendQuery(con,"SELECT * FROM table1;")
print(dbFetch(res))
res <- dbSendQuery(con,"SELECT A,SUM(B) FROM table1 GROUP BY A;")
my_d=(dbFetch(res))
barplot(my_d[,2],names=my_d[,1],col=1:length(my_d[,1]))	




