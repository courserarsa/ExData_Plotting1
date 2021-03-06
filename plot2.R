##  Exploratory Data Analysis
##  Course Project 1

plot2 <- function() {

##  Download and unzip file
    if(!file.exists("./data")){dir.create("./data")}
    fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(fileUrl,destfile="./data/household_power_consumption",
              method="auto")
    unzip("./data/household_power_consumption",exdir="./data")
    closeAllConnections()

##  Read data
    library(dplyr)
    readfile <- "./data/household_power_consumption.txt"
    dataclass <- c("character","character","numeric","numeric","numeric",
                   "numeric","numeric","numeric","numeric")
    pwrdata <- read.table(readfile, header = TRUE, sep = ";", na.strings="?",
                          nrows=2075259, colClasses=dataclass)
    pwrdata <- filter(pwrdata, Date %in% c("1/2/2007", "2/2/2007"))
    pwrdata$datetime <- strptime(paste(as.Date(pwrdata$Date, "%d/%m/%Y"),
                                     pwrdata$Time), format="%Y-%m-%d %H:%M:%S")
    closeAllConnections()
    
##  Plot data
    plot(pwrdata$datetime, pwrdata$Global_active_power,
         type="l",
         ylab="Global Active Power (kilowatts)",
         xlab=""
         )
         
##  Output graph to png file
    dev.copy(png, file="plot2.png")
    dev.off()
    
}

