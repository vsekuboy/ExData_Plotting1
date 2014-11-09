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

# Plot a line graph of 3 variables - Sub metering 1, 2 and 3 into the file "Plot3.png"
png ("Plot3.png", width=480, height=480, units="px", bg="white")

plot (DateTime, PowerData$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")

# Overlay the plot with other data in red and blue colors

lines (DateTime, PowerData$Sub_metering_2, col="red")
lines (DateTime, PowerData$Sub_metering_3, col="blue")

# Place the legend on top right corner of the graph

legend ("topright", col=c("black", "red", "blue"), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1, 1))

# Save the .png file
dev.off()
