#Information Visualization Coursework 2023-24
#Student id - 20610206

#The following analysis has been done on the SmokeBan.csv dataset.

#Installing the packages necessary to plot visualizations.
install.packages("tidyverse")
install.packages(c("ggplot2", "dplyr"))
update.packages(ask = FALSE)

#Initializing the libraries downloaded.
library(ggplot2)
library(dplyr)
library(tidyverse)

#Reading the SmokeBan.csv file from file path into "read_data". 
read_data <- read.csv("C:\\Users\\brend\\OneDrive\\Desktop\\InfoViz Project\\SmokeBan.csv")

#Displaying the dataset at hand. 
print(read_data)

#Data Cleaning
#Checking for missing values in the dataset.
missing_data <- any(is.na(read_data))
print(missing_data)
  if (missing_data == TRUE){
  print("There are missing values in the dataset.")
  } else { 
  print("There are no missing values.")
}
  
#Checking for NULL values in columns. 
column_values <- colSums(is.na(read_data))
print(column_values)  

#Short summary of the information.
str(read_data)
summary(read_data)

#Total number of columns and rows
cat("The total number of columns in the dataset is: ",ncol(read_data))
cat("The total number of rows is: ", nrow(read_data))

#Column names in the dataset.
cat("Name of the Variables are: ", names(read_data))

#Dimension of the dataset.
cat("Dimensions :",dim(read_data))

#Checking Min and max value of age.
min_data <- min(read_data$age)
print(min_data)
max_data <- max(read_data$age)
print(max_data)

 
#Question 1
#Is there a majority of smokers or non smokers in the dataset?

#Calculate the percentage of non_smokers and smokers
percent <- prop.table(table(read_data$smoker)) * 100

#Creating a bar graph illustrating non-smokers vs smokers.
ggplot(read_data , aes(x = smoker , fill = smoker))+
  geom_bar() + 
  geom_text(stat = 'count', aes(label = after_stat(count)), vjust = -0.55, size = 5) +
  geom_text(stat = 'count', aes(label = paste0(sprintf("%.1f", percent[as.numeric(after_stat(x))]), "%")),
            position = position_stack(vjust = 0.55), size = 5, color = "white") + 
  scale_fill_manual( values = c("dodgerblue1" , "tomato1"))+
  ggtitle("Non Smokers v/s Smokers Graph") +
  theme_classic() 
print("There is a majority of Non-Smokers in the dataset. ")


#Question 2 
#Is there a surplus of male or female smokers?

#Filter only the smokers in the dataset. 
only_smokers <- subset(read_data, smoker == "yes")

#Calculate the percentage of female smokers vs male smokers.
percentage1 <- prop.table(table(only_smokers$gender)) * 100

#Creating a bar graph illustrating female smokers vs male smokers.
ggplot(only_smokers, aes(x= gender, fill = gender)) +
  geom_bar()+
  geom_text(stat = 'count', aes(label = paste0(sprintf("%.1f", percentage1[as.numeric(after_stat(x))]), "%")),
            position = position_stack(vjust = 0.55), size = 5.5, color = "white") +
  geom_text(stat = 'count', aes(label = after_stat(count)), vjust = -0.55, size = 4.5) +
  ggtitle(" Female Smokers v/s Male Smokers Graph") +
  scale_fill_brewer(palette = "Set1")+
  theme_classic()
print("There are more female smokers in the dataset.")


#Question 3
#How many smoking bans exist in the dataset?

##Creating a bar plot depicting workplace ban.
ggplot(read_data, aes(x = ban, fill = ban)) +
  geom_bar() +
  geom_text(stat = 'count', aes(label = after_stat(count)), vjust = -0.5, size = 5) +
  scale_fill_brewer(palette = "Set2")+
  ggtitle("Amount of bans at workplaces.")+
  theme_classic()
print("There are 6098 bans put in place at workplaces.")


#Question 4
#Has the smoking ban affected the number of smokers?

#preparing the data by calculating the number and ratio of smokers per ban.
smokers_data <- read_data %>%
  group_by(ban,smoker) %>%
  summarize(count = n()) %>%
  mutate(difference = count / sum(count))

#Grouped bar graph is used to depict the information.
ggplot(smokers_data , aes(x = ban, y = difference , fill = smoker))+
  geom_bar(stat = "identity", position = "dodge") +
  ggtitle("The impact of the ban on Smokers")+
  labs( x = "Ban", y = "difference")+
  scale_fill_brewer( palette = "Set2")+
  geom_text(aes(label = scales::percent(difference)), 
            position = position_dodge(width = 1.2), vjust = -0.7, size = 3.55) +
  theme_replace()

print("Hence, post ban, the percentage of smokers drops from 29.0% to 21.2%. ")


#Question 5
#How does age group vary within the dataset?

#We visualize the age using a histogram.
ggplot(read_data, aes(x = age)) +
  geom_histogram(binwidth = 2,fill = "purple", colour = "white")+
  ggtitle("Age of the Individuals")+
  theme_classic()

  
