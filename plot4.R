## Step 1: Read and prepare the data
datafile <- "household_power_consumption.txt" #Assuming the input file is in the working directory

# Knowing that the required values (Feb 1st and 2nd 2007) are in this row range, we read only a small subset of the file.
d <- read.table(datafile, sep=";",skip = 66000, nrow = 4000,col.names = colnames(read.table(datafile, sep=";",nrow = 1, header = TRUE)))
t<-transform(d,Date=as.Date(Date,"%d/%m/%Y"))
t$datetime <- strptime(paste(d$Date,t$Time),"%d/%m/%Y %H:%M:%S")
f <- t[t$Date=="2007-02-01" | t$Date== "2007-02-02",]

## Step 2: Write the required plot to an image file, in PNG format
png(file="plot4.png")
par(mfrow=c(2,2)) # plots to appear in 2 rows and 2 columns matrix

with(f,{
  
  plot(datetime,Global_active_power,type="l",ylab="Global Active Power",xlab="")
  
  plot(datetime,Voltage,type="l")
    
  plot(datetime,Sub_metering_1,type="l",ylab="Energy sub metering",xlab="")
  lines(datetime,Sub_metering_2,col="red")
  lines(datetime,Sub_metering_3,col="blue")
  legend("topright",lwd=1,bty="n",col=c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
  
  plot(datetime,Global_reactive_power,type="l")
  
})

dev.off()