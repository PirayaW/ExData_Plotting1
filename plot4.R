# read data
data <- read.table("household_power_consumption.txt", 
                   header = TRUE, 
                   sep = ";", 
                   colClasses = c(rep("character", 2), rep("numeric", 7)),
                   na.strings = "?")
data$Date <- as.Date(data$Date, "%d/%m/%Y")

# choose data from the dates 2007-02-01 and 2007-02-02
data <- subset(data, 
               data$Date >= as.Date("2007-02-01") & 
                   data$Date <= as.Date("2007-02-02"))

# create DateTime column (combine from Date and Time)
# Note: data$Date format is now "%Y-%m-%d" (type: Date)
data$DateTime <- as.POSIXct(strptime(paste(data$Date, data$Time, sep = " "), 
                                     "%Y-%m-%d %H:%M:%S"))

# plot as png
png("plot4.png", width = 480, height = 480, bg = "transparent")

# multiple plots: 2x2, fills by rows
par(mfrow=c(2,2))

# Global Active Power
plot(x = data$DateTime, 
     y = data$Global_active_power, 
     type = "l",
     xlab = "",
     ylab = "Global Active Power")

# Voltage
plot(x = data$DateTime, 
     y = data$Voltage, 
     type = "l",
     xlab = "datetime",
     ylab = "Voltage")

# Energy sub metering
plot(x = data$DateTime, 
     y = data$Sub_metering_1, 
     type = "n",
     xlab = "",
     ylab = "Energy sub metering")
lines(x = data$DateTime, 
      y = data$Sub_metering_1,
      col = "black")
lines(x = data$DateTime, 
      y = data$Sub_metering_2,
      col = "red")
lines(x = data$DateTime, 
      y = data$Sub_metering_3,
      col = "blue")
legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = c(1, 1, 1),
       col = c("black", "red", "blue"),
       bty = "n")

# Global_reactive_power
plot(x = data$DateTime, 
     y = data$Global_reactive_power, 
     type = "l",
     xlab = "datetime",
     ylab = "Global_reactive_power")

dev.off()