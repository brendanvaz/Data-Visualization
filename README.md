Introduction

This analysis aims to explore various aspects of the SmokeBan dataset, including smoking prevalence, demographic trends, and the effects of workplace smoking bans. The analysis was performed using the R programming language.

Dataset

The SmokeBan dataset is a cross-sectional dataset containing observations on 10,000 indoor workers, derived from the National Health Interview Survey in 1991 and 1993. The dataset features the following variables:

rownames: Row number (integer)
smoker: Smoking status (character)
ban: Workplace smoking ban status (character)
age: Age of individuals (integer)
education: Highest education level (character)
afam: African American status (character)
Hispanic: Hispanic status (character)
gender: Gender (character)
You can access the dataset here.

Libraries Used

The following libraries are used for data wrangling and visualization:

ggplot2
dplyr
tidyverse

Data Cleaning

The dataset was checked for missing values and data type inconsistencies. No missing values were found, and no transformations were necessary.

Visualizations

Key Questions Addressed
Are there more smokers or non-smokers?
Visualized using a bar graph.
Gender distribution among smokers.
A bar graph shows slightly more female smokers than male smokers.
Impact of workplace smoking bans.
Smoking bans significantly reduced the percentage of smokers.
Age group analysis.
Most individuals are aged between 25 and 50.
Education levels and smoking habits.
Higher education correlates with lower smoking rates.

Insights

A majority of individuals in the dataset are non-smokers.
Workplace smoking bans led to a decline in smoking rates.
Higher levels of education correlate with lower smoking rates.
Female smokers slightly outnumber male smokers in certain demographics.
Age plays a significant role, with older individuals less likely to smoke.

References
SmokeBan Dataset: Vincent Arel-Bundock's Rdatasets
Documentation: Included in the project repository.
