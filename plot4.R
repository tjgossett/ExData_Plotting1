library(dplyr)
library(data.table)

### Set Working Directory
setwd("/Users/tgossett/GitHub/ExData_Plotting1")

## Create a temp file to download data
temp <- tempfile()



## Goto online zip file to obtain the data
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", temp, method="curl")

## unzip the temp file
con <- unz(temp, "household_power_consumption.txt")

## create dataframe to hold all the data
data <- read.table(con, sep=";", header = TRUE, nrows = 70000)

## free memory and remove temp file
unlink(temp)

## Read the date as a character in the format  day/month/year format
data$newdate <- strptime(as.character(data$Date), "%d/%m/%Y")

## format the date in Year Month Day format
data$Date <- format(data$newdate, "%Y-%m-%d")

## Now filter for only the two date 02-01-2007 and 02-02-2007
data <- subset(data, Date == as.Date("2007-02-01") | Date == as.Date("2007-02-02"))

## ensure Voltage is read as number for graphing
data$Voltage <- as.numeric(as.character(data$Voltage))
##combine date and time to create a correct form for a POSIX variable

data$newtime <- as.POSIXct(paste(data$Date, data$Time), format="%Y-%m-%d %H:%M:%S")

## add padding of font size 11 to display graph correctly
par("ps" = 11)

#Create a multiple plot with 2 columns and 2 rows
par(mfrow=c(2,2))


##Create allplots
plot(data$newtime, data$Global_active_power, type = "l", xlab="", ylab="Global Active Power")
plot(data$newtime, data$Voltage, type = "l", xlab="", ylab="Voltage")

plot(data$newtime, data$Sub_metering_1, type = "l", xlab="", ylab="Energy sub metering")
lines(data$newtime,data$Sub_metering_2,col="red")
lines(data$newtime,data$Sub_metering_3,col="blue")


plot(data$newtime, data$Global_reactive_power, type = "l", xlab="", ylab="Global Active Power")
#Create a png plot ..default is 480x480
dev.copy(png,'plot4.png')
##Turn display off
dev.off()



