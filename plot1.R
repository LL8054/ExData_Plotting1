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
png ("plot1.png", width=480, height=480)
hist(subdata$Global_active_power, col = "red", main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", ylab = "Frequency",)
dev.off()




