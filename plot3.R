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

png("plot3.png", width=480, height=480)
combined <- paste(subdata$Date, subdata$Time)
subdata$combined <- strptime(combined, format = "%Y-%m-%d %H:%M:%S")

x <- subdata$combined
y1 <- as.numeric(paste(subdata$Sub_metering_1))
y2 <- as.numeric(paste(subdata$Sub_metering_2))
y3 <- as.numeric(paste(subdata$Sub_metering_3))


## Sub_metering_1
plot(x, y1, pch="", xlab="", ylab = "Energy sub metering")
lines(x,y1)

## Sub_metering_2
points(x, y2, pch="")
lines(x,y2, col="red")

## Sub_metering_3
points(x, y3, pch="")
lines(x,y3, col="blue")

legend("topright", lty=1, col=c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2",
                                                                     "Sub_metering_3"))

dev.off()




