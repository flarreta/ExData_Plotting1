## Unzip the file
unzip ("d:/Users_info/LARRETAF/Documents/exdata_data_household_power_consumption.zip")

## Read the dataset
dataset <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?")

## Format Date column
dataset$Date <- as.Date(dataset$Date, "%d/%m/%Y")

## Subset dataset acording defined dates
dataset <- subset(dataset, Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

## Remove cases with missing values
dataset <- dataset[complete.cases(dataset),]

## Create new "DateTime" column with "Date" and "Time"
date_time <- paste(dataset$Date, dataset$Time)
date_time <- setNames(date_time, "DateTime")
dataset <- dataset[ ,!(names(dataset) %in% c("Date","Time"))]
dataset <- cbind(date_time, dataset)
dataset$date_time <- as.POSIXct(date_time)

##PLOT 4
png(filename = "plot4.png", height = 480, width = 480)
  par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
  with(dataset, {
    plot(Global_active_power~date_time, type="l", 
         ylab="Global Active Power", xlab="")
    plot(Voltage~date_time, type="l", 
         ylab="Voltage", xlab="datetime")
    plot(Sub_metering_1~date_time, type="l", 
         ylab="Global Active Power", xlab="")
    lines(Sub_metering_2~date_time,col='Red')
    lines(Sub_metering_3~date_time,col='Blue')
    legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
           legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    plot(Global_reactive_power~date_time, type="l", 
         ylab="Global_reactive_power",xlab="datetime")
    })
dev.off()