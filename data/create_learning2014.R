#Ilkka Jokipii, 26.1.2017, Learning data exercises

learn <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)

dim(learn)
str(learn)
#Learning data has 183 observations and 60 variables. Table has 183 rows and 60 columns. Gender is the only variable that is not in integer format

library("dplyr")
library(ggplot2)
library(GGally)

#deep <- select(learn, starts_with("D")) Tulikin liikaa dataa mukaan tällä komennolla

deepQ <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D07","D14","D22","D30")
surfQ <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
straQ <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

deep <- select(learn, one_of(deepQ))
surf <- select(learn, one_of(surfQ))
stra <- select(learn, one_of(straQ))

deepKA <- rowMeans(deep)
surfKA <- rowMeans(surf)
straKA <- rowMeans(stra)

#combining the analysis data set
#gender, age, attitude, deep, stra, surf and points 
keep_columns <- c("gender","Age","Attitude", "Points")

learnComb <- select(learn, one_of(keep_columns))
learnComb$deep <- deepKA
learnComb$surf <- surfKA
learnComb$stra <- straKA

#removing zeroes

learning <- filter(learnComb, Points != 0)
str(learning)
summary(learning)

kuvaaja <- ggpairs(learning, mapping = aes(col = gender, alpha = 0.3), lower = list(combo = wrap("facethist", bins = 20)))

#saving data set
write.csv(learning, file= "learning.csv")





