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
png("plot2.png", width = 480, height = 480)
plot(x = data$DateTime, 
     y = data$Global_active_power, 
     type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")
dev.off()