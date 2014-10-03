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
page <- html("http://adventure.nationalgeographic.com/adventure/trips/americas-best-adventures/climb-new-york-gunks/")
## Below I extract the articles title
article.title <- page %>% 
  html_nodes("title") %>%
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
## Optional #1

# list all available demos
demo(package="rvest") 
# lists code for tripadvisor demo; follow instructions 
# in your RStudio console window.
demo("tripadvisor", "rvest") 

#########################################################
library(RCurl)
library(XML)

page <- readHTMLTable("http://www.mountainproject.com/v/cathedral-ledge/105908823")
page
# Interestingly, the table I extracted with rvest isn't 'page' when extracted by readHTMLTable...


page <- readLines("http://adventure.nationalgeographic.com/adventure/trips/americas-best-adventures/climb-new-york-gunks/")
page ## very nice a huge 'list' of each line which can be sliced by line
title <-page[grep("<title", page)]  
title ## which yeilds title, albiet needing some cleaning up


