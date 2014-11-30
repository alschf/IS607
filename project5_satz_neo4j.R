library(RNeo4j)
library(RNeo4j)

#######################################################################################
##Part 1

## Load the database.  This is a file of ~300000 bioactivities
## Note that I'm only going to use the first 1000 entries.  
## Neo4J crashes whenever I try to delete any nodes...so I'm hesitant to load too much in!
file <-0
file <- read.table(file = "C:/Users/Alex/Documents/cuny/IS607/neo4j/kinase_act.csv", quote = "", fill = TRUE, sep = ",", header = TRUE, stringsAsFactors = TRUE)
file.c <- file[1:1000,]  ## clip data, otherwise its very slow
head(file.c)

##Need to start Neo4j first!
graph = startGraph("http://localhost:7474/db/data/")

##Test to see if all is connected
graph$version

## clearing the graph causes my computer to crash.  So beware.
clear(graph)  ## type 'Y' as string

## get a list of unique cmpds
id.v = unique(file.c$COMPOUND_ID)
length(id.v)

## get list of unique protein names
pname = unique(file.c$NAME)
length(pname)
##########################################################################################
## Part 2.  Load the data


## create nodes for cmpds
## Note that the assinmnet of a node to a variable is not needed
for( x in 1:length(id.v))
{ 
  num = id.v[x]
  createNode(graph, "cmpd_id2", id = num)  
}

for( x in 1:length(pname))
{
  name = pname[x]
  createNode(graph, "prot_n2", id = name)
}

## below are tests to see if the nodes were created as desired
query = "MATCH (c:cmpd_id2) RETURN c.id LIMIT 100 "
query = "MATCH (c:prot_n2) RETURN c.id LIMIT 100 "
cypher(graph, query)

## Constraints are needed to use 'getUniqueNode' in the next step
addConstraint(graph, "cmpd_id2", "id")
addConstraint(graph, "prot_n2", "id")

## Create the relationships 
## this loop is pretty slow.  Takes a minute with 1000 rows.
for( x in 1:nrow(file.c))   
{
  log = file.c$LOG[x]
  first = getUniqueNode(graph, "cmpd_id2", id = file.c$COMPOUND_ID[x])
  second = getUniqueNode(graph, "prot_n2", id = as.character(file.c$NAME[x]))
  createRel(first, "Activity2", second, pka = log)  
}

################################################################################################
##Part 3.

## Find cmpds with pka values > 6 for a particular target, thier average pka values, and the standard deviations.
query = "MATCH (c:cmpd_id2)-[r:Activity2]->(protein) where r.pka >6 return distinct c.id ,protein.id, avg(r.pka), stdev(r.pka) limit 100"
cypher(graph, query)

###############################################################################################
##Part 4.

##Advantages of Graph Database
##1.  Neo4j offers a nice way to view the data
##2.  Loads data as 'documents' instead of 'relational' model, which more how people 'think'
##3.  Makes it easier to visualize how things are related to eachother

##Disadvantages
##1.Relational model minimizes duplicate data being stored, whereas the graph model may not
##  depending upon the complexity of the data
##2.The software is buggy. REALLY buggy to the point that it is hard to use.  But that is a 
##  a bit off topic...
##3.If you're data starts in a relational model, it can be time consuming to change it into a graph model
##4.If you want a table, best to have a relational db.  And sometimes you want a table.

