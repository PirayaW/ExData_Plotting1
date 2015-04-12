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

# plot as png
png("plot1.png", width = 480, height = 480, bg = "transparent")
hist(data$Global_active_power, 
     col = "red",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")
dev.off()