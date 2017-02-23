#Ilkka Jokipii


#read the data

human <- read.table("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human1.txt", sep= ",", header = TRUE)
human
str(human)
#Mutate the data: transform the Gross National Income (GNI) variable to numeric (Using string
#manipulation. Note that the mutation of 'human' was not done on DataCamp). (1 point)

library(dplyr)
library(stringr)

human$GNI <- str_replace(human$GNI, pattern=",", replace ="") %>% as.numeric()
human$GNI


#Exclude unneeded variables: keep only the columns matching the following variable names 
#(described in the meta file above):  "Country", "Edu2.FM", "Labo.FM", "Edu.Exp", "Life.Exp", 
#"GNI", "Mat.Mor", "Ado.Birth", "Parli.F" (1 point)

keep <- c("Country", "Edu2.FM", "Labo.FM", "Edu.Exp", "Life.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")

human_ <- select(human, one_of(keep))


#Remove all rows with missing values (1 point).

human_ <- filter(human_, complete.cases(human_))


#Remove the observations which relate to regions instead of countries. (1 point)

last <- nrow(human_) - 7
human_ <- human_[1:last, ]

#Define the row names of the data by the country names and remove the country name column 
#from the data. The data should now have 155 observations and 8 variables (corrected 21.2.) . 
#Save the human data in your data folder including the row names. You can overwrite your old 
#'human' data. (1 point)

rownames(human_) <- human_$Country
human_ <- select(human_, -Country)

#writing the data file
write.csv(human_, file= "human.csv")




