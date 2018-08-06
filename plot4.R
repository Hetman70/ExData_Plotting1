##############################################################################
#
# FILE
#   plot4.R
#
# OVERVIEW
#   Using data collected from the  
#   “Individual household electric power consumption Data Set”, 
#   load the data, Subset the data, convert the Date and Time 
#   variables to Date/Time classes and reconstruct the required plots, 
#   outputting the resulting plot1.png file.
#   See README.md for details.

# Antonio Avella


##############################################################################
# STEP 0A - Get data
##############################################################################

# load the data
# Note that in this dataset missing values are coded as ?
rm(list = ls())
data <- read.table("household_power_consumption.txt", header = T, 
                   sep = ";", na.strings = "?")

##############################################################################
# STEP 0B - Convert the Date
##############################################################################

# convert the date variable to Date class
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

# Subset the data
data <- subset(data, subset = (Date >= "2007-02-01" & Date <= "2007-02-02"))

# Convert dates and times
data$datetime <- strptime(paste(data$Date, data$Time), "%Y-%m-%d %H:%M:%S")

##############################################################################
# STEP 1- Reconstruct the required plots
##############################################################################

# Plot 4
data$datetime <- as.POSIXct(data$datetime)
par(mfrow = c(2, 2))
attach(data)
plot(Global_active_power ~ datetime, type = "l", ylab = "Global Active Power", 
     xlab = "")
plot(Voltage ~ datetime, type = "l")
plot(Sub_metering_1 ~ datetime, type = "l", ylab = "Energy sub metering", 
     xlab = "")
lines(Sub_metering_2 ~ datetime, col = "Red")
lines(Sub_metering_3 ~ datetime, col = "Blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       bty = "n")

plot(Global_reactive_power ~ datetime, type = "l")

##############################################################################
# STEP 2- Save the resulting file
##############################################################################

# Save file
dev.copy(png, file = "plot4.png", height = 480, width = 480)
dev.off()
detach(data)


