# week6quiz.R
# [For your convenience], here is the provided code from Jared Lander's R for Everyone, 
# 6.7 Extract Data from Web Sites

install.packages("XML")
require(XML)
require(dplyr)
theURL <- "http://www.jaredlander.com/2012/02/another-kind-of-super-bowl-pool/"
bowlPool <- readHTMLTable(theURL, which = 1, header = FALSE, stringsAsFactors = FALSE)
bowlPool$V1

# 1. What type of data structure is bowlpool? 
#  A data.frame

# 2. Suppose instead you call readHTMLTable() with just the URL argument,
# against the provided URL, as shown below

theURL <- "http://www.w3schools.com/html/html_tables.asp"
hvalues <- readHTMLTable(theURL, which = 6)
hvalues

# What is the type of variable returned in hvalues?
##    a list of data.frames

# 3. Write R code that shows how many HTML tables are represented in hvalues

count = 0
for (x in hvalues)
{
  if (length(x) != 0)   ## count by not null
  {
    count = count + 1
  }
}

print (count)
#############
count = 0
for (x in hvalues)
{
  if (is.data.frame(x))  ## or count by is a data.frame
  {
    count = count + 1
  }
}

print (count)
  



# 4. Modify the readHTMLTable code so that just the table with Number, 
# FirstName, LastName, # and Points is returned into a dataframe

hvalues <- readHTMLTable(theURL, which = 1)
hvalues

# 5. Modify the returned data frame so only the Last Name and Points columns are shown.

select(hvalues, `Last Name`, Points)  ## tricky, back ticks are need for whitespace...

# 6 Identify another interesting page on the web with HTML table values.  
# This may be somewhat tricky, because while
# HTML tables are great for web-page scrapers, many HTML designers now prefer 
# creating tables using other methods (such as <div> tags or .png files).  
theURL <- "http://www.rockclimbing.com/routes/North_America/United_States/New_York/Upstate/The_Gunks/"
tables <- readHTMLTable(theURL)
tables

# 7 How many HTML tables does that page contain?

## I get 5 counting by dataframes or Null values.  
## going to the HTML source, I see 5 'tables' 
count = 0
for (x in tables)
{
  if (length(x) != 0)   ## count by not null
  {
    count = count + 1
  }
}

print (count)
#############
count = 0
for (x in tables)
{
  if (is.data.frame(x))  ## or count by is a data.frame
  {
    count = count + 1
  }
}

print (count)

# 8 Identify your web browser, and describe (in one or two sentences) 
# how you view HTML page source in your web browser.

## its chrome.  I  >>developer and then >>view source.