file <-0
file <- read.table(file = "/Users/alexandersatz/Documents/Cuny/IS607/week4/movies.tab", quote = "", fill = TRUE, sep = "\t", header = TRUE, stringsAsFactors = TRUE)
nrow(file)
file.1 <- 0
file.1 <- file
file.s <- file.1[order(file.1$votes, decreasing = TRUE),]
head(file.s)
div <- 0
div = log10(max(file.s$votes, na.rm = TRUE))  #used to normalize the num of votes

v.1 <-0
v.1 <- vector()
##v.l <- c(1:nrow(file.1)-1, NA)

for (i in 1:nrow(file.1))
{
  v.1[i] <- (log10(as.vector(file.1[i,6]))/div)*10
}
file.1$votes.norm <- v.1 
head(file.1)
nrow(file.1)

v.tot <- 0
v.tot <- vector()
length(v.tot)
for (i in 1:nrow(file.1))
{
  if ( is.na(file.1[i,"votes.norm"]) | is.na(file.1[i,"rating"]))
  {
    v.tot[i] <- 0
  }
  else
  {
    v.tot[i] <- (file.1[i,"votes.norm"] + file.1[i,"rating"])/2
  }
  
}

head(v.tot)

file.1$score.total <-v.tot
head(file.1)


min.s <- min(file.1$score.total)
max.s <- max(file.1$score.total) - min.s

score.final <- 0
score.final <- vector()
for (i in 1:nrow(file.1))
{
  score.final[i] <-  10*((file.1[i, "score.total" ]-min.s) / max.s)
}
head(score.final)

file.1$score.fin <- score.final
head(file.1)
min(file.1$score.fin)


df.best.movies <-0
v.score <-0
v.score <- vector()
df.best.movies <-ddply(file.1,c ("year"),function(x)
{
  index <- which.max(x$score.fin)
  title <- x[index, "title"] 
  score <- max(x$score.fin)
  data.frame(best.movie = title, score)
})
df.best.movies <-df.best.movies[! is.na(df.best.movies[,"year"]), ]
df.best.movies <- df.best.movies[order(df.best.movies$year, decreasing = TRUE),]

ggplot(df.best.movies, aes(x=year, y = score)) + geom_point()

head(file.1)
df.year.best <-0
df.year.best <- file.1[file.1[,"score.fin"]> 8.5, ]
head(df.year.best)

ggplot(data = df.year.best) + geom_histogram(aes(x=year), binwidth = 1)





