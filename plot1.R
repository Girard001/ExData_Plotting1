## read the data
fullData <- read.csv("~/RStudio/EDA/Project 1/data/household_power_consumption.txt", sep=";")

## select observations by Date
library(dplyr)
selectData <- filter(fullData, Date == "1/2/2007" | Date == "2/2/2007")

## convert selectData$Global_active_power to type numeric
selectData$Global_active_power <- as.numeric(selectData$Global_active_power)

## create the plot
png("plot1.png")
hist(selectData$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power", ylim = c(0, 1200))
dev.off()