# Growth Curve Models
setwd("~/WORKING_DIRECTORIES/learning/multilevel_modeling")
library(foreign)
library(ggplot2)
library(dplyr)
library(tidyr)
library(lme4)
asian <- read.dta("dta_files/asian.dta") # in long format
reading <- read.dta("dta_files/reading.dta") # in wide format

# As good practice, convert the categorical variables to factors
asian$id <- factor(asian$id)
asian$occ <- factor(asian$occ)
asian$gender <- factor(asian$gender)
levels(asian$gender) <- c("Boy","Girl") # define 1 as Boy
                                        # define 2 as Girl

# Plotting the observed growth trajectories
plot01 <- ggplot(data = asian,
                 aes(x = age, y = weight, group = id)) +
  geom_line() + 
  xlab("Age (years)") +
  ylab("Weight (kg)") +
  facet_grid(. ~ gender)
plot01 # Notice the growth curves are non-linear

# Fit a non-linear growth curve to the data
asian$age2 <- asian$age^2

