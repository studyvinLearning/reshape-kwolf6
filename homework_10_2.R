# Download and read in the bloodPressure.RDS file
# each row is a person
# blood pressure is measure with two values: systolic and diastolic
# each persons blood pressure was measured every day for a month
# reshape the data to only have 4 columns: person, date, systolic/diastolic, and the value
# fix the date to be in the nice format for R
# calculate the mean diastolic and the mean systolic by the days of the week
# You should be turning in 2 separate R files. If you do not understand something then ask the instructor before the due date.


bloodpressure<-readRDS("bloodPressure.RDS")
column_names<-names(bloodpressure)
head(bloodpressure)

library(tidyr)
library(dplyr)

reshaped_data <- bloodpressure %>%
  pivot_longer(cols = -person, names_to = "date_measurement", values_to = "value") %>%
  separate(date_measurement, c("measurement_type", "date"), sep = " ", remove = FALSE) %>%
  select(person, date, measurement_type, value)

reshaped_data$date[1]

reshaped_data$date<-as.Date(reshaped_data$date, format = "%Y-%b-%d")
View(reshaped_data)
aggregate(value~measurement_type + weekdays(reshaped_data$date), data = reshaped_data, FUN =mean)
