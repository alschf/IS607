## Author Alex Satz
## IS607 Week 9
## Oct 25 2014


## Part I.  Importing data into mongodb.  Below are the lines I used
## in my windows command prompt

##C:\MongoDBnew\bin\mongoimport --db unitedstates --collection usdata --type csv 
##--file C:\Users\Alex\Documents\cuny\IS607\statedata.csv --headerline


##C:\MongoDBnew\bin\mongoimport --db unitedstates --collection usdata --type tsv 
##--file C:\Users\Alex\Documents\cuny\IS607\districtdata.txt --headerline


##C:\MongoDBnew\bin\mongoimport --db unitedstates --collection usdata --type tsv 
##--file C:\Users\Alex\Documents\cuny\IS607\inhabitedterritorydata.txt --headerline


############################################################################
## Part 2.  Extracting data with R
mongo <- mongo.create()
mongo.is.connected(mongo)  ## test to see if connection is good
mongo.get.databases(mongo)  ## see avail databases
mongo.get.database.collections(mongo,"unitedstates")  ## switch to database
coll <- "unitedstates.usdata"  ## give collection shortname
mongo.count(mongo, coll)  ## count entries in the collection
mongo.find.one(mongo, coll)  ## take a look at one entry

## Pull out data for the three dataframes.  
## Use $exist operator to distinguish between entries

distdata <- mongo.find(mongo, coll, "{\"federal_district\": {\"$exists\":true}}")
distdata.df <- mongo.cursor.to.data.frame(distdata, nullToNA = TRUE)
distdata.df

terr <- mongo.find(mongo, coll, "{\"territory\": {\"$exists\":true}}")
terr.df <- mongo.cursor.to.data.frame(terr, nullToNA = TRUE)
terr.df

state <- mongo.find(mongo, coll, "{\"state\": {\"$exists\":true}}")
state.df <- mongo.cursor.to.data.frame(state, nullToNA = TRUE)
state.df


