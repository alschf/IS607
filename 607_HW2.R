## Week 2 Homework

###############################################3
## 1a
queue <- c("James", "Mary", "Steve", "Alex", "Patricia")
queue

# 1b
queue <- c(queue, "Harold")
queue

#1c
queue <- queue[-1]
queue

#1d
queue <-append(queue, "Pam", 1)
queue

#1e   granted, this would remove all Alex entries if multiplies existed
#     in that case best to use the match function
queue <- queue[queue != "Alex"]
queue

#1g     note that "Patricia" %in% queue would return TRUE
##      but R doesn't throw an error...
match("Patricia", queue)


#1h
length(queue)

##########################################################################
#2
##  Note that I didn't use the descriminant 
##  assumed you wanted the values too

a = 100
b = -4
c = 1
x = "No Real Solutions"  
x2 = "none"

if (b^2-4*a*c >= 0)
{
  x = (-b + sqrt(b^2- 4*a*c))/2*a
  x2 = (-b - sqrt(b^2- 4*a*c))/2*a
} 

if (x2 == "none")   
{
  print ("There are no Real Solutions")
} 

if (x == x2)
{
  ans <- "There is one Real Solution: "
  ans <- paste(ans, as.character(x))
  print (ans)
} 

if (x != x2 && x2 != "none")
{
  ans <-"There are two Real Solutions: "
  ans <- paste(ans, as.character(x))
  ans <- paste(ans, " and ", as.character(x2))
  print (ans)
}
  

#3
sum = 0
for (i in 1:1000)
{
  if (i%%3 != 0 && i%%7 != 0 && i%%11 !=0)
  {
    sum = sum+1
  }
}
sum
############################################################
#4

f = 3
g = 4
h = 5


v <- c(f,g,h)
v <- sort(v)
if (v[3]^2 == v[1]^2 + v[2]^2)
{
  print( "Yes, its a triple")
}else
{
  print( "No its not a triple")
}

