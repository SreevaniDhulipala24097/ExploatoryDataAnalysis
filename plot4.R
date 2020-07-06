
df_epc <-  read.table(".\\household_power_consumption.txt",sep = ";", header = TRUE,na.strings="?")
df_epc$Date <- as.Date(df_epc$Date, format='%d/%m/%Y')

## set the date window 
date_range <-  c ("01/02/2007","02/02/2007")
date_tocheck<- as.Date(date_range,format("%d/%m/%Y"))

DATE1 = date_tocheck[1]
DATE2  = date_tocheck[2]


twodays <- subset(df_epc, df_epc$Date== DATE1|df_epc$Date==DATE2)




twodays$day <- weekdays(as.Date(twodays$Date,format("%Y-/%m-/%d") ))

twodays$datetime <- paste(twodays$Date,twodays$Time, sep=",")

twodays$datetimeforplot <- strptime(twodays$datetime, format="%Y-%m-%d,%H:%M:%S")

par(mfrow=c(2,2), mar= c(2,4,2,1))



plot(twodays$datetimeforplot, (as.numeric(as.character(twodays$Global_active_power))), type="l", ylab = "Global Active Power" , xlab="")

#Plot Voltage
plot(twodays$datetimeforplot,twodays$Voltage,  type="l", ylab = "Voltage" , xlab="datetime",ylim = c(min(twodays$Voltage), max(twodays$Voltage)))

#Plot Energy sub meter
plot(twodays$datetimeforplot,twodays$Sub_metering_1,  type="n", ylab = "Energy sub metering" , xlab="",ylim = c(0, max(twodays$Sub_metering_1, twodays$Sub_metering_2, twodays$Sub_metering_3)))
lines(twodays$datetimeforplot,twodays$Sub_metering_1, type="l", col="black")
lines(twodays$datetimeforplot,twodays$Sub_metering_2, type="l", col="red")
lines(twodays$datetimeforplot,twodays$Sub_metering_3, type="l", col="blue")

legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))

#Plot GLobal reactive power 
plot(twodays$datetimeforplot,twodays$Global_reactive_power,  type="l", ylab = "Global_reactive_power" , xlab="datetime",ylim = c(0.0,0.5))

dev.copy(png, file="plot4.png")

#Close PNG device
dev.off()

