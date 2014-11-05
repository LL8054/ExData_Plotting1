##assumes you have "household_power_consumption.txt" downloaded and in the working directory. 
##if not, the zipped file can be downloaded at 
##https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip



library(datasets)

data <- read.table("household_power_consumption.txt", header = TRUE, sep =";")

## process to change the date column into date class
dateChar <- paste(data[,1])
date <- as.Date(dateChar, "%d/%m/%Y")
data[,1] <- c(date)

jul1 <- grep("2007-02-01", data$Date)
jul2 <- grep("2007-02-02", data$Date)

ljul1 <- length(jul1)
ljul2 <- length(jul2)

subdata1 <- data[jul1[1]:jul1[ljul1],]
subdata2 <- data[jul2[1]:jul2[ljul2],]
subdata <- rbind(subdata1, subdata2)
rm(data, subdata1, subdata2, date, dateChar, jul1, jul2, ljul1, ljul2)

subdata$Global_active_power <- as.numeric(paste(subdata$Global_active_power))
combined <- paste(subdata$Date, subdata$Time)
subdata$combined <- strptime(combined, format = "%Y-%m-%d %H:%M:%S")

subdata$Voltage <- as.numeric(paste(subdata$Voltage))

x <- subdata$combined

yGap <- subdata$Global_active_power
yV <- subdata$Voltage
y1 <- as.numeric(paste(subdata$Sub_metering_1))
y2 <- as.numeric(paste(subdata$Sub_metering_2))
y3 <- as.numeric(paste(subdata$Sub_metering_3))
yGrp <- as.numeric(paste(subdata$Global_reactive_power))

png("plot4.png", width=480, height=480)
par(mfrow=c(2,2))
with(subdata, {
        ## plot 1
        plot(x, yGap, type="n", xlab ="", ylab = "Global Active Power")
        lines(x,yGap)
        
        ## plot 2
        plot(x,yV, type="n", xlab ="datetime", ylab= "Voltage")
        lines(x,yV)
        
        ## plot 3
        plot(x, y1, pch="", xlab="", ylab = "Energy sub metering") ## Sub_metering_1
        lines(x,y1)
        points(x, y2, pch="")  ## Sub_metering_2
        lines(x,y2, col="red")
        points(x, y3, pch="")  ## Sub_metering_3
        lines(x,y3, col="blue")
        legend("topright", bty="n", lty=1, col=c("black", "red", "blue"), legend = c("Sub_metering_1", 
                                                                            "Sub_metering_2",
                                                                            "Sub_metering_3"))

        #plot 4
        plot(x, yGrp, type="n", xlab="datetime", ylab="Global_reactive_power")
        lines(x,yGrp)
                
})


dev.off()




