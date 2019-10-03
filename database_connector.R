#install.packages("RSQLite")

options(stringsAsFactors=FALSE)

library(DBI)

con <- dbConnect(RSQLite::SQLite(), ":memory:")

data=read.csv("data.txt",sep="\t",header=T)
print(data)
print(cn)
cmd="CREATE TABLE table1 (";
cn=colnames(data)
for(x in 1:length(cn)){
	print(cn[x])
	cmd=paste0(cmd,cn[x])
	cmd=paste0(cmd," varchar")
	if(x!=(length(cn))){
		cmd=paste0(cmd,",")
	}
}
cmd=paste0(cmd,");")
print(cmd)

# Creating a SQLite table
res <- dbSendQuery(con, cmd)

#res <- dbSendQuery(con, "INSERT INTO table2 VALUES (1,'val1');")
#res <- dbSendQuery(con, "INSERT INTO table2 VALUES (2,'val2');")
#res <- dbSendQuery(con, "SELECT * FROM table2;")
#print(dbFetch(res))

dbListTables(con)


