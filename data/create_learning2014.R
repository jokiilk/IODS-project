#Ilkka Jokipii, 26.1.2017, Learning data exercises

learn <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)

dim(learn)
str(learn)
#Learning data has 183 observations and 60 variables. Table has 183 rows and 60 columns. Gender is the only variable that is not in integer format

install.packages("dplyr")
library("dplyr")
R.version