#Assignment 1_Parametric tests
#Marina Nikon

#BACKGROUND:
#In a randomized control trial, 32 patients were divided into
#two groups: A and B. Group A received test drug whereas group B
#received placebo. The variable of interest was ‘Change in pain
#level’ measured by visual analogue scale (VAS)’ before treatment
#and after 3 days of treatment.

#QUESTIONS:
#1 Import VAS DATA and name it as pain_vas. Check for normality of the data.
#2 Is post treatment VAS score significantly less as compared
# to ‘before treatment’ VAS score for Group A? 
#3 Is post treatment VAS score significantly less as compared
# to ‘before treatment’ VAS score for Group B? 
#4 Is the average change in pain level for group ‘A’ significantly
# more than group ‘B’? 
#5 Present change in pain level for each group using box-whisker plot.

#Import VAS DATA and name it as pain_vas. 
pain_vas<-read.csv(file.choose(), header = TRUE)
str(pain_vas)
head(pain_vas)
dim(pain_vas)

#Check for normality of the data.
#QQ Plots to check the normality for VAS_before and
#VAS_after Treatment
qqnorm(pain_vas$VAS_before, main = "QQPlot (VAS_before)",
       col="coral", pch = 16)
qqline(pain_vas$VAS_before, col="blue", lwd = 2) 
#Interpretation: Distribution of 'VAS_before'
#can be assumed to be normal

#QQPlot to check the normality for VAS_after
qqnorm(pain_vas$VAS_after, main = "QQPlot (VAS_after)",
       col="darkmagenta", pch = 16)
qqline(pain_vas$VAS_after, col="blue", lwd = 2) 
#Interpretation: Distribution of 'VAS_after'shows
#some deviation from normality, but these are not extreme.
#The overall shape is still a straight line, especially in the middle


#Check for normality of VAS_before (overall) using Box-Whisker Plot #SYMMETRY
boxplot (pain_vas$VAS_before, col = "blue",
         main = "Box-Whisker Plot for VAS_before",
         ylab = "Pain Score")
#Interpretation: Distribution of 'VAS_before'
#can be assumed to be normal


# Check for normality of  VAS_after (overall) using Box-Whisker Plot
boxplot(pain_vas$VAS_after, col = "blue",
        main = "Box-Whisker Plot for VAS_after",
        ylab = "Pain Score")
#Interpretation: Distribution of 'VAS_after'
#can be assumed slightly right skewed


# Check for normality of VAS_before using Shapiro-Wilk test
shapiro.test(pain_vas$VAS_before)
#Interpretation: p-value = 0.7822, greater than 0.05, do not reject the
#null hypothesis. Distribution of 'VAS_before' 
#can be assumed to be normal


# Check for normality of VAS_after using Shapiro-Wilk test
shapiro.test(pain_vas$VAS_after)
#Interpretation: p-value = 0.01155, less than 0.05, reject the 
#null hypothesis.  Distribution of 'VAS_after' 
#can be assumed not normal


#Kolmogorov-Smirnof test to check  normality for VAS_before
#Install and use package 'nortest'
install.packages('nortest') # Install if necessary
library(nortest) # Load the library
lillie.test(pain_vas$VAS_before)
#Interpretation: p-value = 0.94, more than 0.05, do 
#not reject the null hypothesis.
#Distribution of 'VAS_before' can be assumed to be normal


#Kolmogorov-Smirnof test to check  normality for VAS_after
lillie.test(pain_vas$VAS_after)
#Interpretation: p-value = 0.07728, more than 0.05, do 
#not reject the null hypothesis.
#Distribution of 'VAS_after' can be assumed to be normal


#Is post treatment VAS score significantly less as compared
#to ‘before treatment’ VAS score for Group A?
#t.test for paired samples for Group A
t.test(pain_vas$VAS_before[pain_vas$Group == "A"], 
       pain_vas$VAS_after[pain_vas$Group == "A"], 
       alternative = "less", # test if post-treatment scores are significantly lower
       paired = TRUE)
#Interpretation: p-value = 1, can be assumed that
#post treatment VAS score is significantly 
#less as compared to ‘before treatment’ for Group A



#Is post treatment VAS score significantly less as compared 
#to ‘before treatment’ VAS score for Group B?
#t.test for paired samples for Group B
t.test(pain_vas$VAS_before[pain_vas$Group == "B"], 
       pain_vas$VAS_after[pain_vas$Group == "B"], 
       alternative = "less", #test if post-treatment scores are significantly lower
       paired = TRUE)
#Interpretation: p-value = 0.9858, can be assumed that
#post treatment VAS score is significantly 
#less as compared to ‘before treatment’ for Group B



#teacher comments
#Check normality for the change-in-pain for gr A for
#paired t test . Also alternative='greater'.

#suggests that before performing a paired t-test to see,
# you need to verify whether the data for the
#change in pain for Group A follows a normal distribution. 
#This is because the paired t-test assumes normality of the 
#differences (change in pain) - smotret document "obyasneniya"

#Is the average change in pain level for group ‘A’ 
#significantly more than group ‘B’? 
#Calculate the change in pain level
pain_vas$change_in_pain <- pain_vas$VAS_before - pain_vas$VAS_after

#Compare the average changes between "A" and "B" groups
t.test(pain_vas$change_in_pain[pain_vas$Group == "A"], 
       pain_vas$change_in_pain[pain_vas$Group == "B"], 
       alternative = "greater")
#Interpretation: p-value = 1.903e-09
#Could be assumed that the average change in pain 
#level for group ‘A’ is significantly more than group ‘B’


#Present change in pain level for each group using box-whisker plot.
boxplot(change_in_pain ~ Group, data = pain_vas,
        col = c("lightblue", "lightgreen"),
        main = "Change in Pain Level for Groups A and B",
        xlab = "Group",
        ylab = "Change in Pain Level")

#Interpretation:
#The box-whisker plot shows that the median change in pain level
#is significantly higher for Group A than for Group B, indicating
#that Group A experienced a greater reduction in pain. 
#The distribution of change in pain level for Group A is approximately
#symmetric, with a wide spread, suggesting different responses to
#the treatment within this group. The distribution for Group B is a little bit
#positively skewed, meaning small pain reductions.
#It could be assumed that Group A had a greater overall
#reduction in pain than Group B.



