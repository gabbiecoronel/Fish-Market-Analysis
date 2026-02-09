# Fish-Market-Analysis
By: Gabrielle Coronel, Kyle Zemel, Uyen Tran

## Purpose
The purpose of this study is to investigate how physical characteristics of fish relate to their weight. By building a multiple linear regression model, we aim to quanitfy the relationship between fish measurements (such as lengths, height, and width) and weight, which can provide insights into fish growth patterns and morphometric relationships, informing fisheries and conservation efforts by monitoring the health and size distribution of wild or managed populations.

## Objectives
### Background
Accurate estimation of fish weight is important for fisheries management and ecological research, as it informs decisions related to feeding, harvesting, population assessment, and market value.

### Research Question
How can we predict the weight of a fish based on its physical measurements?

## Dataset
- Source: Fish Market dataset from Kaggle
- Total Observations: 159
- Variables: 7 total (1 categorical, 6 continuous)
- Variable Names: Weight, Length1, Length2, Length3, Height, Width, Species
- No missing values

## Variables in Our Full Model
### Y: Weight
  - Weight of the fish measured in grams.
### Length 1
  - Vertical length of the fish measured in cm.
### Length 2
  - Diagonal length of the fish measured in cm.
### Length 3
  - Cross length of the fish measured in cm.
### Height
  - Height of the fish measured in cm.
### Width
  - Width of the fish measured in cm.

## Removed Data
The Species column was removed because the purpose of this study is to develop a predictive model soley based on physical measurements that can estimate fish weight across species.

## Summary & Limitations
Through this analysis, we learned that multiple linear regression is not ideal for this dataset since the morphometric variables are inherently strongly correlated with each other, as they all represent different dimensions of fish size. This biological relationship produced severe multicollinearity with each other, limiting our ability to interpret the individual effect of each predictor.

## Further Studies
- Exploring polynomial regression to better capture potential nonlinear relationships between morphometric measurements and fish weight.
- Investigating the role of species as a predictor in modeling fish weight, either by developing species-specific models or including species as a categorical variable.
- Additional variables, such as age, sex, and reproductive stage, could also be included to capture variation in weight that cannot be explained by morphology alone.
