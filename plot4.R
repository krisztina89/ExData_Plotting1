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

globalActivePower <- as.numeric(dataSubset$Global_active_power)
globalReactivePower <- as.numeric(dataSubset$Global_reactive_power)
voltage <- as.numeric(dataSubset$Voltage)
subMetering1 <- as.numeric(dataSubset$Sub_metering_1)
subMetering2 <- as.numeric(dataSubset$Sub_metering_2)
subMetering3 <- as.numeric(dataSubset$Sub_metering_3)

## Constructing and saving Plot 4
png("plot4.png", width=480, height=480)
par(mfrow = c(2, 2)) 

plot(globalActivePower~dataSubset$Datetime, type="l", xlab="", ylab="Global Active Power", cex=0.2)

plot(voltage~dataSubset$Datetime, type="l", xlab="datetime", ylab="Voltage")

plot(subMetering1~dataSubset$Datetime, type="l", ylab="Energy Submetering", xlab="")
lines(subMetering2~dataSubset$Datetime, type="l", col="red")
lines(subMetering3~dataSubset$Datetime, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=, lwd=2.5, col=c("black", "red", "blue"), bty="o")

plot(globalReactivePower~dataSubset$Datetime, type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()