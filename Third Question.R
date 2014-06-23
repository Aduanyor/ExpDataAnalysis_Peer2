# Question 3
# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) 
# variable, which of these four sources have seen decreases in emissions from 1999–2008 
# for Baltimore City? Which have seen increases in emissions from 1999–2008? Use the ggplot2 
# plotting system to make a plot answer this question.
# Upload a PNG file containing your plot addressing this question.

library('ggplot2')

# set working directory
setwd('/home/pcz/Coursera/Exploratory_Data_Analysis/project2')

# read data from file
NEI <- readRDS("summarySCC_PM25.rds")

# split data into variables by year, filter results for Baltimore
NEI.y1999c <- NEI[which(NEI$year==1999 & NEI$fips=='24510'), c(1,2,4,5,6)]
NEI.y2002c <- NEI[which(NEI$year==2002 & NEI$fips=='24510'), c(1,2,4,5,6)]
NEI.y2005c <- NEI[which(NEI$year==2005 & NEI$fips=='24510'), c(1,2,4,5,6)]
NEI.y2008c <- NEI[which(NEI$year==2008 & NEI$fips=='24510'), c(1,2,4,5,6)]

# aggregate emissions by type for each year
NEI.aggr1999c <- with(NEI.y1999c, aggregate.data.frame(Emissions, by=list(type), FUN=sum))
NEI.aggr2002c <- with(NEI.y2002c, aggregate.data.frame(Emissions, by=list(type), FUN=sum))
NEI.aggr2005c <- with(NEI.y2005c, aggregate.data.frame(Emissions, by=list(type), FUN=sum))
NEI.aggr2008c <- with(NEI.y2008c, aggregate.data.frame(Emissions, by=list(type), FUN=sum))

# create a dataframe with proper column names (probably not the best way though)
df <- data.frame
x <- rbind(c(1999, unlist(as.numeric(NEI.aggr1999c$x))), c(2002, unlist(as.numeric(NEI.aggr2002c$x))), 
           c(2005, unlist(as.numeric(NEI.aggr2005c$x))), c(2008, unlist(as.numeric(NEI.aggr2008c$x))))
df <- data.frame(x)
names(df) <- c('year', 'NONPOINT', 'NONROAD', 'ONROAD', 'POINT')

# open png device
png("plot3.png", width=480, height=480, units="px")

# plot the data frame using ggplot
pl <- ggplot(df, aes(Year, 'Emissions in tonnes', colour=Type)) + 
  geom_line(aes(x=year, y = NONPOINT, colour = "NONPOINT")) + 
  geom_line(aes(x=year,y = NONROAD, colour = "NONROAD")) + 
  geom_line(aes(x=year,y = ONROAD, colour = "ONROAD")) + 
  geom_line(aes(x=year,y = POINT, colour = "POINT")) +
  labs(title = expression("Change in PM"[2.5]*" Emissions Based on Source Type (USA)"))
pl

# close device
dev.off()