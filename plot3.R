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
# plot 3
png('plot3.png',width=480,height=480)
# plot Datetime vs. Sub_metering_1
plot(hpc$DateTime,hpc$Sub_metering_1, xlab="", ylab="Energy sub metering",type="l",ylim=c(0, 40))
# add line for Datetime vs. Sub_metering_2
lines(hpc$DateTime,hpc$Sub_metering_2, xlab="", ylab="Energy sub metering",type="l", col = "red",ylim=c(0, 40))
# add line for Datetime vs. Sub_metering_3
lines(hpc$DateTime,hpc$Sub_metering_3, xlab="", ylab="Energy sub metering",type="l", col = "blue",ylim=c(0, 40))
# add legend
legend("topright", lty= 1, lwd=2, col = c("black", "red", "blue"), legend = c( "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
#save plot
dev.off()
