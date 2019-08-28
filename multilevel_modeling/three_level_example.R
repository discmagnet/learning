# Multilevel Modeling Example with 3 Levels
# Chapter 8 Exercise
# Math-achievement data
setwd("~/WORKING_DIRECTORIES/learning/multilevel_modeling")
library(foreign)
library(ggplot2)
library(dplyr)
library(lme4)
achieve <- read.dta("dta_files/achievement.dta")
achieve$retained <- factor(achieve$retained)
achieve$female <- factor(achieve$female)
achieve$black <- factor(achieve$black)
achieve$hispanic <- factor(achieve$hispanic)
achieve$child <- factor(achieve$child)
achieve$school <- factor(achieve$school)

model01 <- lmer(data = achieve,
                REML = FALSE,
                math ~ lowinc*year + black*year + hispanic*year +
                  (year | school/child))
summary(model01)