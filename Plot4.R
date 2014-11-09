# The data for dates Feb-1 and Feb-2 are in the rows from 66638 to 69517
# Hence read the file by skipping 66636 rows (1st row is the header) and read
# 2880 rows. This is probably not very efficient if the data is not 
# sequentially organized and if the number of rows is not known.
# this method of reading fixed number of rows is adopted only for ease.
# Else, reading the data sequentially is the best way

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

# Output will be a png file with 4 graphs. 
# Open the png file for drawing all 4 graphs
png ("Plot4.png", width=480, height=480, units="px", bg="white")

# Define the plot to contain 4 graphs - 2 in 1 row and 2 in another row
par (mfrow=c(2, 2))

# Draw Plot1
plot (DateTime, PowerData$Global_active_power, type="l", xlab="", ylab="Global Active Power")

# Draw Plot2
plot (DateTime, PowerData$Voltage, type="l", xlab="datetime", ylab="Voltage")

# Draw Plot 3
plot (DateTime, PowerData$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines (DateTime, PowerData$Sub_metering_2, col="red")
lines (DateTime, PowerData$Sub_metering_3, col="blue")
legend ("topright", col=c("black", "red", "blue"), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1, 1))

# Draw Plot 4
plot (DateTime, PowerData$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

# Save the .png file
dev.off()
