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
electricPowerConsumption$Time <- strptime(electricPowerConsumption[, 2],
                                          format = "%H:%M:%S")

# Save extracted data frame in an object for later uses.
save(electricPowerConsumption, file = "electricPowerConsumption.RData")


#
# Manage plot section
#

# The plot 1 is an histogram of Global Active Power.

# Open the png device.
png(file = "plot1.png")

# Make the histogram.
hist(electricPowerConsumption$Global_active_power, col = "red",
     xlab = "Global Active Power (kilowatts)",
     main = "Global Active Power")

# Close the png device.
dev.off()





