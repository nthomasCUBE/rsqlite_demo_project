# rsqlite_demo_project

## Installation

### Preinstallation of two packages:
1. Shiny
2. RSQLite (install.packages('RSQLite')

```source('ui.R')
source('server.R')
source('methods.R')
shinyApp(ui,server)
```

## rsqlite_demo_project
storing data into sqlite database

Few examples for storing data into a textbased sqlite databse

![alt text](https://github.com/nthomasCUBE/rsqlite_demo_project/blob/master/Figure1v5.png)

'''
select name,expr1,expr2 from Test where name LIKE 'gene1%'
'''

### ... of course two conditions...
![alt text](https://github.com/nthomasCUBE/rsqlite_demo_project/blob/master/Figure1v5c.png)

### ... also more conditions can be shown and compared
![alt text](https://github.com/nthomasCUBE/rsqlite_demo_project/blob/master/Figure1v5b.png)
