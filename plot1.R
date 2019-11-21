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

##PLOT 1
png(filename = "plot1.png", height = 480, width = 480)
  with(dataset, hist(Global_active_power, main="Global Active Power", xlab = "Global Active Power (kilowatts)", col="red"))
dev.off()
