# Random Coefficient Models
# Chapter 4 Exercise
# Well-being in the US army data
setwd("~/WORKING_DIRECTORIES/learning/multilevel_modeling")
library(foreign)
library(ggplot2)
library(dplyr)
library(lme4)
army <- read.dta("dta_files/army.dta")
army$grp <- factor(army$grp)
#-----------------------------------------------------------------------------------
# (1) Fit a random-intercept model for wbeing with fixed coefficients for hrs,
#     cohes, and lead, and a random intercept for grp. Use ML estimation.
model01 <- lmer(data = army, wbeing ~ hrs + cohes + lead + (1|grp), REML = FALSE)
summary(model01)
#     AIC      BIC   logLik deviance df.resid 
# 17808.6  17850.0  -8898.3  17796.6     7376 
# 
# Scaled residuals: 
#     Min      1Q  Median      3Q     Max 
# -3.8698 -0.6566  0.0336  0.6928  3.5772 
# 
# Random effects:
#  Groups   Name        Variance Std.Dev.
#  grp      (Intercept) 0.01973  0.1404  
#  Residual             0.64266  0.8017  
# Number of obs: 7382, groups:  grp, 99
# 
# Fixed effects:
#              Estimate Std. Error t value
# (Intercept)  1.530603   0.071682  21.353
# hrs         -0.029643   0.004376  -6.773
# cohes        0.077507   0.012042   6.436
# lead         0.464684   0.013960  33.287
# 
# Correlation of Fixed Effects:
#       (Intr) hrs    cohes 
# hrs   -0.774              
# cohes -0.334  0.067       
# lead  -0.413  0.083 -0.403
confint(model01)
#                   2.5 %      97.5 %
# .sig01       0.11409502  0.17192212
# .sigma       0.78882008  0.81484713
# (Intercept)  1.38843685  1.67241457
# hrs         -0.03830482 -0.02097579
# cohes        0.05388919  0.10112555
# lead         0.43727304  0.49210637
#-----------------------------------------------------------------------------------
# (2) Form the cluster means of the three covariates from step (1), and add them as
#     further covariates to the random-intercept model.
clust_means <- aggregate(army[,2:4], list(grp = army$grp), mean)
army2 <- merge(army, clust_means, by = "grp")
model02 <- lmer(data = army2,
                wbeing ~ hrs.x + hrs.y + cohes.x + cohes.y + 
                  lead.x + lead.y + (1|grp),
                REML = FALSE)
summary(model02)
#      AIC      BIC   logLik deviance df.resid 
#  17776.2  17838.4  -8879.1  17758.2     7373 
# 
# Scaled residuals: 
#     Min      1Q  Median      3Q     Max 
# -3.9281 -0.6571  0.0411  0.6964  3.6157 
# 
# Random effects:
#  Groups   Name        Variance Std.Dev.
#  grp      (Intercept) 0.009362 0.09676 
#  Residual             0.642994 0.80187 
# Number of obs: 7382, groups:  grp, 99
# 
# Fixed effects:
#              Estimate Std. Error t value
# (Intercept)  3.535100   0.297295  11.891
# hrs.x       -0.025597   0.004476  -5.719
# hrs.y       -0.115866   0.018428  -6.287
# cohes.x      0.080221   0.012134   6.612
# cohes.y     -0.037489   0.087386  -0.429
# lead.x       0.470932   0.014275  32.990
# lead.y      -0.224369   0.067332  -3.332
# 
# Correlation of Fixed Effects:
#         (Intr) hrs.x  hrs.y  cohs.x cohs.y lead.x
# hrs.x    0.000                                   
# hrs.y   -0.723 -0.243                            
# cohes.x  0.000  0.075 -0.018                     
# cohes.y -0.311 -0.010 -0.213 -0.139              
# lead.x   0.000  0.069 -0.017 -0.398  0.055       
# lead.y  -0.320 -0.015  0.393  0.084 -0.654 -0.212
confint(model02)
#                   2.5 %      97.5 %
# .sig01       0.07022178  0.12618576
# .sigma       0.78902244  0.81506809
# (Intercept)  2.93941904  4.12050895
# hrs.x       -0.03437116 -0.01682284
# hrs.y       -0.15205177 -0.07880586
# cohes.x      0.05643673  0.10400577
# cohes.y     -0.21060619  0.13494456
# lead.x       0.44294922  0.49891397
# lead.y      -0.35712005 -0.09091714
#-----------------------------------------------------------------------------------
# (3) Refit the model from step (2) after removing the cluster means that are not
#     significant at the 5% level (remove just cohes.y). Interpret the remaining
#     coefficients and obtain the estimated intraclass correlation.
model03 <- lmer(data = army2,
                wbeing ~ hrs.x + hrs.y + cohes.x + lead.x + lead.y + (1|grp),
                REML = FALSE)
