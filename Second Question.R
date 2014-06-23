## Plot 2
## Loading the datasets
## Datasets must be unzipped and located in the working directory previously
SCC <- readRDS("Source_Classification_Code.rds")
NEI <- readRDS("summarySCC_PM25.rds")


## Generating a reduced dataset
library(reshape2)
year.one<-dcast(NEI[NEI$fips=="24510",], year ~ Pollutant, value.var="Emissions", sum)


## Plotting the answer
png("plot2.png",480,480)
bp1<-barplot(height=year.one[,2], names.arg=year.one[,1], col="red", border=NA, ylim=c(0,3500), main="Total Emissions from PM25 in Baltimore by Year", xlab="Year", ylab="Total Emissions (in Tons.)")
text(bp1, 0, round(year.one[,2], 1),cex=1,pos=3)
dev.off()


## Answer: Yes, the total emissions from PM2.5 have decreased in the Baltimore City from 1999 to 2008.