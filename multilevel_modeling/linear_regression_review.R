# Linear Regression Review
# Chapter 1 Exercise
# High-school-and-beyond data
setwd("~/WORKING_DIRECTORIES/learning/multilevel_modeling")
library(foreign)
library(ggplot2)
library(dplyr)
library(lmtest)
hsb <- read.dta("dta_files/hsb.dta")
#-----------------------------------------------------------------------------------
# (1) Keep desired variables and desired schools
hsb <- select(hsb,schoolid,mathach,ses,minority)
hsb <- subset(hsb,schoolid %in% c(1224,1288,1296,1308,1317))
#-----------------------------------------------------------------------------------
# (2) Obtain summary statistics of variables, also by school
# Convert categorical variables to factors
hsb$schoolid <- factor(hsb$schoolid)
hsb$minority <- factor(hsb$minority)
levels(hsb$minority) <- c("white","nonwhite")
# Overall summary statistics
summary(hsb)
# Summary statistics by school
summary(subset(hsb,schoolid==1224))
summary(subset(hsb,schoolid==1288))
summary(subset(hsb,schoolid==1296))
summary(subset(hsb,schoolid==1308))
summary(subset(hsb,schoolid==1317))
#-----------------------------------------------------------------------------------
# (3) Create a histogram and boxplot of math achievement score
plot01 <- ggplot(hsb, aes(x = mathach)) +
  geom_histogram() +
  ggtitle("Histogram of Math Achievement Scores")
plot01

plot02 <- ggplot(hsb, aes(y = mathach)) +
  geom_boxplot() +
  ggtitle("Boxplot of Math Achievement Scores")
plot02
#-----------------------------------------------------------------------------------
# (4) Create a scatterplot of mathach versus ses, also by school
plot03 <- ggplot(hsb, aes(y = mathach, x = ses)) +
  geom_point() +
  ylab("Math Achievement Score") +
  xlab("Socioeconomic Status") +
  ggtitle("Math Achievement vs SES")
plot03
# By school
plot04 <- ggplot(hsb, aes(y = mathach, x = ses, color = schoolid)) +
  geom_point() +
  ylab("Math Achievement Score") +
  xlab("Socioeconomic Status") +
  ggtitle("Math Achievement vs SES") + 
  scale_color_discrete(name = "School ID")
