## read the data
fullData <- read.csv("~/RStudio/EDA/Project 1/data/household_power_consumption.txt", sep=";")

## select observations by Date
library(dplyr)
selectData <- filter(fullData, Date == "1/2/2007" | Date == "2/2/2007")

## convert selectData$Global_active_power and Voltage to type numeric
selectData$Global_active_power <- as.numeric(selectData$Global_active_power)
selectData$Voltage <- as.numeric(selectData$Voltage)

## create the variable DateTime as type POSIXlt
library(stringr)
selectData1 <- selectData %>%
  mutate(DateTime = str_c(Date, " ", Time)) %>%
  relocate(DateTime, .after = Time)
selectData1$DateTime <- strptime(selectData1$DateTime, format = "%d/%m/%Y %H:%M:%S")
selectData <- selectData1
rm(selectData1)

## create the plots
png("plot4.png")
par(mfcol = c(2,2))
## create plot 4A
plot(selectData$DateTime, selectData$Global_active_power, pch = "", xlab = "", ylab = "Global Active Power")
lines(selectData$DateTime, selectData$Global_active_power)
## create plot 4B
plot(selectData$DateTime, selectData$Sub_metering_1, pch = "", xlab = "", ylab = "Energy sub metering")
lines(selectData$DateTime, selectData$Sub_metering_1)
lines(selectData$DateTime, selectData$Sub_metering_2, col = "red")
lines(selectData$DateTime, selectData$Sub_metering_3, col = "blue")
legend("topright", bty = "n", col = c("black", "red", "blue"), lwd = 1, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
## create plot 4C
plot(selectData$DateTime, selectData$Voltage, pch = "", xlab = "datetime", ylab = "Voltage")
lines(selectData$DateTime, selectData$Voltage)
## create plot 4D
plot(selectData$DateTime, selectData$Global_reactive_power, pch = "", xlab = "datetime", ylab = "Global_reactive_power")
lines(selectData$DateTime, selectData$Global_reactive_power)
dev.off()