plot2<-function(){
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
  png(filename = "plot2.png", width = 480, height = 480, units = "px")
  #Second, building plot
  plot(epcdatasel$DateTime, epcdatasel$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
  #Turn off graphics devices
  dev.off()
}