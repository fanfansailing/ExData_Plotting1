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
#plot 4
#set graphing parameters
par(mfcol = c(2,2))
# plot datetime vs global active power data
plot(hpc$DateTime, hpc$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power(kilowatts)")
# second plot in column 1
# plot Datetime vs. Sub_metering_1
plot(hpc$DateTime,hpc$Sub_metering_1, xlab="", ylab="Energy sub metering",type="l",ylim=c(0, 40))
# add line for Datetime vs. Sub_metering_2
lines(hpc$DateTime,hpc$Sub_metering_2, xlab="", ylab="Energy sub metering",type="l", col = "red",ylim=c(0, 40))
# add line for Datetime vs. Sub_metering_3
lines(hpc$DateTime,hpc$Sub_metering_3, xlab="", ylab="Energy sub metering",type="l", col = "blue",ylim=c(0, 40))
# add legend
legend("topright", lty= 1, lwd=2, col = c("black", "red", "blue"), legend = c( "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
#first plot in column 2
#plot datetime vs. Voltage
plot(hpc$DateTime,hpc$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
#second plot in column 2
#plot datetime vs. global reactive power
plot(hpc$DateTime,hpc$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")
#save to file
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()
