
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


##plot4
par(mfrow=c(2,2))
with(power,plot(timestamp,Global_active_power,type="l", xlab="", 
                ylab="Global Active Power"))
with(power,plot(timestamp,Voltage,type="l", xlab="datetime", 
                ylab="Voltage"))

plot(power$timestamp,power$Sub_metering_1, xlab="",
                ylab="Energy sub metering",type="l")
lines(power$timestamp,power$Sub_metering_2,col="red")
lines(power$timestamp,power$Sub_metering_3,col="blue")
legend("topright",
       col=c("black","red","blue"),
       c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1), 
       bty="n", cex=.5)
with(power,plot(timestamp,Global_reactive_power,type="l", xlab="datetime", 
                ylab="Global_reactive_power",ylim=c(0,0.5)))
dev.copy(png,file="plot4.png",width=480, height=480)
dev.off()