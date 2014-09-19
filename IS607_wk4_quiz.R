file <- read.table(file = "/Users/alexandersatz/Documents/Cuny/IS607/week4/movies.tab", fill = TRUE, sep = "\t", header = TRUE, stringsAsFactors=FALSE)


##################################################################
#1
decade <- paste(as.character(as.integer((file$year/10))*10), "'s")
decade <- gsub(" ", "", decade)  ## get rid of whitespace
file2 <- data.frame(file, decade) 
ggplot(data = file2) + geom_histogram(aes(x=decade))

#################################################################
#2
Type <- rep(NA, nrow(file2))
for (i in 1:nrow(file2))
{
  for (x in 18:24)
  {
    if (!is.na(file2[i,x]) && file2[i,x] == 1)
    {
      Type[i] <- paste(Type[i], colnames(file2)[x], sep = ":")
    }
  }
}
Type <- gsub("NA:", "", Type)
file3 <- data.frame(file2, Type)
##head(file3)
t<-table(Type)
rating.type <- file3[, c("rating", "Type")]
##head(rating.type)

rating.decade <-file3[, c("rating", "decade")]
rating.decade
avgRating.decade <-ddply(rating.decade,c ("decade"),function(x)
{
  avg <- mean(x$rating)
  data.frame(avg.r = avg)
})
avgRating.decade
## show the avg rating over time
barplot(as.vector(avgRating.decade[,2]), main="Avg Ratings Over Time", xlab="Decade", names.arg=c(as.vector(avgRating.decade[,1])))


rating.type2 <- file3[, c("rating", "Type", "decade")]
rating.year <-ddply(rating.type2,c ("Type","decade"),function(x)
  {
    avg <- mean(x$rating)
    data.frame(avg.r = avg)
    })
rating.year

##Plot of each movie Type rating over time
g <-ggplot(rating.year, aes(x = decade, y = avg.r))
g + geom_point(aes(color = decade)) + facet_wrap(~Type)
## Movie Type that increase in rating over time:  Everything labeled 'Short'
## Types that decrease in rating: Action, Animation, Comedy

####################################################################
#3
head(file3)

length.10 <- as.integer((file3$length/10))*10
length.10
file4 <- data.frame(file3, length.10) 

rat.len <- file4[, c("rating", "length.10")]
rating.len <-ddply(rat.len,"length.10",function(x)
{
  avg <- mean(x$rating)
  data.frame(avg.r = avg)
})
rating.len
##barplot of rating length versus binned movie times
barplot(as.vector(rating.len[,2]), main="Avg Ratings Over Time", xlab="Decade", names.arg=c(as.vector(rating.len[,1])))
##There does not seem to be much of a relationship when binned by 10 minute intervals

####################################################################
#4
head(file4)

file5 <- data.frame(lapply(file4, as.character), stringsAsFactors = FALSE)
class(file5$Type)
for (i in 1:nrow(file5))
{
  if (grepl("Short", file5[i, 26]))
  {
    file5[i,26] = "Short"
  }
}
head(file5)


type.len <- file5[, c("Type", "length")]
type.len <-type.len[! is.na(type.len[,2]), ]

type.len.avg <-ddply(type.len,"Type" ,function(x)
{
  avg <- mean(as.numeric(x$length))
  data.frame(avg.l = avg)
})

type.len.avg <- type.len.avg[order(type.len.avg$avg.l),]

##barplot of movie types versus length (with all 'Shorts'  binned together)
par(mar=c(6, 4, 4, 1.4) + 4)  ## I took this from a stackoverflow message
barplot(as.vector(type.len.avg[,2]), main="Length v Genre",space = 0.5, las = 2, cex.names = .6, names.arg=c(as.vector(type.len.avg[,1])))
##Yes, some genres are longer than others

###################################################################
###################################################################
#5
###################################################################

## Num votes by decade (year of production)
rating.decade <-file5[, c("decade", "votes")]

avgVotes.decade <-ddply(rating.decade,"decade",function(x)
{
  avg <- mean(as.numeric(x$votes))
  data.frame(avg.v = avg)
})
avgVotes.decade
##### as shown below, votes increase rather consistently each decade(year)
barplot(as.vector(avgVotes.decade[,2]), main="votes by decade",space = 0.5, las = 2, cex.names = .6, names.arg=c(as.vector(avgVotes.decade[,1])))

## Num votes by Avg Rating
vote.rating <-file5[! is.na(file[,5]), ]
votes.rating <-vote.rating[, c("rating", "votes")]
votes.rating <- transform(votes.rating, rating = round(as.numeric(rating)))
avgVotes.rating <-ddply(votes.rating,"rating",function(x)
{
  avg <- mean(as.numeric(x$votes))
  data.frame(avg.v = avg)
})
avgVotes.rating
## as shown below, votes also increase with rating...
barplot(as.vector(avgVotes.rating[,2]), main="# votes by rating",xlab = "rounded rating", space = 0.5, las = 2, cex.names = 1, names.arg=c(as.vector(avgVotes.rating[,1])))
###########################
##Num votes by budget
vote.bud <-file5[! is.na(file[,4]), ]
votes.bud <-vote.bud[, c("budget", "votes")]
votes.bud <- transform(votes.bud, budget = round(log10(as.numeric(budget))))
head(votes.bud)
avgVotes.bud <-ddply(votes.bud,"budget",function(x)
{
  avg <- mean(as.numeric(x$votes))
  data.frame(avg.v = avg)
})
avgVotes.bud[1,1] = 0
avgVotes.bud
## Budget seems to most strongly correlate with # votes.  Of course, budget also correlates with year...
barplot(as.vector(avgVotes.bud[,2]), main="# votes by log10 budget",xlab = "rounded log budget", space = 0.5, las = 2, cex.names = 1, names.arg=c(as.vector(avgVotes.bud[,1])))

