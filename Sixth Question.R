## read in the RDS files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## subset data to Baltimore City
subData <- subset(NEI, NEI$type == "ON-ROAD" & NEI$fips %in% c("24510", "06037"))

## load reshape2 library so we can melt and recast the data frame
library(reshape2)

## melt the data frame
subMelt <- melt(subData, id=c("type", "year","fips"), measure.var=c("Emissions"))

## reshape the data frame
meltData <- dcast(subMelt, fips + year ~ variable, sum)

## change year to factor so bar plots will be side by side instead of stacked
meltData$year <- as.factor(meltData$year)

## scale data
meltData$Emissions <- log10(meltData$Emissions)

## create png file (using same height and width from previous project)
png(filename = "plot6.png", width = 480, height = 480, units = "px")

## plot the data
qplot(x=fips, y=Emissions, fill=year, data = meltData, geom="bar", 
      stat="identity", position="dodge", main = "Motor Vehicle Emissions", 
      xlab = "City", ylab = "Emissions (log 10 scale)") + scale_x_discrete(labels=c("LA County", "Baltimore City"))

## close and save the plot to the png
dev.off()