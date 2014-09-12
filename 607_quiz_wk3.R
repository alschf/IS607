## Quiz week 3 IS607

# 1
getAvg <- function(vect)
{
  ans = mean(vect)  
  print(ans)   ## can replace print with return 
}

v = c(1:10)
v
getAvg(v)


######################################################
#2
getAvg <- function(vect)
{
  vect = vect[!is.na(vect)]
  ans = mean(vect)  
  print(ans)   ## can replace print with return
}

v = c(1:10, NA)
v
getAvg(v)


##############################################################
#3
gDV <- function(x,y)
{
  if (x >=y)
  {
    small = y
  }
  else
  {
    small = x
  }
  
  for (i in 1:small)
  {
    if (x%%i == 0 && y%%i == 0)
    {
      gcd = i
    }
  }
  
  print (gcd)  ## can replace print with return
   
}

gDV(12,16)

###########################################
#4

gCD <- function(x,y)   ## the recursive function I translated to R from a java version I found online
{
  if (y == 0)
  {
    print (x)   ## can replace print with return
  }
  else
  {
    gCD(y,x%%y)
    
  }
}

gCD(12,16)

gCD <- function(x,y)  ## this removes the recursion and I wrote from scratch
{
  while (y != 0)
  {
    temp = y
    y = x%%y
    x = temp    
  }
  print (x)    ## can replace print with return
}

gCD(12,16)

############################################
#5

twoInputs <- function(x,y)
{
  return (y*x^2 + 2*x*y - x*y^2)
}

twoInputs(2,3)

################################################
#6

csv1 <- read.table(file = "/home/alexl/R/week-3-price-data.csv", sep = ",",header = TRUE,  stringsAsFactors = FALSE)
csv2 <- read.table(file = "/home/alexl/R/week-3-make-model-data.csv", sep = ",",header = TRUE ,stringsAsFactors = FALSE)
head(csv1)
head(csv2)
csv.merged <- merge(x=csv1, y=csv2, by ="ModelNumber")
csv.merged
## 27 entries
## Is this what I expected?  Yes, in that this is how the R documentation explained it.

######################################################
#7
csv.merged <- merge(x=csv1, y=csv2, by ="ModelNumber", all.x = TRUE)

#######################################################
#8    Only 2010 vehicles
csv.2010 <-subset(csv.merged,  Year ==2010)
csv.2010

##################################################
#9  Only cars > 10000$
csv.red <- subset(csv.merged, Price > 10000 & Color == "Red")
csv.red

###################################################
#10  remove columns 1 & 3
red.rc <- subset(csv.red, select = c("ID", "Mileage", "Price", "Make", "Model", "Year"))
red.rc
class(red.rc$Model)
## or
red.rc <- csv.red[c("ID", "Mileage", "Price", "Make", "Model", "Year")]
red.rc
class(red.rc$Model)
################################################
#11
getLen <- function(vec)
{
  c <-nchar(vec)
  return(c) 
}
v <- c("hope", "This", "workes", "welllllsss")
getLen(v)

###########################################
#12
concat <- function(v1, v2)
{
  if (length(v1)== length(v2))
  {
    new1 <- paste(v1,v2)
    return (new1)
  }
  else
  {
    return ("Error:  vectors are not the same length")
  }
  

}

v1 = c("just", "try", "this")
v2 = c("bob", "john", "okay")
concat(v1,v2)

#####################
#13
new1 <- c()

three <- function(vect)
{
  for (i in vect)
  {
    count = 0
    for (x in 1:nchar(i))
    { 
      l = substring(i,x,x)

      if ((grepl(l, "aeiou")) && count == 0)
      {
         
         new1 <- c(new1,substring(i,x,x+2))
         count = 1
      }    
    }
    if (count == 0)
    {
      new1 <-c(new1,NA)
    }
  }
  return (new1)
}

three(c("oneasdfs", "kkkkaswiioj", "papwww"))

############################################################3
##14

v.1 <- c(1,4,2,1)
v.2 <- c(2,12,21,25)
v.3 <- c(1975, 1934, 2010, 2014)

df <- data.frame(v.1,v.2,v.3)  ## create dataframe
v1 <- c(paste(as.character(df$v.3), as.character(df$v.1), as.character(df$v.2), sep = "-"))
v1 <- as.Date(v1)  ## convert string to date class
v1

df <-data.frame(df,v1)   ## add vector to dataframe   
df
class(df$v1)
colnames(df) <- c("Month", "Day", "Year", "Date")  ## rename the columns
df

###########################################
#15

x <- "04-21-1945"
y <-(strsplit(x, "-"))[[1]]  ## generates a list, and then take first element of the list (the vector)
z <-paste(y[3], y[1], y[2], sep="-")
z
date <- as.Date(z)
date
class(date)

#######################################
#16

date.c <-as.character(date)  #taking date from #15 above
vect <- (strsplit(x,"-"))[[1]]
month <-vect[1]
month

#####################################
#17

result <- seq(as.Date("2005/1/1"), as.Date("2014/12/31"), "day")
result
