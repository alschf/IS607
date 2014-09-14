## Project Week 3
##################    ENTROPY  ##############################
#1
file <- read.table(file = "/home/alexl/Documents/MSDA/IS607/week3/entropy-test-file.csv", sep = ",", header = TRUE)


Entropy <- function(v)
{
  sum = 0
  count <- length(v)
  v <- as.factor(v)
  t <- table(v)
  t <-as.vector(t)
  for (i in 1:length(t))
  {
    sum <- sum + (((t[i])/count) * log2(t[i]/count))
  }
  return ((-sum))
  
}
#vect <- c(2,3,5,8,8,8)
#Entropy(vect)

################################
#2

InfoGain <-function(a,d)
{
  t <-table(a)
  ##print (t)
  t.num <- as.vector(t)
  t.name <- names(t)
  v <-vector()
  df <-file[,c(i,ncol(file))]
  df <-data.frame(a,d)
  n <- nrow(df)
  sum = 0
  for (j in 1:length(t))
  { 
    df.sub <- df[df[,1]== t.name[j],]
    values <- df.sub[,2]
    ent <- Entropy(values)
    ##print ("ent is")
    ##print (ent)
    n.j <- nrow(df.sub)
    njon <- n.j/n
    sum <-sum + ent*njon
    ##print ("sum is")
    ##print(sum)
  } 
  return ((Entropy(file[,ncol(file)]))-sum)
}

#InfoGain(file[,2], file[,4])

############################################
#3

Decide <- function(df, x)
{
  v <- vector()
  l <- list(1,1)
  max <-0
  index <-1
  for (i in 1: ncol(df))
  {
    if (i != x)
    {
      gain <- InfoGain(df[,i], df[,x])
      v <- c(v,gain)
      label <- paste("attr", as.character(i))
      names(v)[length(v)] <-c(label)
      if (gain > max)
      {
        max <- gain
        index <- i
      }   
    } 
    l[[1]] <- index
    l[[2]] <- v
    names(l)<-c("max", "gains")
  }
  return (l)
    
}

Decide(file, 4)


