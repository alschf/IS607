## Week 6 DataScience Context
## Author:  Alexander Satz
## Created:  Oct 2 2014


######################################
##  1
##  http://en.wikipedia.org/w/api.php,http://www.mediawiki.org/wiki/API:Main_page

##  2
##  research company data, commercial products, geographical information, proteins, pharmaceuticals...
##  Wiki has nearly everything, although in many cases it may not be the best reference.

##  3
##  Hard to know what format the data will be stored in.  Company names may redirect to other pages and
##  leading to poor results (ie  Ford redirect to Ford Motor Company)

##  4
##  This program takes a vector of company names and pulls out the number of employees at that company
##  The method of working up the parsed XML is less than perfect...

install.packages('RJSONIO')
install.packages('RCurl')
library(RCurl)
library(RJSONIO)

getEmp <- function(company)
{
  search_example <- getForm("http://en.wikipedia.org/w/api.php", action  = "parse",page= company,prop = "wikitext",format  = "xml",.opts = list())
  start <- regexpr("num_employees", search_example[1], ignore.case = TRUE)
  if (as.integer(start) == -1)
  {
    start <- regexpr("Employees", search_example[1], ignore.case = TRUE)
  }
  if (as.integer(start) == -1)
  {
    return ("NA")
  }
  
  d = search_example[1]
  numb = substr(d, start+9, start+13+30)
  split = strsplit(numb, " ")
  
  split = split[[1]]
  split = gsub(",", "", split)
  index = 1
  for (i in 1:length(split))
  {
    split[i] = as.integer(split[i])
  }
  value = split[!is.na(split)]
  return (value)
  
 
}

company.v = c("Pfizer", "IBM", "AstraZeneca", "Miele", "Facebook", "Ford Motor Company")
Emp.list <- list()


for (i in 1:length(company.v))
{
  Emp.list <- c(Emp.list, getEmp(company.v[i]))
}
names(Emp.list) <- company.v
Emp.list


## 5
## the wiki api and very complex.  More examples would be helpfull.  Also the parsed XML object that
## is returned is difficult to work with, as its a big string...

