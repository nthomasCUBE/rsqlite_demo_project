library(DBI)

load_data=function(my_file){
	con <- dbConnect(RSQLite::SQLite(), dbname=my_file)
	print(dbListTables(con))
	res <- dbSendQuery(con,"SELECT * FROM Test;")
	data=dbFetch(res)
}


		