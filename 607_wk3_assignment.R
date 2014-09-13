# 607 week 3 assignment

###########################
#1

FindNumNA <- function(v)
{ 
  sum = 0
  for (i in 1:length(v))
  {
    if (is.na(v[i]))
    {
      sum = sum +1
    }
  }
  return (sum)
}

vect <- c(NA, NA, 5, 6, 3, NA)

FindNumNA(vect)

####################################
#2
FindNADf <- function(d)
{
  v <- c(1:ncol(d))
  print (v)
  for (i in 1:ncol(d))
  {
    v[i] <- FindNumNA(d[,i])
    names(v)[i] <- colnames(d)[i]
  }
  return (v)
}

x <- c(NA, 8, NA, 10, 9)
y <- c(5, NA, NA, 4, NA)
z <- c(8,4,5,3,3)
df <- data.frame("first" = x, "sec" = y, "third" = z)
FindNADf(df)

##############################################
#3

GetMean <- function(v)
{
  sum =  0
  v<- v[!is.na(v)]
  for (i in 1:length(v))
  {
    sum = sum + v[i]
  }
  return (sum/length(v))
}


GetMean(vect)

GetMedian <- function(v)
{
  v<- v[!is.na(v)]
  v <- sort(v)
  if (length(v)%% 2 == 0)
    {
        return((v[as.integer(length(v)/2)] + v[1 + as.integer(length(v)/2)])/2)
    }
  else
  {
    return (v[1+ as.integer(length(v)/2)])
  }
}

GetMedian(vect)

GetFirstQ <- function(v)
{
  
  med <- GetMedian(v)
  newv <- v[v < med]
  return (GetMedian(newv))
}

GetThirdQ <- function(v)
{
  
  med <- GetMedian(v)
  newv <- v[v > med]
  return (GetMedian(newv))
}

GetSD <- function (v)
{
  v<- v[!is.na(v)]
  m <- GetMean(v)
  sum = 0
  for (i in 1:length(v))
  {
    sum = sum + (v[i]-m)^2
  }
  return ( (sum/length(v))^0.5)
  
}
GetFirstQ(vect)
GetThirdQ(vect)
vect <- c(NA, NA, 8, 9, 10, NA)
GetSD(vect)

GetStats <- function(vect)
{
  x <- list(1, 2, 3, 4, 5, 6)
  names(x) <- c("Mean", "Median", "FirstQ", "ThirdQ", "SD", "Num.NA")
  x[1] <- GetMean(vect)
  x[2] <- GetMedian(vect)
  x[3] <- GetFirstQ(vect)
  x[4] <- GetThirdQ(vect)
  x[5] <- GetSD(vect)
  x[6] <- FindNumNA(vect)
  return (x)   
}
vect <- c(1:100, NA)
GetStats(vect)

######################################################
#4

GetValues <- function(f)
{ 
  list1 <- list(1,2,3,4)
  list1[1] <- nlevels(f)
  t <- table(f)   ## table allows access to levels and names
  largest = 1
  for (i in 1:length(t))  ## determine largest level number and match to name
  {
    if (as.numeric(t[i]) > as.numeric(t[largest]))
    {
      largest = i
    }
  }
  list1[3] <- (as.numeric(t[largest]))
  list1[2] <- rownames(t)[largest]
  for (i in 1:length(t))  ## this loop determines any ties!
  {
    if (as.numeric(t[i]) == as.numeric(t[largest]) && i != largest)
    {
      list1[2] <- paste(list1[2], rownames(t)[i], sep= " & ")
    }
  }
  list1[4] <- findNumNA(f)
  names(list1) <- c("Unique.values", "Name.maxvalue(s)", "Num.maxvalue", "Num.NA")
  return (list1)
  
}
f <- as.factor(c("what", "why", "what", "that", NA, NA, "that", "that", "this"))
GetValues(f)

##################################################
#5  *** uses function findNumNA from question #1

GetTrueFalse <- function(v)
{
  l <-list(1,2,3,4)
  l[4] <- findNumNA(v)   ### function from Q1 of this assignment
  v <- v[!is.na(v)]
  l[1] <-length(v[v])
  l[2] <- length(v[!v])
  l[3] <- l[[1]]/l[[2]]
  
  names(l) <- c("Num.TRUE", "Num.FALSE", "Ratio.TrueFalse", "Missing.Values")
  return (l)
  
}

vect <- c(TRUE, FALSE, TRUE, TRUE, FALSE, NA)
vect <-c(1,2,3, 0, NA)
ans <- GetTrueFalse(vect)
ans
class(ans)

###############################################################
#6

ComboF <- function(df)
{
  l <- as.list(c(1:ncol(df)))
  print (l)
  for (i in 1:ncol(df))
  {
    names(l)[i] <-c(colnames(df)[i])
    v <-c(GetStats(df[,i]), GetValues(df[,i]), GetTrueFalse(df[,i]))
    l[[i]] <- v
  }
  return (l)
  
}


x <- c(NA, 8, NA, 10, 9)
y <- c(5, NA, NA, 4, NA)
z <- c(8,4,5,3,3)
df <- data.frame("first" = x, "sec" = y, "third" = z)

list1 <-ComboF(df)
list1[1]

