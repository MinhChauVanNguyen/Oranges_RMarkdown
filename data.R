orange <- read.csv("oranges.csv", header = TRUE, stringsAsFactors = FALSE)
familyA <- orange[orange$Name == "A", ]

ts.A <- ts(familyA$Total, frequency = 12,
           start = c(2013, 1), end = c(2019, 12))

new.tsA <- window(ts.A, start = c(2016, 1))

training <- window(new.tsA, start = c(2016,1), end = c(2017,12))
test <- window(new.tsA, start = c(2018,1), end = c(2018, 12))