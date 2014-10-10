install.packages("RPostgreSQL")
library(RPostgreSQL)
con <- dbConnect(PostgreSQL(), user= "alexandersatz",  dbname="wk7assign")
rs <- dbGetQuery(con, "select count(c.lang), c.lang, c.datehour from cleandata2 c group by c.lang, c.datehour Order by count(c.lang) desc limit 100") 


rs <-spread(rs, datehour, count)
colnames(rs) <- c("lang", "Seven", "Eight")
rs2 <-mutate(rs, 
               diff = as.numeric(Seven)/as.numeric(Eight))

rs3 <- na.omit(rs2)
rs3 <-arrange(rs3, desc(diff))
rs3

ggplot(data=rs3, aes(x=lang, y=diff, group=1)) + geom_line() + geom_point()

  
