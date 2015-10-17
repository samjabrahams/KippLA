library(data.table)
library(ggplot2)
library(bit64)

data.dir <- '/Users/whigh/data/datakind_kippla/dropbox'
enrollment.file <- 'SALESFORCE-Enrollment.csv'
college.file <- 'CollegeTierMapping.csv'
student.id.file <- 'MasterIDTable.csv'

enr.dat <- fread(paste(data.dir,enrollment.file,sep='/'))
col.dat <- fread(paste(data.dir,college.file,sep='/'))
sid.dat <- fread(paste(data.dir,student.id.file,sep='/'))

name.v <- colnames(col.dat)
name.v[1] <- 'SCHOOL__C'
setnames(col.dat,name.v)

enr.dat.subset <- subset(enr.dat,
                         TYPE__C == 'College',
                         select=c('STUDENT__C','TYPE__C','SCHOOL__C'))

col.dat.subset <- subset(col.dat,
                         COMPETITIVENESS_INDEX__C != 0)

tier.merge <- merge(enr.dat.subset,col.dat.subset,by='SCHOOL__C')

p <- ggplot(tier.merge,aes(COMPETITIVENESS_INDEX__C)) 
p <- p + geom_histogram()
print(p)
