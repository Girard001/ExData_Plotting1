## read the data
fullData <- read.csv("~/RStudio/EDA/Project 1/data/household_power_consumption.txt", sep=";")

## select observations by Date
library(dplyr)
selectData <- filter(fullData, Date == "1/2/2007" | Date == "2/2/2007")

## convert selectData$Global_active_power to type numeric
selectData$Global_active_power <- as.numeric(selectData$Global_active_power)

## create the variable DateTime as type POSIXlt
library(stringr)
selectData1 <- selectData %>%
  mutate(DateTime = str_c(Date, " ", Time)) %>%
  relocate(DateTime, .after = Time)
selectData1$DateTime <- strptime(selectData1$DateTime, format = "%d/%m/%Y %H:%M:%S")
selectData <- selectData1
rm(selectData1)

## create the plot
png("plot2.png")
plot(selectData$DateTime, selectData$Global_active_power, pch = "", xlab = "", ylab = "Global Active Power (kilowatts)")
lines(selectData$DateTime, selectData$Global_active_power)
dev.off()