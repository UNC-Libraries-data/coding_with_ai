library(ggplot2)
library(dplyr)

# Load the data
data <- read.csv("protest_data.csv")

# change start and end day, month, and year columns to ints
data$startday <- as.integer(data$startday)
data$endday <- as.integer(data$endday)
data$startmonth <- as.integer(data$startmonth)
data$endmonth <- as.integer(data$endmonth)
data$startyear <- as.integer(data$startyear)
data$endyear <- as.integer(data$endyear)

# create a new column that combines the startyear/month/year columns
data$startdate <- as.Date(paste(data$startyear, data$startmonth, data$startday, sep="/"))


# create a new column that combines the endyear/month/year columns
data$enddate <- as.Date(paste(data$endyear, data$endmonth, data$endday, sep="/"))

# create a new column that calculates the duration of the protest
data$duration <- as.numeric(data$enddate - data$startdate)

# plot the rows per startyear on a line graph with blue lines and size 3 points
data %>%
  group_by(startyear) %>%
  summarise(n = n()) %>%
  ggplot(aes(x = startyear, y = n)) +
  geom_line() +
  geom_point() +
  labs(title = "Number of protests per year",
       x = "Year",
       y = "Number of protests") +
  theme_minimal()

