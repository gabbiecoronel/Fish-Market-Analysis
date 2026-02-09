# Project 2
# By: Gabrielle Coronel, Kyle Zemel, Uyen Tran

library(readr)
library(corrplot)
library(car)

# Adding the fish dataset
fish <- read_csv("/Users/gabbiecoronel/Downloads/Fish.csv")
attach(fish)
summary(fish)

# Cleaning the fish dataset, removing species
cleanedFish <- fish[,-1]
summary(cleanedFish)

# Number of observations
numRow <- nrow(cleanedFish)
print(numRow)

# Multiple linear regression model for the fish market
model <- lm(Weight ~ Length1 + Length2 + Length3 + Height + Width, data = cleanedFish)
summary(model)

# Summary of fish Weight, Vertical Length in cm (Length1), Diagonal Length2 in cm, Cross Length (Length3) in cm, and Height
summary(Weight)
summary(Length1)
summary(Length2)
summary(Length3)
summary(Height)
summary(Width)

# Histograms of our non-categorical variables: Weight, Vertical Length in cm (Length1), Diagonal Length2 in cm, Cross Length (Length3) in cm, and Height
hist(Weight, main = "Histogram of Weight in grams")
hist(Length1, main = "Histogram of Vertical Length in cm")
hist(Length2, main = "Histogram of Diagonal Length in cm")
hist(Length3, main = "Histogram of Cross Length in cm")
hist(Height, main = "Histogram of Height in cm")
hist(Width, main = "Histogram of Width in cm")

# Boxplots of our non-categorical variables: Weight, Vertical Length in cm (Length1), Diagonal Length2 in cm, Cross Length (Length3) in cm, and Height
boxplot(Weight, horizontal = T, xlab = "Weight", main = "Boxplot of Weight in grams")
boxplot(Length1, horizontal = T, xlab = "Vertical Length in cm (Length 1)", main = "Boxplot of Vertical Length in cm (Length 1)")
boxplot(Length2, horizontal = T, xlab = "Diagonal Length in cm (Length 2)", main = "Boxplot of Diagonal Length in cm (Length 2)")
boxplot(Length3, horizontal = T, xlab = "Cross Length in cm (Length 3)", main = "Boxplot of Cross Length in cm (Length 3)")
boxplot(Height, horizontal = T, xlab = "Height", main = "Boxplot of Height")
boxplot(Width, horizontal = T, xlab = "Height", main = "Boxplot of Width")

# Scatterplots of our non-categorical variables: Weight, Vertical Length in cm (Length1), Diagonal Length2 in cm, Cross Length (Length3) in cm, and Height

plot(
  x = Length1,
  y = Weight,
  xlab="Vertical Length in cm (Length1)", 
  ylab="Weight",
  main = "Scatterplot of Vertical Length vs. Weight"
)

plot(
  x = Length2,
  y = Weight,
  xlab="Diagonal Length in cm (Length2)", 
  ylab="Weight",
  main = "Scatterplot of Diagonal Length vs. Weight"
)

plot(
  x = Length3,
  y = Weight,
  xlab="Cross Length in cm (Length3)", 
  ylab="Weight",
  main = "Scatterplot of Cross Length vs. Weight"
)

plot(
  x = Height,
  y = Weight,
  xlab="Height", 
  ylab="Weight",
  main = "Scatterplot of Height vs. Weight"
)

plot(
  x = Width,
  y = Weight,
  xlab="Width", 
  ylab="Weight",
  main = "Scatterplot of Width vs. Weight"
)

# Residuals of the multiple linear regression model
par(mfrow = c(2, 2))
plot(model)
par(mfrow = c(1,  1))
plot(model)

# Correlation Matrix of the multiple linear regression model
numeric_data <- cleanedFish[, sapply(cleanedFish, is.numeric)]
correlation_matrix <- cor(numeric_data)
round(correlation_matrix, 3)

fish_filtered <- subset(fish, Weight > 0)

# Transformed log full model
full_model <- glm(log(Weight) ~ log(Length1) + log(Length2) + log(Length3) + log(Height) + log(Width), data = fish_filtered)
summary(full_model)

