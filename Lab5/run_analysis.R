```r
>download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip","UCIdata.zip", mode = "wb")
>unzip("UCIdata.zip", files = NULL, exdir=".")

> subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
> subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
> x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
> x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
> y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
> y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
> activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
> features <- read.table("UCI HAR Dataset/features.txt")
```
---------------------

1. Об’єднує навчальний та тестовий набори, щоб створити один набір даних
```r
> dataSet <- rbind(x_train, x_test)
> dataSet
```
---------------------

2. Витягує лише вимірювання середнього значення та стандартного
відхилення (mean and standard deviation) для кожного вимірювання.
```r
> dataSet <- grep("mean()|std()", features[, 2]) 
> dataSet
```
---------------------

3. Використовує описові назви діяльностей (activity) для найменування
діяльностей у наборі даних.
```r
> factor <- factor(result$activity)
> levels(factor) <- activity_labels[,2]
> result$activity <- factor
```
---------------------

4. Відповідно присвоює змінним у наборі даних описові імена.
```r
featureNames <- sapply(features[, 2], function(x) {gsub("[()]", "",x)})
> featureNames
> subject <- rbind(subject_train, subject_test)
> activity <- rbind(y_train, y_test)
> names(subject) <- 'subject'
> names(activity) <- 'activity'
> result <- cbind(subject,activity, dataSet2)
```
---------------------

5. З набору даних з кроку 4 створити другий незалежний акуратний набір
даних (tidy dataset) із середнім значенням для кожної змінної для кожної
діяльності та кожного суб’єкту (subject).
```r
install.packages("reshape2")
library("reshape2")
> meltedData <- melt(result,(id.vars=c("subject","activity")))
> dataSet <- dcast(meltedData, subject + activity ~ variable, mean)
> dataSet
```