plot04
#-----------------------------------------------------------------------------------
# (5) Treat Math Achievement as the response and SES as the explanatory
#     variable. Fit a simple linear regression model
model01 <- lm(data = hsb, formula = mathach ~ ses)
summary(model01)
# Call:
# lm(formula = mathach ~ ses, data = hsb)
# 
# Residuals:
#      Min       1Q   Median       3Q      Max 
# -15.2302  -5.0832  -0.6861   5.1117  14.6851 
# 
# Coefficients:
#             Estimate Std. Error t value Pr(>|t|)    
# (Intercept)  11.4565     0.4734  24.200  < 2e-16 ***
# ses           3.3070     0.6602   5.009 1.27e-06 ***
# ---
# Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
# 
# Residual standard error: 6.471 on 186 degrees of freedom
# Multiple R-squared:  0.1189,	Adjusted R-squared:  0.1141 
# F-statistic: 25.09 on 1 and 186 DF,  p-value: 1.267e-06
#-----------------------------------------------------------------------------------
# (6) Save the fitted values of the linear regression
hsb$yhat <- model01$fitted.values
# By school
model01a <- lm(data = subset(hsb,schoolid == 1224), formula = mathach ~ ses)
model01b <- lm(data = subset(hsb,schoolid == 1288), formula = mathach ~ ses)
model01c <- lm(data = subset(hsb,schoolid == 1296), formula = mathach ~ ses)
model01d <- lm(data = subset(hsb,schoolid == 1308), formula = mathach ~ ses)
model01e <- lm(data = subset(hsb,schoolid == 1317), formula = mathach ~ ses)
fit1 <- model01a$fitted.values
fit2 <- model01b$fitted.values
fit3 <- model01c$fitted.values
fit4 <- model01d$fitted.values
fit5 <- model01e$fitted.values
hsb$yhat1 <- c(fit1,fit2,fit3,fit4,fit5)
#-----------------------------------------------------------------------------------
# (7) Fit the same scatterplots, but now with the regression line
plot03 + geom_line(data = hsb, aes(y = yhat, x = ses))
# By school
plot04 + geom_line(data = hsb, aes(y = yhat1, x = ses, color = schoolid))
#-----------------------------------------------------------------------------------
# (8) Extend the regression model by including dummy variabels for the schools
#     Note that school 1224 will be the reference group
#
#     Without factor variables (create dummies)
hsb$S1288 <- hsb$schoolid==1288
hsb$S1296 <- hsb$schoolid==1296
hsb$S1308 <- hsb$schoolid==1308
hsb$S1317 <- hsb$schoolid==1317
model02 <- lm(data = hsb, formula = mathach ~ ses + S1288 + S1296 + S1308 + S1317)
summary(model02)
# Call:
# lm(formula = mathach ~ ses + S1288 + S1296 + S1308 + S1317, data = hsb)
# 
# Residuals:
#      Min       1Q   Median       3Q      Max 
# -13.9759  -4.1968  -0.7519   5.2209  16.3813 
# 
# Coefficients:
#             Estimate Std. Error t value Pr(>|t|)    
# (Intercept)  10.4925     0.9676  10.844  < 2e-16 ***
# ses           1.7890     0.7594   2.356  0.01955 *  
# S1288TRUE     2.8007     1.6004   1.750  0.08180 .  
# S1296TRUE    -2.0954     1.2797  -1.637  0.10328    
# S1308TRUE     4.8184     1.8183   2.650  0.00876 ** 
# S1317TRUE     2.0674     1.4101   1.466  0.14433    
# ---
# Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
# 
# Residual standard error: 6.236 on 182 degrees of freedom
# Multiple R-squared:  0.1992,	Adjusted R-squared:  0.1772 
# F-statistic: 9.054 on 5 and 182 DF,  p-value: 1.051e-07
#
# With factor variables (easier option)
model03 <- lm(data = hsb, formula = mathach ~ ses + factor(schoolid))
summary(model03)
# Call:
# lm(formula = mathach ~ ses + factor(schoolid), data = hsb)
# 
# Residuals:
#      Min       1Q   Median       3Q      Max 
# -13.9759  -4.1968  -0.7519   5.2209  16.3813 
# 
# Coefficients:
#             Estimate Std. Error t value Pr(>|t|)    
# (Intercept)           10.4925     0.9676  10.844  < 2e-16 ***
# ses                    1.7890     0.7594   2.356  0.01955 *  
# factor(schoolid)1288   2.8007     1.6004   1.750  0.08180 .  
# factor(schoolid)1296  -2.0954     1.2797  -1.637  0.10328    
# factor(schoolid)1308   4.8184     1.8183   2.650  0.00876 ** 
# factor(schoolid)1317   2.0674     1.4101   1.466  0.14433    
# ---
# Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
# 
# Residual standard error: 6.236 on 182 degrees of freedom
# Multiple R-squared:  0.1992,	Adjusted R-squared:  0.1772 
# F-statistic: 9.054 on 5 and 182 DF,  p-value: 1.051e-07
#
# Test the null hypothesis that all four dummy variables are zero
# Using a Likelihood Ratio Test (lmtest package)
lrtest(model01,model03)
# Likelihood ratio test
# 
# Model 1: mathach ~ ses
# Model 2: mathach ~ ses + factor(schoolid)
#   #Df  LogLik Df  Chisq Pr(>Chisq)   
# 1   3 -616.81                        
# 2   7 -607.82  4 17.974   0.001249 **
#   ---
# Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#-----------------------------------------------------------------------------------
# (9) Add interactions between the school dummies and SES
model04 <- lm(data = hsb, formula = mathach ~ ses*S1288 + ses*S1296 + 
                ses*S1308 + ses*S1317)
summary(model04)
# Call:
# lm(formula = mathach ~ ses * S1288 + ses * S1296 + ses * S1308 + 
#      ses * S1317, data = hsb)
# 
# Residuals:
#      Min       1Q   Median       3Q      Max 
# -15.6483  -4.4246  -0.8679   4.6355  16.0444 
# 
# Coefficients:
#             Estimate Std. Error t value Pr(>|t|)    
# (Intercept)    10.8051     1.1181   9.664   <2e-16 ***
# ses             2.5086     1.4761   1.700   0.0910 .  
# S1288TRUE       2.3098     1.6976   1.361   0.1753    
# S1296TRUE      -2.7114     1.5603  -1.738   0.0840 .  
# S1308TRUE       5.3838     2.3949   2.248   0.0258 *  
# S1317TRUE       1.9326     1.5477   1.249   0.2134    
# ses:S1288TRUE   0.7469     2.4181   0.309   0.7578    
# ses:S1296TRUE  -1.4326     2.0452  -0.700   0.4845    
# ses:S1308TRUE  -2.3826     3.3458  -0.712   0.4773    
# ses:S1317TRUE  -1.2347     2.2116  -0.558   0.5774    
# ---
# Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
# 
# Residual standard error: 6.28 on 178 degrees of freedom
# Multiple R-squared:  0.2058,	Adjusted R-squared:  0.1657 
# F-statistic: 5.125 on 9 and 178 DF,  p-value: 3.569e-06