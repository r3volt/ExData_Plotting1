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

setupData()
data <- read.delim("data/household_power_consumption.txt", header = TRUE, sep=";", na.strings = c("NA","?"), stringsAsFactors = FALSE, fill = TRUE)
data$DateTime <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S", tz = "UTC")

# POSIXlt$year returns years since 1900
# POSIXlt$mon returns months in range 0-11
# POSIXlt$mday returns day in range 1-31
analysisMonth<-data[data$DateTime$year+1900 == 2007 & data$DateTime$mon + 1 == 2 & (data$DateTime$mday == 1 | data$DateTime$mday == 2),]

# Plot #3
par(mfrow = c(1,1), mar = c(5, 4, 4, 2) + 0.1)
plot(analysisMonth$DateTime, analysisMonth$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
points(analysisMonth$DateTime, analysisMonth$Sub_metering_2, type = "l", col = "red")
points(analysisMonth$DateTime, analysisMonth$Sub_metering_3, type = "l", col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lwd = 1, pch = NA)

