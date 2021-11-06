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
png("plot3.png")
plot(selectData$DateTime, selectData$Sub_metering_1, pch = "", xlab = "", ylab = "Energy sub metering")
lines(selectData$DateTime, selectData$Sub_metering_1)
lines(selectData$DateTime, selectData$Sub_metering_2, col = "red")
lines(selectData$DateTime, selectData$Sub_metering_3, col = "blue")
legend("topright", col = c("black", "red", "blue"), lwd = 1, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()