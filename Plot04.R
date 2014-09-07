#Set English language
Sys.setlocale("LC_TIME", "English");
#Load data from csv file 
iniData<-read.csv("household_power_consumption.txt", sep=";", na.strings="?", header=T);
#Format Date column in order to easy sub setting information
iniData$Date<-as.Date(iniData$Date, format="%d/%m/%Y");
#Select range of dates
tidyData2<-subset(iniData, subset=(iniData$Date=="2007-02-01" | iniData$Date=="2007-02-02"));
#Concatenate data and time in first column 
datetimevec<-paste(as.Date(tidyData2$Date), tidyData2$Time);
#Formatting date time as POSIX 
tidyData2$Date<-as.POSIXct(datetimevec);
#Removing unused data
tidyData2$Time<-NULL;
#Setting query graphic parameters
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0));
#First graphic
plot(tidyData2$Global_active_power~tidyData2$Date, type="l", ylab="Global Active Power (kilowatts)", xlab="");
#Second Graphic
plot(tidyData2$Voltage~tidyData2$Date, type="l", ylab="Voltage (volt)", xlab="datetime");
#Third Graphic
plot(tidyData2$Sub_metering_1~tidyData2$Date, type="l", ylab="Energy sub metering", xlab=""); 
lines(tidyData2$Sub_metering_2~tidyData2$Date,col='Red'); 
lines(tidyData2$Sub_metering_3~tidyData2$Date,col='Blue');
#Adding legend 
legend("topright", pch=21, cex=0.5, col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),lty=1);
#Fourth Graphic
plot(tidyData2$Global_reactive_power~tidyData2$Date, type="l", ylab="Global_rective_power",xlab="datetime");
#Get the graphic from screen to a "device"
dev.copy(png, file="plot4.png", height=480, width=480);
#Closing device
dev.off();
