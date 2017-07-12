  temp <- tempfile("data")
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
  file <- unzip(temp,exdir="./data")
  ##unlink(temp)




fil <- file("./data/household_power_consumption.txt")
power <- read.table(text = grep("^[1,2]/2/2007", readLines(fil), 
                                value = TRUE),
                 col.names = c("Date", "Time", "Global_active_power",
                               "Global_reactive_power", "Voltage", 
                               "Global_intensity", "Sub_metering_1", 
                               "Sub_metering_2", "Sub_metering_3"),
                 sep = ";", header = TRUE)

power$Date <- as.Date(power$Date, format="%d/%m/%Y")


##plot1
power$Global_active_power = as.numeric(power$Global_active_power)
with(power,hist(Global_active_power,col="Red",
     main=paste("Global Active Power")
     ,xlab ="Global Active Power (kilowatts)"))
dev.copy(png,file="plot1.png",width=480, height=480)
dev.off()

