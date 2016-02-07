##  Exploratory Data Analysis
##  Course Project 1

plot3 <- function() {

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
    par(cex=0.8)
    plot(pwrdata$datetime, pwrdata$Global_active_power, yaxt="n",
         type="n", ylab="Energy sub metering", ylim=c(0,40), xlab="")
    axis(2,at=seq(0,30,by=10),las=1)
    lines(pwrdata$datetime, pwrdata$Sub_metering_1,
          col="black")
    lines(pwrdata$datetime, pwrdata$Sub_metering_2,
          col="red")
    lines(pwrdata$datetime, pwrdata$Sub_metering_3,
          col="blue")
    legend("topright", lty=1, lwd=1,
           col = c("black", "red", "blue"), 
           legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
         
##  Output graph to png file
    dev.copy(png, file="plot3.png", res=60)
    dev.off()
}
    
