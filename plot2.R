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
analysis<-data[data$DateTime$year+1900 == 2007 & data$DateTime$mon + 1 == 2 & (data$DateTime$mday == 1 | data$DateTime$mday == 2), ]

# Remove the large data set from workspace.
rm(data)

# Render plot #2
png(file = "plot2.png", width = 480, height = 480)
par(mfrow = c(1,1), mar = c(5, 4, 4, 2) + 0.1, cex = 0.65)
plot(analysis$DateTime, analysis$Global_active_power, type = "l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()
