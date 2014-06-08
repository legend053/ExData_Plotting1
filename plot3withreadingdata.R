plot3<-function(){
  #Convert date format. Because R default date format is YYYY-mm-dd
  setAs("character","myDate", function(from) as.Date(from, format="%d/%m/%Y") )
  tmp <- c("1, 15/08/2008", "2, 23/05/2010")
  con <- textConnection(tmp)
  #read data. na.strings="?" turns ? to NA.
  epcdata<-read.table("household_power_consumption.txt",header=TRUE,sep=";",stringsAsFactors=FALSE,na.strings="?",colClasses=c("Date"="myDate"))
  #subset data for date="2007-02-01" and "2007-02-02"
  epcdatasel<-epcdata[epcdata[,"Date"] %in% as.Date(c("2007-02-01","2007-02-02")),]
  # also can use: epcdatasel<-epcdata[epcdata[,"Date"]>=as.Date("2007-02-01") & epcdata[,"Date"]<=as.Date("2007-02-02"),]
  #Add a new column and converting the format by as.POSIXct()
  epctime<-paste(epcdatasel$Date,epcdatasel$Time)
  epcdatasel$DateTime<-as.POSIXct(epctime)
  
  #Plot
  #First, building a png format picture with 480*480 pixels
  png(filename = "plot3.png", width = 480, height = 480, units = "px")
  #Second, building plot
  cols = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
  plot(epcdatasel$DateTime, epcdatasel$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering") #black is default
  lines(epcdatasel$DateTime, epcdatasel$Sub_metering_2, type="l", col="red") #Add another line from sub metering 2
  lines(epcdatasel$DateTime, epcdatasel$Sub_metering_3, type="l", col="blue")
  legend("topright", lty=1, lwd=1, col=c("black","blue","red"), legend=cols) #Add legend
  #Turn off graphics devices
  dev.off()
}