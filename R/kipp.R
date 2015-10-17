#KIPP LA

#distribution of colleges attended by tier

#competitiveness ranking
#competitive index
#adjusted 6 year minority graduation rate

#### PREPROCESSING ####

college <- read.csv("~/Dropbox/Teradata DataDive 2015/KIPP LA/CollegeTierMapping.csv")
salesforce <- read.csv("~/Dropbox/Teradata DataDive 2015/KIPP LA/SALESFORCE-Enrollment.csv")

# add college info to salesforce main table:
salesforce_names <- names(salesforce)
salesforce[,39:44] = college[match(salesforce$SCHOOL__C, college$Enrollment.SCHOOL__C),]
#660 matches

#join ids (#salesforce$STUDENT__C <-> masterid$Salesforce.ID)
masterid <- read.csv("~/Dropbox/Teradata DataDive 2015/KIPP LA/MasterIDTable.csv")

#ignore those without salesforce ids
masterid_salesforce = masterid[masterid$Salesforce.ID!="", ]
salesforce = merge(salesforce, masterid_salesforce, by.x = "STUDENT__C", by.y = "Salesforce.ID")
dim(salesforce) #4438   46

#add in the NWEA MAP RIT ELA and Math scores


#Which past data variables have actual information?
summary(salesforce) 

## ranked loosely in order to explore

#HIGHEST_SAT_SCORE__C <- **median 0
#STATUS__C graduated < - should subset to only those graduated?
salesforce
#SCHOOL_C
#STARTINGGRADE_C
#ENDINGGRADE_C
