# Clear workspace and console
rm(list=ls())
cat("\014")

#
# Loading data section
#

# Define a custom data format.
setAs("character","MyDate", function(from) as.Date(from, format="%d/%m/%Y"))

# Load dataset.
electricPowerConsumption <- read.table("household_power_consumption.txt", 
    header = TRUE, sep = ";", colClasses = c("MyDate", "character", rep("numeric", 7)),
    na.strings = "?")

# Subsetting data frame on the requested dates.
electricPowerConsumption <- subset(electricPowerConsumption, 
                                   electricPowerConsumption$Date %in% c(as.Date("2007-02-01"), 
                                                                        as.Date("2007-02-02")))

# Convert Time in time format.
electricPowerConsumption$Time <- as.POSIXct(paste(as.character(electricPowerConsumption$Date), 
    electricPowerConsumption$Time), format="%Y-%m-%d %H:%M:%S")

# Save extracted data frame in an object for later uses.
save(electricPowerConsumption, file = "electricPowerConsumption.RData")


#
# Manage plot section
#

# Change Locale to set English language.
Sys.setlocale("LC_TIME", "English")

# The plot 3 is a scatterplot of Energy Sub Metering over time.
# There is the need of three different colors for each variable.
# I use black for Sub_metering_1, red for Sub_Metering_2 and
# blue for Sub_Metering_3.


# Open the png device.
png(file = "plot3.png", width = 480, height = 480, units = "px")

# Make the scatterplot.
# Generate plot base.
plot(x = electricPowerConsumption$Time,
     y = electricPowerConsumption$Sub_metering_1,
     xlab = "",
     ylab = "Energy sub metering",
     type = "n")

# Add sub metering 1 points in black line.
points(x = electricPowerConsumption$Time, 
       y = electricPowerConsumption$Sub_metering_1,
       col = "black", type = "l")

# Add sub metering 2 points in red line.
points(x = electricPowerConsumption$Time, 
       y = electricPowerConsumption$Sub_metering_2,
       col = "red", type = "l")

# Add sub metering 3 points in blue line.
points(x = electricPowerConsumption$Time, 
       y = electricPowerConsumption$Sub_metering_3,
       col = "blue", type = "l")

# Add legend
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), box.col="darkgreen", 
       lty = c(1, 1, 1), bty = "o", cex=1, )

# Close the png device.
dev.off()





