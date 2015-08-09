# input data and convert to strings
# zip file from https://archive.ics.uci.edu/ml/machine-learning-databases/00235/

pwrData <- read.csv(file = "./data/household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE,
                    strip.white = TRUE, na.strings = c("NA",""))

#inspect types
str(pwrData)

#create timestamp from Date and Time
x<- within(pwrData, { timeStamp= strptime(paste(pwrData$Date, pwrData$Time), format = "%d/%m/%Y %H:%M:%S")})
head (x)

# restrict to the requested date range 2007-02-01 and 2007-02-02 and filter any timeStamp that is NA
xx <- x[x$timeStamp >= as.POSIXlt("2007-02-01") & x$timeStamp < as.POSIXlt("2007-02-03") & !is.na(x$timeStamp), c(3,4,5,6,7,8,9,10)]
summary(xx)

# convert to numeric
xx <- within(xx,{gap = as.numeric(xx$Global_active_power)})
xx$Global_active_power <- NULL
summary(xx)

xx <- within(xx,{grp = as.numeric(xx$Global_reactive_power)})
xx$Global_reactive_power <- NULL
summary(xx)

xx <- within(xx,{voltage = as.numeric(xx$Voltage)})
xx$Voltage <- NULL
summary(xx)

xx <- within(xx,{globalIntensity = as.numeric(xx$Global_intensity)})
xx$Global_intensity <- NULL
summary(xx)

xx <- within(xx,{sm1 = as.numeric(xx$Sub_metering_1)})
xx$Sub_metering_1 <- NULL
summary(xx)

xx <- within(xx,{sm2 = as.numeric(xx$Sub_metering_2)})
xx$Sub_metering_2 <- NULL
summary(xx)

xx <- within(xx,{sm3 = as.numeric(xx$Sub_metering_3)})
xx$Sub_metering_3 <- NULL
summary(xx)

# plot sm1 time series
plot(xx$timeStamp, xx$sm1, type = "l", ylab = "Energy sub metering", xlab = "")
# add sm2 time series
points(xx$timeStamp, xx$sm2, type = 'l', col = "red")
#add sm3 time series
points(xx$timeStamp, xx$sm3, type = 'l', col = "blue")
# add legend
legend("topright", col = c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty = c(1,1,1),
       lwd = c(2,2,2))

dev.copy(png,"./plots/plot3.png")
dev.off()
