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
hist(as.numeric(tidyData2$Global_active_power),col="red",main="Global Active Power",xlab="Global Active Power (kilowatts)", ylab="Frequency", xlim=range(c(0,2,4,6)), breaks=13);
#Get the graphic from screen to a "device"
dev.copy(png, file="plot1.png", height=480, width=480);
#Closing device
dev.off();
