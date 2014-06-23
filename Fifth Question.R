## Plot 1
## Loading the datasets
## Datasets must be unzipped and located in the working directory previously

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


Baltimore<-subset(NEI, fips == "24510")

## get Auto related SCC
autoList <- SCC[grepl("Vehicle|vehicle", SCC$Short.Name)==TRUE,]
## Subset for Auto related
BaltimoreAuto<- subset(Baltimore,Baltimore$SCC %in% autoList$SCC)


BaltimoreAuto <-subset(BaltimoreAuto ,select=c(Emissions, year ))

aggAuto<-aggregate(BaltimoreAuto, by=list(BaltimoreAuto$year), FUN=sum, na.rm=TRUE)


## Plotting the answer
plot(aggAuto$Group.1, aggAuto$Emissions, xlab="Year", ylab="Total Emissions", type="l")


dev.copy(png,'plot5.png')
dev.off()