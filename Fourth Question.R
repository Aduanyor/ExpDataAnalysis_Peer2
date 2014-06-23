## Plot 1
## Loading the datasets


NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


## get coal related SCC
coal <- SCC[grepl("coal|Coal", SCC$Short.Name)==TRUE,]
## Subset for coal related
coalRelated <- subset(NEI,NEI$SCC %in% coal$SCC)
coalRelated <-subset(coalRelated ,select=c(Emissions, year ))

aggCoal<-aggregate(coalRelated, by=list(coalRelated$year), FUN=sum, na.rm=TRUE)


## Plotting the answer
plot(aggCoal$Group.1, aggCoal$Emissions, xlab="Year",ylab="Total Emissions", type="l")


dev.copy(png,'plot4.png')
dev.off()