## Plot 1
## Loading the datasets
## Datasets must be unzipped and located in the working directory previously

SCC <- readRDS("Source_Classification_Code.rds")
NEI <- readRDS("summarySCC_PM25.rds")


## Generating a reduced dataset
library(reshape2)
year.all<-dcast(NEI, year ~ Pollutant, value.var="Emissions", sum)


## Plotting the answer
png("plot1.png",480,480)
bp1<-barplot(height=year.all[,2]/1000000, names.arg=year.all[,1], col="red", border=NA, ylim=c(0,8), main="Total Emissions from PM25 in the US by Year", xlab="Year", ylab="Total Emissions (in MM of Tons.)")
text(bp1, 0, round(year.all[,2]/1000000, 1),cex=1,pos=3)
dev.off()


## Answer: Yes, total emissions from PM2.5 have decreased in the United States from 1999 to 2008.