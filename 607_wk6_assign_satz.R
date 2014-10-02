## 607 week 6 assignment
## Author:  Alex Satz
## Oct 2 2014


install.packages("devtools")
library(devtools)
install_github("hadley/devtools")
install_github("hadley/rvest")
library(rvest)
##########################################################
## A article I recently saw...
page <- html("http://www.dddmag.com/news/2014/10/discovery-helps-spot-what-makes-good-drug?et_cid=4186194&et_rid=416384129&location=top")

## Below I extract the articles title
article.title <- page %>% 
  html_nodes("h") %>%
  html_text() 
article.title


################################################################################
## I wanted to try a table.  Below the weather forcast is extracted
table1 <- html("http://www.mountainproject.com/v/cathedral-ledge/105908823")
table2 <- table1 %>%
  html_nodes("table") 
forecast <- html_table(table2[[4]], fill = TRUE)

## and a little cleaning up
forecast.new <- data.frame()
for (i in 1:ncol(forecast))
{
  forecast.new[1,i] = forecast[1,i]
  forecast.new[2,i] = gsub("\n\t\t|\n\t\t", "", forecast[2,i])
}
forecast.new

#############################################################
## I'll do the optional stuff later on...guess I don't have to turn it in.

