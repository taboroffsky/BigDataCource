----------------------

1. За допомогою download.file() завантажте любий excel файл з порталу http://data.gov.ua та зчитайте його (xls, xlsx – бінарні формати, тому встановить mode = “wb”. Виведіть перші 6 строк отриманого фрейму даних.
```r
> download.file("https://data.gov.ua/dataset/2db9a1f0-a295-4ced-b7bd-0523cf3f25b6/resource/81037a1c-5f3e-434a-8108-3b1be1cf11fd/download/zvit-0813230.xls",destfile="file.xlsx",method="libcurl", mode="wb")
> library(readxl)
> file <- read_excel("file.xlsx")
> head(file, n=6)

# A tibble: 6 x 13
  ...1                ...2   ...3  ...4  ...5                   ...6  ...7  ...8  ...9  `ЗАТВЕРДЖЕНО\nНаказ Міністерства фінансів~ ...11 ...12 ...13
  <chr>               <chr>  <chr> <chr> <chr>                  <chr> <chr> <chr> <chr> <chr>                                      <chr> <chr> <chr>
1 NA                  NA     NA    NA    NA                     NA    NA    NA    NA    NA                                         NA    NA    NA   
2 NA                  NA     NA    NA    NA                     NA    NA    NA    NA    NA                                         NA    NA    NA   
3 NA                  NA     NA    NA    NA                     NA    NA    NA    NA    NA                                         NA    NA    NA   
4 Звіт                NA     NA    NA    NA                     NA    NA    NA    NA    NA                                         NA    NA    NA   
5 про виконання пасп~ NA     NA    NA    NA                     NA    NA    NA    NA    NA                                         NA    NA    NA   
6 1.                  08000~ NA    NA    Орган з питань праці ~ NA    NA    NA    NA    NA                                         NA    NA    NA   
```

### Думаю, це проблеми з локалізацією моєї ОС. Не став доскачувати пакети з мовами.

----------------------

2. За допомогою download.file() завантажте файл getdata_data_ss06hid.csv за посиланням https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv та завантажте дані в R. Code book, що пояснює значення змінних знаходиться за ##посиланням https://www.dropbox.com/s/dijv0rlwo4mryv5/PUMSDataDict06.pdf?dl=0. Необхідно знайти, скільки property мають value $1000000+
```r
> download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv", destfile="file.csv", method="curl")
> rowData <- read.table("file.csv", sep=",", header=TRUE)
> sum(!is.na(rowData$VAL[rowData$VAL==24]))
[1] 53
```

----------------------

3. Зчитайте xml файл за посиланням http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml. Скільки ресторанів мають zipcode 21231?
```r
> file <- xmlTreeParse("http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml", useInternal=TRUE)
> root <- xmlRoot(file)
> sum(xpathSApply(root, "//zipcode", xmlValue)==21231)
[1] 127
```
