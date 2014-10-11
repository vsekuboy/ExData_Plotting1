# The data for dates Feb-1 and Feb-2 are in the rows from 66638 to 69517
# Hence read the file by skipping 66636 rows (1st row is the header) and read
# 2880 rows

RowNum <- 66636
NumRows <- 2880

DataDir="/Users/vijjisekuboyina/Coursera/Course4-Explore/data"
FileName="household_power_consumption.txt"

DataFile = sprintf ("%s/%s", DataDir, FileName)

PowerData <-read.table(DataFile, sep=";", header=TRUE, skip=RowNum, nrows=NumRows)

if (is.null(PowerData)) {
   stop ("Invalid Data File.....Exiting")
}

# Set the Column Names

colnames(PowerData)<-c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")

# For Creating the graph, convert date and time

DateTime<- strptime(paste(PowerData$Date, PowerData$Time), format="%d/%m/%Y %H:%M:%S")

# Plot a line graph into the file "Plot2.png"
png ("Plot2.png", width=480, height=480, units="px", bg="white")

plot (DateTime, PowerData$Global_active_power, type="l", xlab="", ylab="PowerData$Global_active_power")
dev.off()
