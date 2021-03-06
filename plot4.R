# Read data set into R and format appropriately.
powerCon <- read.table('household_power_consumption.txt', header = TRUE, 
                       sep = ';', na.strings = '?')
powerCon$Date <- as.Date(powerCon$Date, format = '%d/%m/%Y')
powerCon$Time <- strptime(powerCon$Time, format = '%H:%M:%S')
powerCon$Time <- strftime(powerCon$Time, format = '%H:%M:%S')

# Subset relevant data for analysis. 
febPower <- powerCon[ which(powerCon$Date == '2007-2-1' | 
                                    powerCon$Date == '2007-2-2'),]

#Initialise text shrinking parameter.
par(cex = 0.75)

# Create column with time formated as required for graph.
febPower$DT <- as.POSIXlt(paste(febPower$Date, febPower$Time), 
                          format = '%Y-%m-%d %H:%M:%S')

# Initialise matrix-like table layout with 2 rows and 2 columns.
par(mfrow = c(2,2))

# Make tables.
plot(x = febPower$DT, y = febPower$Global_active_power, type = 'l', ylab = 
             'Global Active Power', xlab = '')

plot(x = febPower$DT, y = febPower$Voltage, type = 'l', ylab = 
             'Voltage', xlab = 'datetime')

plot(x = febPower$DT, y = febPower$Sub_metering_1, type = 'l', ylab = 
             'Energy sub metering', xlab = '')
lines(x = febPower$DT, y = febPower$Sub_metering_2, type = 'l', col = 'red')
lines(x = febPower$DT, y = febPower$Sub_metering_3, type = 'l', col = 'blue')
legend(x = 'topright', legend = c('Sub_metering_1', 'Sub_metering_2', 
        'Sub_metering_3'), col = c('black', 'red', 'blue'), lwd = 1, bty = 'n',
                                                        cex = 0.8)

plot(x = febPower$DT, y = febPower$Global_reactive_power, type = 'l', ylab = 
             'Global_reactive_power', xlab = 'datetime')

#Copy to PNG file.
dev.copy(png, file = 'plot4.png')
dev.off()