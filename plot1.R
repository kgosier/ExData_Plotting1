#Ken Gosier
#Course Project 1
#Exploratory Data Analysis
#Coursera
#Oct 2015

#file should be run as: source("plot1.R")

#parameters etc

download <- FALSE
fileurl <- sprintf("%s/$s",
    "https://d396qusza40orc.cloudfront.net/",
    "exdata%2Fdata%2Fhousehold_power_consumption.zip")
local.zip <- "exdata-data-household_power_consumption.zip"
local.file <- "./household_power_consumption.txt"
testdate1 <- as.Date("2007-02-01")
testdate2 <- as.Date("2007-02-02")
plotheight <- 480
plotwidth <- 480

if (download) {
    if (file.exists(local.zip)) {
        file.remove(local.zip)
    }
    download.file(fileurl, local.zip)
    unzip(local.zip, overwrite = TRUE)
} else if (!file.exists(local.file)) {
    unzip(local.zip)
}

#read in data, convert 1st col to dates, and filter on test dates

raw.data <- read.table(local.file, header = TRUE, sep=";",
    stringsAsFactors = FALSE)
raw.data$Date <- as.Date(raw.data$Date, format="%d/%m/%Y")
I <- raw.data$Date == testdate1 | raw.data$Date == testdate2
raw.data <- raw.data[I,]

#convert cols to right classes. I'm sure there is a more elegant way
#to do this, but can't find it at the moment

raw.data <- mutate(raw.data, Time = sprintf("%s %s",
    as.character(Date,"%Y-%m-%d"), Time))
raw.data$Time <- strptime(raw.data$Time,
    format = "%Y-%m-%d %H:%M:%S")
raw.data$Global_active_power <- as.numeric(raw.data$Global_active_power)
raw.data$Global_reactive_power <- as.numeric(raw.data$Global_reactive_power)
raw.data$Voltage <- as.numeric(raw.data$Voltage)
raw.data$Global_intensity <- as.numeric(raw.data$Global_intensity)
raw.data$Sub_metering_1 <- as.numeric(raw.data$Sub_metering_1)
raw.data$Sub_metering_2 <- as.numeric(raw.data$Sub_metering_2)
raw.data$Sub_metering_3 <- as.numeric(raw.data$Sub_metering_3)

#make the plot, save in png

png(file = "plot1.png", width <- plotwidth, height <- plotheight)
hist(raw.data$Global_active_power, col = "red",
    main = "Global Active Power",
    xlab = "Global Active Power (kilowatts)")
dev.off()
