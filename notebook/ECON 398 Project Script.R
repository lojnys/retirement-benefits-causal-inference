library(tidyverse)
library(ggplot2)
library(haven)
library(stargazer)

# importing the dataset
df <- read_dta("../data/cen_ind_2021_pumf_v2.dta")

head(df)
glimpse(df)

# manipulating the dataset

df %>%
  filter(agegrp %in% c(16, 17),#ages from 60 to 69 years old
         !(lfact %in% c(14,88)), # removing never worked and not available
         !(immstat == 2 & ageimm == 88), # removing immigrants with no answer
         hdgree != 88, # removing not available
         marsth != 8, # removing not available
         tenur != 8, # removing not available
         !(MrkInc %in% c(88888888, 99999999)), # removing not available and not applicable
         hhsize != 8 # removing not available
  ) %>% 
  mutate(above65 = ifelse(agegrp == 17, 1, 0), # creating time variable
         NILF = ifelse(lfact >= 11, 1, 0), # creating dependent variable
         eligible = case_when(
           immstat == 1 ~ 1, # Canadians
           immstat == 2 & ageimm %in% 1:12 ~ 1, # immigrants with less than 60 years old in age of immigration
           immstat == 2 & ageimm %in% 10:13 ~ 0 # immigrants with over 60 years old in age of immigration
         )) -> df

# basemodel
did_model_base <- lm(
  NILF ~ eligible + above65 + eligible:above65,
  data = data_sample_clean
)

# model with covariates (without factors)
did_model_full <- lm(
  NILF ~ eligible + above65 
  + eligible:above65 + Gender 
  + tenur + MrkInc_10k + hhsize 
  + pr + marsth + hdgree, data = data_sample_clean
)

# model with covariates (with factors)
did_model_full_factor <- lm(
  NILF ~ eligible + above65 
  + eligible:above65 + factor(Gender) 
  + factor(tenur) + MrkInc_10k + hhsize 
  + factor(pr) + factor(marsth) + factor(hdgree),
  data = data_sample_clean
)

# refined
did_model_adjusted <- lm(
  NILF ~ eligible + above65 
  + eligible:above65 + factor(Gender) 
  + factor(tenur) + MrkInc_10k + hhsize 
  + factor(pr) + factor(marsth), data = data_sample_clean
)

# summaries
summary(did_model_base)
summary(did_model_full)
summary(did_model_full_factor)
summary(did_model_adjusted)

# stargazer table (type = latex)
stargazer(did_model_base, 
          did_model_full, 
          did_model_full_factor, 
          did_model_adjusted, 
          type = "text",
          title = "DiD Regression Results",
          dep.var.labels = "Not in Labour Force (NILF)",
          column.labels = 
            c("Baseline", "Controls", "Controls + factors", "Refined"),
          covariate.labels = 
            c("Eligible", "Age 65 or older", "Eligible x Age 65 or older"),
          keep = c("^eligible$", "^above65$", "^eligible:above65$"),
          omit.stat = c("f", "ser"),
          digits = 3,
          add.lines = list(
            c("Demographic controls", "No", "Yes", "Yes", "Yes"),
            c("Categorical controls as factors", "No", "No", "Yes", "Yes")
          ))
