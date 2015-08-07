## Getting data
dataSource <- "./household_power_consumption.txt"
dataFile <- read.csv(dataSource, header=TRUE, sep=';', na.strings="?", nrows=2075259, check.names=FALSE, stringsAsFactors=FALSE, comment.char="", quote='\"')

## Subsetting data
dataFile$Date <- as.Date(dataFile$Date, format="%d/%m/%Y")

dataSubset <- subset(dataFile, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(dataFile)

## Converting dates and set values
datetime <- paste(as.Date(dataSubset$Date), dataSubset$Time)
dataSubset$Datetime <- as.POSIXct(datetime)

subMetering1 <- as.numeric(dataSubset$Sub_metering_1)
subMetering2 <- as.numeric(dataSubset$Sub_metering_2)
subMetering3 <- as.numeric(dataSubset$Sub_metering_3)

## Constructing and saving Plot 3
png("plot3.png", width=480, height=480)

plot(subMetering1~dataSubset$Datetime, type="l", ylab="Energy Submetering", xlab="")
lines(subMetering2~dataSubset$Datetime, type="l", col="red")
lines(subMetering3~dataSubset$Datetime, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))

dev.off()