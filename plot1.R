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

## Instructions: Create a histogram w/ 0-1200 on Y labeled frequency and 0-6 on y labeled Global Active Power (kilowatts)
hist(filteredData$Global_active_power
    , main = "Global Active Power"
    , xlab = "Global Active Power (kilowatts)"
    , ylab = "Frequency"
    , col = "Red"
    )

#Copy to .png file named plot1.png
dev.copy(png,file = "plot1.png")
dev.off()