summary(model03)
# Fixed effects:
#              Estimate Std. Error t value
# (Intercept)  3.495340   0.282690  12.365
# hrs.x       -0.025617   0.004476  -5.723
# hrs.y       -0.117543   0.018012  -6.526
# cohes.x      0.079499   0.012016   6.616
# lead.x       0.471270   0.014253  33.064
# lead.y      -0.243267   0.050933  -4.776
#
# Comparing soldiers within the same army company, each extra hour of work per day
# is associated with an estimated mean decrease of 0.03 points in well-being,
# controlling for perceived horizontal and vertical cohesion.
#
# Comparing soldiers within the same army company, each unit increase in the
# horizontal cohesion score is associated with an estimated mean increase of 0.08
# points in well-being, controlling for number of hours worked and percieved
# vertical cohesion.
#
# Comparing soldiers within the same army company, each unit increase in the
# vertical cohesion score is associated with an estimated mean increase of 0.47
# points in well-being, controlling for number of hours worked and perceived
# horizontal cohesion.
#
# The contextual effects of hours worked is estimated as -0.12, meaning that, after
# controlling for the soldier's own number of hours worked per day ( and the other
# covariates in the model), each unit increase in the mean number of hours worked
# by soldiers in the company reduces the soldier's well-being by an estimated 0.12
# points.
#
# The contextual effects of vertical cohesion is estimated as -0.24. After
# controlling for the soldier's own perceived vertical cohesion (and the other
# covariates), each unit increase in average perceived vertical cohesion in the
# soldier's company is associated with an estimated 0.24 points decrease in well-
# being.
#
# Random effects:
#  Groups   Name        Variance Std.Dev.
#  grp      (Intercept) 0.009378 0.09684 
#  Residual             0.643003 0.80187 
#
# ICC = 0.009378 / (0.009378 + 0.643003) = 0.0144
#-----------------------------------------------------------------------------------
# (4) Add a random slope for lead to the model in step (3), and compare this model
#     with the model from step (3) using a LRT.
model04 <- lmer(data = army2,
                wbeing ~ hrs.x + hrs.y + cohes.x + lead.x + lead.y + (lead.x|grp),
                REML = FALSE)
summary(model04)
#      AIC      BIC   logLik deviance df.resid 
#  17754.8  17823.9  -8867.4  17734.8     7372 
# 
# Scaled residuals: 
#     Min      1Q  Median      3Q     Max 
# -3.8328 -0.6573  0.0359  0.6982  3.8949 
# 
# Random effects:
#  Groups   Name        Variance Std.Dev. Corr 
#  grp      (Intercept) 0.12143  0.34847       
#           lead.x      0.00975  0.09874  -0.97
#  Residual             0.63760  0.79850       
# Number of obs: 7382, groups:  grp, 99
# 
# Fixed effects:
#              Estimate Std. Error t value
# (Intercept)  3.304785   0.272224  12.140
# hrs.x       -0.025802   0.004469  -5.773
# hrs.y       -0.106432   0.017238  -6.174
# cohes.x      0.078879   0.012013   6.566
# lead.x       0.470941   0.017842  26.395
# lead.y      -0.219807   0.049569  -4.434
# 
# Correlation of Fixed Effects:
#         (Intr) hrs.x  hrs.y  cohs.x lead.x
# hrs.x    0.002                            
# hrs.y   -0.835 -0.266                     
# cohes.x -0.044  0.074 -0.050              
# lead.x  -0.064  0.052  0.006 -0.316       
# lead.y  -0.715 -0.032  0.326 -0.016 -0.207
anova(model03, model04)
# Models:
# model03: wbeing ~ hrs.x + hrs.y + cohes.x + lead.x + lead.y + (1 | grp)
# model04: wbeing ~ hrs.x + hrs.y + cohes.x + lead.x + lead.y + (lead.x | grp)
#         Df   AIC   BIC  logLik deviance  Chisq Chi Df Pr(>Chisq)    
# model03  8 17774 17830 -8879.2    17758                             
# model04 10 17755 17824 -8867.4    17735 23.579      2  7.583e-06 ***
# ---
# Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#
# Since the p-value of the LRT is so small, we should keep the random slope for lead
#-----------------------------------------------------------------------------------
# (5) Add a random slope for cohes to the model chosen in step (4), and compare this
#     model with the model from step (3) using a LRT. Retain the preferred model.
model05 <- lmer(data = army2,
                wbeing ~ hrs.x + hrs.y + cohes.x + lead.x + lead.y + 
                  (lead.x+cohes.x|grp),
                REML = F)
summary(model05)
# Singular fit/unable to replicate results from Stata
#-----------------------------------------------------------------------------------
# (6) Perform residual diagnostics for the level-1 errors, random intercept, and
#     random slopes. Do the model assumptions appear to be satisfied?
