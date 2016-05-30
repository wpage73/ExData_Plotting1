###############################################################################
##  Check working directory & data existence                                 ##                           
###############################################################################
library(sqldf)

## Set Working Directory
working_directory <- "/Users/wpage6/Documents/MyRFolder/Course4/Week1"

if(getwd() != working_directory) {
  setwd(working_directory)
}

## file url to download
url1 <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

## Set/check this file name locally in the working directory
destfile1 <- "household_power_consumption.zip"

## We don't want to download the same thing over and over again. check a file in that dataset to see if it exists
if(!file.exists(destfile1)) {
  download.file(url = url1, destfile = destfile1, method = "curl")
  unzip(destfile1)
}

##dates in dd/mm/yyyy
##
filteredData <- read.csv.sql(file = "household_power_consumption.txt"
                             ,sql = "SELECT * FROM file WHERE [Date] = '2/2/2007' OR [Date] = '1/2/2007'"
                             , sep =";") 

filteredData$Date <- as.Date(filteredData$Date, format = "%d/%m/%Y")
filteredData$DateTime <- paste(filteredData$Date," ", filteredData$Time)
filteredData$DateTime <- strptime(filteredData$DateTime,"%Y-%m-%d %H:%M:%S")
par(family="mono")
plot(filteredData$DateTime,filteredData$Global_active_power
     , type="l"
     , xlab = ""
     , ylab = "Global Active Power (kilowatts)"
     )

axis(side = 1
     , at = as.Date(c("2007-02-01 00:00:00","2007-02-02 00:00:00","2007-02-03 00:00:00"))
     , labels = c("Thu", "Fri", "Sat"))

dev.copy(png,file = "plot2.png")
dev.off()

