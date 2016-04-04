#load data into R
install.packages("dplyr")
library(dplyr)
install.packages("data.table")
library(data.table)
setwd("~/Coursera")
hpc <- fread("household_power_consumption.txt", na.strings="?",stringsAsFactors = FALSE)
hpc <- filter(hpc, grep("^[1,2]/2/2007", Date))
#data conversion
hpc$Global_active_power <- as.numeric(as.character(hpc$Global_active_power))
hpc$Global_reactive_power <- as.numeric(as.character(hpc$Global_reactive_power))
hpc$Sub_metering_1 <- as.numeric(as.character(hpc$Sub_metering_1))
hpc$Sub_metering_2 <- as.numeric(as.character(hpc$Sub_metering_2))
hpc$Sub_metering_3 <- as.numeric(as.character(hpc$Sub_metering_3))
hpc$Voltage <- as.numeric(as.character(hpc$Voltage))
hpc$DateTime <- as.POSIXct(strptime(paste(hpc$Date, hpc$Time),tz="EST","%d/%m/%Y %H:%M:%S"))
#Plot 1
hist(hpc$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")
#Saving Plot 1
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()
