
##1
vec1 <-c(1:10)
vec1 <-c(vec1,vec1)
length(vec1)
vec1

##2
v.char <- as.character(vec1)
v.char


## 3
v.factor <- as.factor(vec1)
v.factor


## 4
nlevels(v.factor)


##
## 5
v.arith <- c(3*(vec1^2) - 4*vec1 + 1)
v.arith



## 6
x1 <- rep(1,8)
x2 <- c(5,4,6,2,3,2,7,8)
x3 <- c(8,9,4,7,4,9,6,4)
x <-c(x1,x2,x3)
X <- matrix(x, nrow = 8)
y1 <- c(45.2,46.9, 31.0, 35.3, 25.0, 43.1, 41.0, 35.1)
y.mat <- matrix(y1)
b.hat <- solve(t(X)%*% X) %*% t(X) %*% y.mat
b.hat


##
## 7
list1 <-list(first = 1, second = 2, third = 3)
list1
list1$third


## 8
d1 <- c(2,2, 4, 5)
d1 <- as.character(d1, d1, d1)
d1
d.cha <- d1
d2 <- c("yes", "no", "maybe", "no")
d2 <- c(d2,d2,d2)
d2 <- as.factor(d2)
d2
d.fac <- d2
d3 <- c(2,2, 4, 5)
d3 <- c(d3,d3,d3)
d3
d.num <-d3
d4 <- c("2014-05-12", "2014-06-12","2014-07-12","2014-04-12")
d4 <- c(d4, d4, d4)
d4 <- as.Date(d4)
d.date <- d4
d.df <- data.frame(d.cha, d.fac, d.num, d.date)
d.df

## 9
newrow <- data.frame(d.cha = "56", d.fac = "perhaps", d.num = 76, d.date = as.Date("2013-09-06"))
newrow
d.df <-rbind(d.df, newrow)
d.df

## 10
tempFile <- read.csv("temparture.csv")


## 11    Note the forward slash being in linux
tempFile <- read.table(file = "/home/alexl/temp/measurements.txt", sep = "\t")

#12
aUrl <- "http://www.madeup.com/data/temperatures.csv"
tempFile <- read.table(file = aUrl, sep = "|")

#13
sum = 1
for (i in 1:12)
{
  sum = sum * i
}
sum

## 14

bal = 1500
for (y in 1:6)
{
  for (m in 1:12)
  {
    bal = bal + bal*0.0324/12
  }
}
bal
round(bal, digits = 2)

#15

v <- c(1:20)
for (x in 1:length(v))
{
  if (x%%3 == 0)
  {
    sum = sum + v[x]
  }
}
sum

#16
sum = 0
for (x in 1:10)
{
  sum = sum + 2^x
}
sum

#17
sum = 0
x = 1
while (x < 11)
{
  sum = sum + 2^x
  x = x +1
}
sum

#18   Not sure if this is what you want...
v <- c(2, 4, 8, 16, 32, 64, 128, 256, 2^9, 2^10)
sum(v)

#19
v <-c(seq(20,50, by = 5))
v

#20
v.cha <- rep("example", 10)
v.cha

#21
a = 1
b = 7
c = 10

x = (-b + sqrt(b^2- 4*a*c))/2*a
x2 = (-b - sqrt(b^2- 4*a*c))/2*a
x
x2


