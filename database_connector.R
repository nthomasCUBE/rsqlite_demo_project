install.packages("RSQLite")

library(DBI)

con <- dbConnect(RSQLite::SQLite(), ":memory:")

res <- dbSendQuery(con, "CREATE TABLE table2 (ID integer, NAME varchar);")
res <- dbSendQuery(con, "INSERT INTO table2 VALUES (1,'val1');")
res <- dbSendQuery(con, "INSERT INTO table2 VALUES (2,'val2');")
res <- dbSendQuery(con, "SELECT * FROM table2;")
dbFetch(res)

dbListTables(con)


