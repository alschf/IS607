##Week 5 Assignment  Cullen skink over Partan bree

#1
#Three Questions
#    percentage yes votes in each city 
#    percentage yes votes in each age
#    Total yes and total no

#########################################################################
#2  Create the data frame
a <- c("Yes", "No")
b <- c(80124,35900)
c <- c(14300,214800)
d <- c(99400,4300)
e <- c(150400,20700)
df <- data.frame("Vote"= a, "YEdin"= b, "OEdin"= c, "YGlas" = d, "OGlas" = e)
df 

#############################################################################
#3  use tidyr to tidy the data
df.good <-df %>%
  gather(key, value, YEdin:OGlas) %>%
  separate(key, c("age", "city"), -5) %>%
  spread(Vote, value)
df.good <-arrange(df.good, city, age)
df.good

##############################################################################
#4a  I use dplyr and plyr.  Below is dplyr.  
##      **summarize function does not work properly if plyr is loaded!!!  

df.good <-mutate(df.good, 
       Perc.Yes = 100*Yes/(Yes+No))
df.good

#total % yes votes
summarize(df.good,
          Perc.Yes.total = 100*sum(Yes)/(sum(Yes) +sum(No)))

# % yes votes by age
perc.yes.byage <- group_by(df.good, age)
perc.yes.byage
summarize(perc.yes.byage,
          Perc.Yes = 100*sum(Yes)/(sum(Yes) +sum(No)))

# % yes by cit
perc.yes.bycity <- group_by(df.good, city)
summarize(perc.yes.bycity,
          Perc.Yes.total = 100*sum(Yes)/(sum(Yes) +sum(No)))

#4b.  % yes by age using plyr
df.good.age <-ddply(df.good,c ("age"),function(x)
{
  sum.y <- sum(x$Yes)
  sum.n <- sum(x$No)
  PercY <- 100*sum.y/(sum.n + sum.y)
  data.frame(perc.yes = PercY)
})
df.good.age   

#4b.  % yes by city using plyr
df.good.city <-ddply(df.good,c ("city"),function(x)
{
  sum.y <- sum(x$Yes)
  sum.n <- sum(x$No)
  PercY <- 100*sum.y/(sum.n + sum.y)
  data.frame(perc.yes = PercY)
})
df.good.city

######################################################
#5  Anything I would change

#No.  I gave some thought before working, hit an issue where I didn't have one
##    obs per row, and then changed things around till it looked better.
##    It was helpful to actuall do the work and see the actual result.