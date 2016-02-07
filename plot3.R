## Data Science Specialization: Exploratory Data Analysis Course Project

# Student: Rodrigo Peres Ferreira
# Date: 2016-02-07

## Part 1: Loading the Data

## Load the data from the file, skiping the 66636 lines before 01/02/2007
## (format day/month/year) and reading 2880 rows until 02/02/2007 23:59:00
## (format day/month/year hour:minute:second)

power_consumption <- read.csv2("household_power_consumption.txt", 
                               col.names = c("Date","Time","Global_active_power"
                                             ,"Global_reactive_power","Voltage",
                                             "Global_intensity","Sub_metering_1"
                                             ,"Sub_metering_2","Sub_metering_3")
                               ,na.strings="?", skip = 66636, nrows = 2880)

## Concatenate date and time

date_str <- paste(power_consumption$Date, power_consumption$Time)
Date_Time <- strptime(date_str, "%d/%m/%Y %H:%M:%S")

power_consumption <- cbind("Date_time" = Date_Time, power_consumption[,3:9])

## Convert "Sub_metering_1", "Sub_metering_2" and "Sub_metering_3" fields into
## numeric fields 

power_consumption$Sub_metering_1 <- as.character(power_consumption$Sub_metering_1)
power_consumption$Sub_metering_1 <- as.numeric(power_consumption$Sub_metering_1)

power_consumption$Sub_metering_2 <- as.character(power_consumption$Sub_metering_2)
power_consumption$Sub_metering_2 <- as.numeric(power_consumption$Sub_metering_2)

power_consumption$Sub_metering_3 <- as.character(power_consumption$Sub_metering_3)
power_consumption$Sub_metering_3 <- as.numeric(power_consumption$Sub_metering_3)


## Part 2: Making Plots

## Open the PNG device, make the Plot 3 in the device and close the device

png(file = "plot3.png")

plot(power_consumption$Date_time,power_consumption$Sub_metering_1,
     type = "l", xlab = "", ylab = "Energy sub metering")

lines(power_consumption$Date_time,power_consumption$Sub_metering_2, col = "red")
lines(power_consumption$Date_time,power_consumption$Sub_metering_3, 
      col = "blue")
legend("topright", lwd = 1, col = c("black", "red","blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))

dev.off()