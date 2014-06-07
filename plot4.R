df <- read.csv("household_power_consumption.txt", sep = ";", skip = 65000, nrows = 5000
               , col.names = c("Date","Time","Global_active_power", "Global_reactive_power",
                               "Voltage", "Global_intensity", "Sub_metering_1", 
                               "Sub_metering_2", "Sub_metering_3"))


date1 <- as.Date("2007-02-01")
df$Date = as.Date(df$Date, format ="%d/%m/%Y")

df$Time = paste(df$Date, df$Time)
df$Time = strptime(df$Time, format ="%Y-%m-%d %H:%M:%S")


new_df <- subset(df, df$Date >= date1 & df$Date <= (date1+1))

par(mfrow = c(2, 2), cex = 0.7, bg=NA)

with(new_df, plot(Time, Global_active_power, type = "l",
                  xlab = "", ylab ="Global Active Power"))

with(new_df, plot(Time, Voltage, type = "l",
                  xlab = "datetime", ylab ="Voltage"))


with(new_df, plot(Time, as.numeric(Sub_metering_1), type = "l",
                  xlab = "", ylab ="Energy sub metering"))
with(new_df, lines(Time, as.numeric(Sub_metering_2), col ="red"))
with(new_df, lines(Time, as.numeric(Sub_metering_3), col ="blue"))
legend("topright", lwd = 2, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       bty = "n")


with(new_df, plot(Time, Global_reactive_power, type = "l",
                  xlab = "datetime"))

dev.copy(png, file = "./figure/plot4.png")
dev.off()
