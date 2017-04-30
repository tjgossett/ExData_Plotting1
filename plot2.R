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
## ensure Global active Power is read as number for graphing

data$Global_active_power <- as.numeric(as.character(data$Global_active_power))


##combine date and time to create a correct form for a POSIX variable
data$newtime <- as.POSIXct(paste(data$Date, data$Time), format="%Y-%m-%d %H:%M:%S")

## add padding of font size 11 to display graph correctly
par("ps" = 11)

##Create the plot
plot(data$newtime, data$Global_active_power, type = "l", xlab="", ylab="Global Active Power (kilowatts)")

#Create a png plot ..default is 480x480
dev.copy(png,'plot2.png')
##Turn display off
dev.off()
