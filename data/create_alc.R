# Ilkka Jokipii, 9.2.2017., Student alcohol consumption data exercise

library(dplyr)

mat <- read.csv("student-mat.csv", sep = ";", header = TRUE)
por <- read.csv("student-por.csv", sep = ";", header = TRUE)

head(por)
str(por)
summary(por)

head(mat)
str(mat)
summary(mat)

#joining data sets

join_by <- c("school", "sex", "age", "address", "famsize", "Pstatus", "Medu", "Fedu", "Mjob", "Fjob", "reason", "nursery","internet")

mat_por <- inner_join(mat, por, by = join_by, suffix = c(".mat", ".por"))
head(mat_por)

alc <- select(mat_por, one_of(join_by))


# the columns in the datasets which were not used for joining the data
notjoined_columns <- colnames(mat)[!colnames(mat) %in% join_by]

# print out the columns not used for joining
notjoined_columns

for(column_name in notjoined_columns) {
  # select two columns from 'math_por' with the same original name
  two_columns <- select(mat_por, starts_with(column_name))
  # select the first column vector of those two columns
  first_column <- select(two_columns, 1)[[1]]
  
  # if that first column vector is numeric...
  if(is.numeric(first_column)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[column_name] <- round(rowMeans(two_columns))
  } else { # else if it's not numeric...
    # add the first column vector to the alc data frame
    alc[column_name] <- first_column
  }
}

# creating new columns to the data set

alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)
alc$alc_use
glimpse(alc)

alc <- mutate(alc, high_use = alc_use > 2)
glimpse(alc)

#saving data
write.csv(alc, file= "alc.csv")



