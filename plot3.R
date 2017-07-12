

  #unlink("data",recursive = TRUE) 
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



##plot3
plot(power$timestamp,power$Sub_metering_1, xlab="",
     ylab="Energy sub metering",type="l")
lines(power$timestamp,power$Sub_metering_2,col="red")
lines(power$timestamp,power$Sub_metering_3,col="blue")
legend("topright",
       col=c("black","red","blue"),
       c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1,
       lwd=3,cex=.8)
dev.copy(png,file="plot3.png",width=480, height=480)
dev.off()
