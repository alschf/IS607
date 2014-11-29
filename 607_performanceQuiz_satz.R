## Alex Satz
## Nov 29 2014
## IS607 performance  Quiz

## Part I.

library(Rcpp)
library(microbenchmark)


## the function below was taken from Hadley's book as a test
cppFunction('int add(int x, int y, int z) {
  int sum = x + y + z;
  return sum;
}')

add(1, 2, 3)

## and this function I wrote.  It replaces the number 10 with the number 9.
## Granted, not that usefull...I wanted to use the '%' to get a remainder, but 
## I cannot get this to work with cppFunction?
cppFunction('NumericVector allodd(NumericVector x)
{
    int n = x.size();
    for(int i = 0; i < n; ++i) {
    if (x[i] == 10){
    x[i]= 9;
    }
  }
    
    return x;
   
}')


## This does the same thing in 'R'
rallodd <-function(vec){
  for (i in 1:length(vec)){
    if (vec[i] == 10){
      vec[i] = 9
    }
  }
  return (vec)
}

## This function creates a new vector instead assigning values inplace.
rallodd2 <-function(vec){
  temp <-0
  for (i in 1:length(vec)){
    if (vec[i] == 10){
      temp[i] = 9
    }
    else{
      temp[i] = vec[i]
    }
  }
  return (temp)
}

v <- runif(10, 8,12)
v <- as.integer(v)

x <-allodd(v)

microbenchmark(newv <-allodd(v))
microbenchmark(newv <-rallodd(v))
microbenchmark(newv <-rallodd2(v))

## C++ takes 6.7 microseconds, R with single vector takes 20 usec, 
## R generating new vector takes 39 usec.

##########################################################################################



