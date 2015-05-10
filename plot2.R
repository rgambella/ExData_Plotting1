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

# The plot 2 is a scatterplot of Global Active Power and Time.

# Open the png device.
png(file = "plot2.png")

# Make the scatterplot.
plot(y = electricPowerConsumption$Global_active_power,
     x = electricPowerConsumption$Time,
     xlab = "",
     ylab = "Global Active Power (kilowatts)",
     type = "l")

# Close the png device.
dev.off()





