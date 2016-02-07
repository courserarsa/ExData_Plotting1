##  Exploratory Data Analysis
##  Course Project 1

plot4 <- function() {

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
    par(mfcol = c(2, 2),mar=c(5,4,5,2), cex=0.65)
    with(pwrdata, {
    
    plot(datetime, Global_active_power, type="l",
         ylab="Global Active Power", xlab="")
    
    
    plot(datetime, Global_active_power, yaxt="n",
         type="n", ylab="Energy sub metering", ylim=c(0,40), xlab="")
    axis(2,at=seq(0,30,by=10),las=1)
    lines(datetime, Sub_metering_1, col="black")
    lines(datetime, Sub_metering_2, col="red")
    lines(datetime, Sub_metering_3, col="blue")
    legend("topright", lty=1, lwd=1, cex=0.65, col = c("black", "red", "blue"), 
           legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    
    plot(datetime, Voltage, type="l")
    
    plot(datetime, Global_reactive_power, type="l")
    
    })
##  Output graphs to png file
    dev.copy(png, file="plot4.png", res=60)
    dev.off()
}
    
