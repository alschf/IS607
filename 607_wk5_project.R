file <-0
file <- read.table(file = "/Users/alexandersatz/Documents/Cuny/IS607/week5/ks_bioactivity.txt", quote = "", fill = TRUE, sep = "\t", header = TRUE, stringsAsFactors = TRUE)
nrow(file)

head(file)
## have cmpds with greater potency in any assay then been tested in a larger number of distinct assays?


bioact.1 <-tbl_df(file)

## there are 1447 activity types, which is a lot
summarise(bioact.1, 
          numberdatatype = n_distinct(ACTIVITY_TYPE))

## we see below that we have things on a log scale and - log scale
activity.type <- group_by(bioact.1, ACTIVITY_TYPE)
types.df <-summarise(activity.type, 
          number = n())
head(types.df,100)

## We also have different units of activity (non log scale)
activity.units <- group_by(bioact.1, STANDARD_UNIT)
units.df <-summarise(activity.units, 
                     number = n())
units.df <- data.frame(units.df)
units.df

## this subset contains all the 'log' values and converts to -log if wasn't already
bioact.log <- filter(bioact.1, grepl("log", ACTIVITY_TYPE, ignore.case = TRUE))
bioact.log <- filter(bioact.log, ! grepl("log2", ACTIVITY_TYPE, ignore.case = TRUE))
bioact.log <- filter(bioact.log, ! grepl("logp", ACTIVITY_TYPE, ignore.case = TRUE))
bioact.log <- filter(bioact.log, ! grepl("logd", ACTIVITY_TYPE, ignore.case = TRUE))
bioact.log <- filter(bioact.log, ! grepl("GI50", ACTIVITY_TYPE, ignore.case = TRUE))
bioact.log

bioact.logged1 <- mutate(bioact.log, 
                         LOG.ACT = as.integer(abs(STANDARD_VALUE)))

bioact.logged1 <-arrange(bioact.logged1, desc(LOG.ACT))
bioact.logged1   ## looks good, still has NA values

## the data set has NA values in the STANDARD_VALUE column, even though there is an activity type given?
## I assume this means the assay was run, but no vlue could be determined for whatever reason.  I will
## keep these values in, but assign them a 'potency' of zero
bioact.na <- (bioact.logged1[is.na(bioact.logged1$LOG.ACT),])
bioact.na

## this subset takes all the values that are not a log
bioact.notlog <-filter(bioact.1, ! agrepl("log", ACTIVITY_TYPE, ignore.case = TRUE))
bioact.notlog 


## the 'notlog'  values need to be adjusted if they are nM or uM in scale.

bioact.loguM <-bioact.notlog %>% 
  filter(grepl("um", STANDARD_UNIT, ignore.case = TRUE)) %>%
  mutate(LOG.ACT = as.integer(-log10((STANDARD_VALUE/1000000))))
bioact.loguM <-arrange(bioact.loguM, desc(LOG.ACT))
bioact.loguM$LOG.ACT  ## looks great and values range from 4-6 mainly, so the right range.


bioact.lognM <-bioact.notlog %>% 
  filter(grepl("nm", STANDARD_UNIT, ignore.case = TRUE)) %>%
  mutate(LOG.ACT = as.integer(-log10((STANDARD_VALUE/1000000000))))

bioact.lognM <-arrange(bioact.lognM, desc(LOG.ACT))
bioact.lognM$LOG.ACT  ## looks good


#combine all 3 dataframes
biact2 <- rbind(bioact.logged1, bioact.loguM, bioact.lognM)
biact2  ## ~11,000 entries now
biact2 <- select(biact2, COMPOUND_ID, STANDARD_UNIT, STANDARD_VALUE, LOG.ACT, DOM_ID, NAME)
biact2 <-arrange(biact2, desc(LOG.ACT))
head(biact2, 10)  ## the log values match expectations based on units and values!

## remove NA value
biact3 <- biact2[!is.na(biact2$LOG.ACT),]
biact3

#Now ready to group by cmpd ID, determine max potency value, and count number of assays


biact.cmp <- group_by(biact3, COMPOUND_ID)
bioact.sum <- summarize(biact.cmp,
                        max.pot = max(LOG.ACT),
                        tot.Assays = n(),
                        uniq.Assays = n_distinct(NAME)
                        )
bioact.sum
bioact.sum <-arrange(bioact.sum, desc(max.pot))
bioact.sum

## first we plot max.pot versus uniq Assays
p <-ggvis(bioact.sum, x = ~max.pot, y = ~uniq.Assays)
layer_points(p)

ggplot(data=bioact.sum, aes(x=max.pot, y=uniq.Assays, group=1))  + geom_point()

bioact.sum %>% 
  ggvis(~max.pot, ~uniq.Assays,
        opacity := input_slider(0,1)) %>%
  layer_smooths() %>%
  layer_points()

## then the tot # of assays

bioact.sum %>% 
  ggvis(~max.pot, ~tot.Assays,
        opacity := input_slider(0,1)) %>%
  layer_smooths() %>%
  layer_points()

biact.group <- group_by(bioact.sum, max.pot)

## looking at max potency verus uniq assays
uniq.assays<- summarise(biact.group,
                          v.avg = mean(uniq.Assays),
                          v.med = median(uniq.Assays))
uniq.assays %>%
  ggvis(~max.pot, ~v.med) %>%
  layer_smooths() %>%
  layer_points()

## looking at max potency versus total # assays
total.assays<- summarise(biact.group,
                       v.avg = mean(tot.Assays),
                       v.med = median(tot.Assays))
total.assays
total.assays %>%
  ggvis(~max.pot, ~v.med) %>%
  layer_smooths() %>%
  layer_points()
  
