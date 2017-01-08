library(dplyr)
library(stringr)
library(tidyr)

# Download and extract data

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
              "data.zip")
unzip("data.zip", files = "UCI HAR Dataset", exdir = "data")

# Load meta-data

features <- read.table("data/features.txt")[,2]
duplicate <- duplicated(features)

activities <- read.table("data/activity_labels.txt")
names(activities) <- c("activity.label", "activity")

# Load training data

x.train <- read.table("data/train/X_train.txt",
                      colClasses = "numeric",
                      comment.char = "")
names(x.train) <- features

y.train <-read.table("data/train/y_train.txt")
names(y.train) <- c("activity.label")

subject.id.train <- read.table("data/train/subject_train.txt")
names(subject.id.train) <- c("subject.id")

# Load test data

x.test <- read.table("data/test/X_test.txt",
                     colClasses = "numeric",
                     comment.char = "")
names(x.test) <- features

y.test <-read.table("data/test/y_test.txt")
names(y.test) <- c("activity.label")

subject.id.test <- read.table("data/test/subject_test.txt")
names(subject.id.test) <- c("subject.id")

# Select only relevant columns: mean and standard deviation of measurements.
# Drop first all columns with duplicate names because they lead to an error
# in dplyr::select. These are the bandEnergy() entries. We don't need them.

x.train <- select(x.train[!duplicate],
                  contains("-mean()"),
                  contains("-std()"))

x.test <- select(x.test[!duplicate],
                 contains("-mean()"),
                 contains("-std()"))

# Merge rows of training and test data

x.merged <- bind_rows(x.train, x.test)
y.merged <- bind_rows(y.train, y.test)
subject.id.merged <- bind_rows(subject.id.train, subject.id.test)

#rm(x.train, x.test, y.train, y.test)

# Merge all data into single table, merge activity labels on activity id,
# then drop activity id

data <- bind_cols(x.merged, y.merged, subject.id.merged)
data <- data %>%
    merge(activities, by = c("activity.label")) %>%
    select(-activity.label)

# Calculate column means for each combination of activity and subject

data.means <- data %>% 
  group_by(activity, subject.id) %>%  # Split data by activity and subject
  summarize_each(funs(mean)) # Grouped column means

# Tidy the data

data.means.tidy <- data.means %>%
     gather(key, value, -activity, -subject.id) %>%
     separate(key, into=c("variable", "statistic", "axis"), sep=c("-", "-"), extra="merge") %>%
     # remove "()" in statistic
     mutate(statistic=str_replace(statistic, "\\(\\)", "")) %>%
     unite(variable, variable, statistic, axis, sep=".") %>%
     # some variable names now end in ".NA" because they don't measure along an axis -> remove .NA
     mutate(variable=str_replace(variable, "\\.NA", "")) %>%
     spread(key=variable, value=value)

# Write tidy data to CSV file

write.csv(data.means.tidy, file="tidy.csv")
