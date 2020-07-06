
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


plot(twodays$datetimeforplot, (as.numeric(as.character(twodays$Global_active_power))), type="l", ylab = "Global Active Power (kilowatts)" , xlab="")

dev.copy(png, file="plot2.png")

dev.off()