#Question 6
#How do smoking habits change with age? Is there a trend seen as age increases? 

#A histogram is used to depict the graph of smokers and non smokers as age increase.   
ggplot(read_data, aes(x = age, fill = smoker)) +
  geom_histogram(binwidth = 2, position = "identity", alpha = 0.75, color = "white") +
  labs(title = "Age Distribution by Smoking Status",x = "age", y = "occurence", fill = "Smoker") +
  scale_fill_manual(values = c("purple", "green")) +
  theme_minimal()
print("As age increases, the graph flattens, illustrating a decrease in the number of smokers")


#Question 7  
#What is the level of education between smokers? Do higher educated people smoke lesser? 

#Education of the people illustrated by a bar graph.
ggplot(read_data, aes(x = education, fill = smoker)) +
  geom_bar(position = "fill") +
  labs(title = "Smoking Behavior by Education Level", x = "Highest Education level", y = "Ratio") +
  scale_fill_discrete(name = "Smoker", labels = c("Non Smoker", "Smoker")) +
  scale_fill_manual( values = c("blueviolet" , "gold1"))+
  theme_minimal()
 
#Non smoker vs Smoker comparison for higher educated people  
#Analysis on individuals having a Masters degree
education_data <- subset(read_data , education == "master")

#Calculate percentage of smokers among masters graduates
percentage2 <- prop.table(table(education_data$master)) * 100

#Visualize using bar graph
ggplot(education_data, aes(x = smoker, fill = smoker))+
  geom_bar()+
  geom_text(stat = 'count', aes(label = paste0(sprintf("%.1f", percent[as.numeric(after_stat(x))]), "%")),
            position = position_stack(vjust = 0.5), size = 4, color = "black") + 
  theme_minimal()+
  geom_text( stat = 'count', aes(label = after_stat(count)), vjust = -0.5 , size = 5, color = "black")+
  scale_fill_manual( values = c("magenta" , "gold1"))+
ggtitle("Non smokers vs Smokers with a Masters Education")

#Question 8
#Is smoking common in the Spanish countries? Which gender smokes more in Spanish countries? 

#Filter hispanic people
hispanic_people <- subset(read_data, hispanic == "yes")

#Compare hispanic smokers and non smokers
ggplot(hispanic_people, aes(x = smoker, fill = smoker))+
  geom_bar()+
  theme_minimal()+
  geom_text( stat = 'count', aes(label = after_stat(count)), vjust = -0.5 , size = 5, color = "black")+
  scale_fill_manual( values = c("brown1" , "deeppink"))+
  ggtitle("Spanish nations Non Smokers v/s Smoker")
print("Smoking is not common in spanish countries.")  
 

#The gender that has more smokers in Spanish countries.
hispanic_smokers <- subset(hispanic_people, smoker == "yes")

#Calculate percentage of male and female smokers.
percent3 <- prop.table(table(hispanic_smokers$gender)) * 100

#Plot using bar graph
ggplot(hispanic_smokers, aes(x = gender, fill = gender )) +
  geom_bar()+
  theme_minimal()+
  geom_text(stat = 'count', aes(label = paste0(sprintf("%.1f", percent3[as.numeric(after_stat(x))]), "%")),
            position = position_stack(vjust = 0.5), size = 5, color = "white") +
  geom_text( stat = 'count', aes(label = after_stat(count)), vjust = -0.5 , size = 5, color = "black")+
  scale_fill_manual( values = c("brown1" , "deeppink"))+
  ggtitle("Hispanic smokers distributed by gender")
print("Although there is a higher count of female smokers, the difference is marginal.")

 
#Question 9
#Do African-American people have a large number of smokers? 

#Filter Afam individuals.
afam_people <- subset(read_data, afam == "yes")

#Visualize using bar graph.
ggplot(afam_people, aes(x = smoker, fill = smoker))+
  geom_bar()+
  geom_text( stat = 'count', aes(label = after_stat(count)), vjust =-0.55, size = 4)+
  scale_fill_manual(values = c("purple", "coral"))+
  theme_classic()+
  ggtitle("African American Non smokers vs smokers") 
print("African Americans have a less number of smokers. ")


#Question 10
#Do the African-American females smoke more than the males?
#The gender that has more smokers in African American countries.
afam_smokers <- subset(read_data, smoker == "yes")
afam_percent <- prop.table(table(afam_smokers$gender)) * 100

ggplot(afam_smokers, aes(x = gender, fill = gender )) +
  geom_bar()+
  geom_text(stat = 'count', aes(label= paste0(sprintf("%.1f", afam_percent[as.numeric(after_stat(x))]), "%")),
            position=position_stack(vjust = 0.55), size = 5, color = "white")+
  geom_text( stat = 'count', aes(label = after_stat(count)), vjust =-0.55, size = 4)+
  scale_fill_manual(values = c("purple","coral"))+
  ggtitle("African-American Female smokers vs Male Smokers")+
  theme_classic()
print("There are more female smokers in African-American countries.")

