setupData <- function() {
  fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  
  if(!file.exists("./data")) {
    dir.create("./data")
  }
  
  if(!file.exists("./data/power.zip")) {
    download.file(fileUrl, destfile = "./data/power.zip", method = "curl")
  }
  unzip("./data/power.zip", overwrite = TRUE, exdir="./data")
}

# Download the Data and Unzip into a working directory.
setupData()

# Read data into the workspace.
data <- read.delim("./data/household_power_consumption.txt", header = TRUE, sep=";", na.strings = c("NA","?"), stringsAsFactors = FALSE, fill = TRUE)
# Create a proper DateTime column
data$DateTime <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S", tz = "UTC")

# Create a subset of the data.
# POSIXlt$year returns years since 1900
# POSIXlt$mon returns months in range 0-11
# POSIXlt$mday returns day in range 1-31
analysis<-data[data$DateTime$year+1900 == 2007 & data$DateTime$mon + 1 == 2 & (data$DateTime$mday == 1 | data$DateTime$mday == 2),]

# Remove the large data set from workspace.
rm(data)

# Render plot #4
# Plot Setup
par(mfrow = c(2,2), mar = c(4,4,2,2), cex = 0.5)
# Plot #4a
plot(analysis$DateTime, analysis$Global_active_power , type = "l", xlab = "", ylab="Global Active Power")
# Plot #4b
plot(analysis$DateTime, analysis$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
# Plot #4c
plot(analysis$DateTime, analysis$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
points(analysis$DateTime, analysis$Sub_metering_2, type = "l", col = "red")
points(analysis$DateTime, analysis$Sub_metering_3, type = "l", col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), bty = "n", lwd = 1, pch = NA)
# Plot #4d
plot(analysis$DateTime, analysis$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")


