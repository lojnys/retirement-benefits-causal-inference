# Do Old Age Security (OAS) Payments Increase Retirement Among Canadians?

**ECON 398: Introduction to Causal Methods** - April 2026

**Authors**: Andrew Clark, Yushin Nam

## Overview

This project examines whether eligibility for Canada's Old Age Security (OAS) pension causally affects labour force participation rates. Using a difference-in-differences (DiD) framework applied to the 2021 Canadian Census PUMF, we compare labour force participation between OAS-eligible and OAS-ineligible groups across the age-65 eligibility threshold. 

## Repository Structure

```
retirement_benefit_causal_inference\
|   .gitignore
|   2021 Census Individuals PUMF User Guide_v2_sample.pdf
|   project_outline.pdf
|   README.md
|
+---data
|       cen_ind_2021_pumf_v2_sample.dta
|
+---notebook
|       .RData
|       .Rhistory
|       01_data_analysis.Rmd
|       ECON 398 Project Script.R
|
+---report
|   ECON_398_Report.pdf
```

## Data

This project uses the **2021 Canadian Census Public Use Microdata File (PUMF) - Individuals File**:
> Statistics Canada. (2023). 2021 Census Public Use Microdata File (PUMF)
> Individuals File. Abacus Data Network.
> https://hdl.handle.net/11272.1/AB2/1WTDOP

## Methods

- **Difference-in-differences (DiD)** comparing ages 60-64 vs. 65 - 69, across OAS-eligible (non-immigrants + early immigrants) and OAS-ineligible (recent immigrants) groups
- Outcome: binary **NILF (Not in Labour Force)** indicator
- Covariates: gender, marital status, province, market income, household size, housing tenure, education

## Key Finding

Across all specifications, OAS elgibility is associated with a roughly 12.5 percentage point *decrease* in the probability of being out of the labour force - contrary to the simple labour-leisure prediction. See the report for full discussion of limitations and the case for an RDD extension.

## Requirements
- R ()
- Packages: 

## Acknowledgements

Course project for ECON 398 at the University of British Columbia. Data provided by Statistics Canada.