# Correlation Matrix of the full log transformed model
all_log_vars <- data.frame(
  log_Weight = log(fish_filtered$Weight),
  log_Length1 = log(fish_filtered$Length1),
  log_Length2 = log(fish_filtered$Length2),
  log_Length3 = log(fish_filtered$Length3),
  log_Height = log(fish_filtered$Height),
  log_Width = log(fish_filtered$Width)
)
full_log_corr_matrix <- cor(all_log_vars)
round(full_log_corr_matrix, 3)

# Backwards Stepwise Selection Model for transformed log model
print("--- Starting Backward Stepwise Selection ---")
step_backward_model <- step(full_model, direction = "backward")
print("--- Final Model Selected by Backward Elimination ---")
summary(step_backward_model)

# New transformed log model based on the results of the Backwards Stepwise Selection Model
new_model <- glm(log(Weight) ~ log(Length2) + log(Height) + log(Width), data = fish_filtered)

# Residuals of the New Model
par(mfrow = c(1, 1))
plot(new_model)

# Getting the summary of the transformed log new model
new_model_log <- lm(log(Weight) ~ log(Length1) + log(Length2) + log(Length3) + log(Height) + log(Width), data = fish_filtered)
summary(new_model_log)

# Transformed log of the predictors based on the new model
predictors_log <- data.frame(
  log_Weight = log(fish_filtered$Weight),
  log_Length2 = log(fish_filtered$Length2),
  log_Height = log(fish_filtered$Height),
  log_Width = log(fish_filtered$Width)
)

# Transformed new model log correlation matrix
new_correlation_matrix <- cor(predictors_log)
round(new_correlation_matrix, 3)

# Checking for multicollinearity using the VIF values of the mutliple linear regression model
vif_values <- vif(model)
print(vif_values)

# Checking for multicollinearity using the VIF values of the new transformed log model
vif_log <- vif(new_model_log)
print(vif_log)

vif_values_new <- vif(new_model)
print(vif_values_new)

# Based on the VIF values of the new model, creating a new model with only Length2 and Height as the predictors
model_length2_height <- lm(log(Weight) ~ log(Length2) + log(Height), data = fish_filtered)

# Getting the summary and VIF values of the model with only Length2 and Height as the predictors
summary(model_length2_height)
vif_new <- vif(model_length2_height)
print(vif_new)

# Residuals of the model with only Length2 and Height
par(mfrow = c(2, 2))
plot(model_length2_height)
par(mfrow = c(1, 1))
plot(model_length2_height)

# simple linear regression for the log of Width
model_width <- lm(log(Weight) ~ log(Width), data = fish_filtered)

# Getting the summary and the residuals for the model with Width
summary(model_width)
par(mfrow = c(2, 2))
plot(model_width)
par(mfrow = c(1, 1))
plot(model_width)

# Univariate Models
# Length 1
lm_length1 <- lm(formula = Weight~Length1, data = cleanedFish)
summary(lm_length1)

# Length 2
lm_length2 <- lm(formula = Weight~Length2, data = cleanedFish)
summary(lm_length2)

# Length 3
lm_length3 <- lm(formula = Weight~Length3, data = cleanedFish)
summary(lm_length3)

# Width
lm_Width <- lm(formula = Weight~Width, data = cleanedFish)
summary(lm_Width)

# Height
lm_Height <- lm(formula = Weight~Height, data = cleanedFish)
summary(lm_Height)

# Testing for Confounding
# Reduced Models
glm_length1 <- glm(formula = Weight ~ Length1, data = cleanedFish)
summary(glm_length1)

glm_length2 <- glm(formula = Weight ~ Length2, data = cleanedFish)
summary(glm_length2)

glm_length3 <- glm(formula = Weight ~ Length3, data = cleanedFish)
summary(glm_length3)

glm_height <- glm(formula = Weight ~ Height, data = cleanedFish)
summary(glm_height)

glm_width <- glm(formula = Weight ~ Width, data = cleanedFish)
summary(glm_width)

# Full Model
glm_full <- glm(formula = Weight ~ Length1 + Length2 + Length3 + Height + Width, data = cleanedFish)
summary(glm_full)