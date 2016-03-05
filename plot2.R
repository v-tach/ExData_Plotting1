library(dplyr)
library(lubridate)

## Importing data
download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "data.zip")

unzip("data.zip")

hh_power_cons <- read.csv2("household_power_consumption.txt", stringsAsFactors = FALSE, na.strings = "?")

hh_power_cons$Date <- as.Date(hh_power_cons$Date,
                        format = "%d/%m/%Y")
hh_power_cons <- tbl_df(hh_power_cons)
hh_power_cons[,3:9] <- sapply(hh_power_cons[,3:9], as.numeric)

start_date <- ymd("2007-02-01")
days_of_interest <- interval(start_date, start_date + days(1))
hh_power_cons <- hh_power_cons %>% 
            mutate(datetime = ymd_hms(paste(Date, Time, sep = " "))) %>%
            filter(Date %within% days_of_interest)

## Create plot1.png
#
#png(filename = "plot1.png")
#hist(hh_power_cons$Global_active_power, 
#        main = "Global Active Power",
#        col = "red",
#        xlab = "Global Active Power (kilowatts)")
#dev.off()       

# Create plot2.png

png(filename = "plot2.png")
with(hh_power_cons,
plot(x = datetime, y = Global_active_power,
    type = "l",
    xlab = "",
    ylab = "Global Active Power (kilowatts)"))
dev.off()

## Create plot3.png
#
#png("plot3.png")
#with(hh_power_cons,
#    plot(x = datetime, y= Sub_metering_1, type = "l",
#        xlab = "", ylab = "Energy sub metering"))
#with(hh_power_cons, 
#    lines(x = datetime, y = Sub_metering_2, col = "red"))
#with(hh_power_cons, 
#    lines(x = datetime, y = Sub_metering_3, col = "blue"))
#legend("topright",
#    lty = 1,
#    col = c("black", "red", "blue"),
#    legend = names(hh_power_cons)[7:9])
#dev.off()
#
## Create plot4.png
#
#png("plot4.png")
#par(mfrow = c(2,2))
#with(hh_power_cons,
#plot(x = datetime, y = Global_active_power,
#    type = "l",
#    xlab = "",
#    ylab = "Global Active Power (kilowatts)"))
#
#
#with(hh_power_cons,
#plot(x = datetime, y = Voltage,
#    type = "l"
#    ))
#
#with(hh_power_cons,
#    plot(x = datetime, y= Sub_metering_1, type = "l",
#        xlab = "", ylab = "Energy sub metering"))
#with(hh_power_cons, 
#    lines(x = datetime, y = Sub_metering_2, col = "red"))
#with(hh_power_cons, 
#    lines(x = datetime, y = Sub_metering_3, col = "blue"))
#legend("topright",
#    lty = 1,
#    col = c("black", "red", "blue"),
#    legend = names(hh_power_cons)[7:9]) 
#    
#with(hh_power_cons,
#plot(x = datetime, y = Global_reactive_power,
#    type = "l"
#    ))
#    
#dev.off()
#
