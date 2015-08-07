## Getting data
dataSource <- "./household_power_consumption.txt"
dataFile <- read.csv(dataSource, header=TRUE, sep=';', na.strings="?", check.names=FALSE, stringsAsFactors=FALSE, comment.char="", quote='\"')

## Subsetting data
dataFile$Date <- as.Date(dataFile$Date, format="%d/%m/%Y")

dataSubset <- subset(dataFile, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(dataFile)

## Converting dates
datetime <- paste(as.Date(dataSubset$Date), dataSubset$Time)
dataSubset$Datetime <- as.POSIXct(datetime)

## Constructing and saving Plot 1
png("plot1.png", width=480, height=480)

globalActivePower <- as.numeric(dataSubset$Global_active_power)
hist(globalActivePower, main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

dev.off()

