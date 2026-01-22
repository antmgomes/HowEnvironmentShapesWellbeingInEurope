# Environmental Conditions And Wellbeing In Europe

## Introduction:
This project explores how environmental and demographic factors relate to well-being outcomes across European countries between 2015 and 2023. The analysis investigates whether greener environments, population characteristics, and climate conditions are linked to happiness, health, longevity, and suicide rates.
The goal of this project is not to establish causality, but to identify consistent associations and patterns that help explain cross-country differences in well-being.


## Hypotheses and Key Findings:
### **1: Is there an association between NDVI and population density across countries?**
H₀: There is no association between NDVI and population density.

H₁: There is an association between NDVI and population density.

<img width="1242" height="715" alt="imagem" src="https://github.com/user-attachments/assets/bd4c25e2-df9c-49ae-b645-7d14aca09d9a" />


The analysis reveals a positive association between NDVI and population density. Countries with higher NDVI tend to have higher population densities on average, although the relationship is weak and there is substantial variability.

### **2: Is there an association between NDVI and average mean temperature across countries?**
H₀: There is no association between NDVI and average mean temperature.

H₁: There is an association between NDVI and average mean temperature.

<img width="1242" height="715" alt="imagem" src="https://github.com/user-attachments/assets/12c0c655-a747-40ce-b263-f6cd1de6787d" />


The upward-sloping trend line indicates a positive association between NDVI and average annual mean temperature. Countries with higher NDVI tend to have higher mean temperatures on average. However, the spread of points suggests that this relationship is moderate and influenced by other factors.

### **3: Is there an association between NDVI and self-reported population health across countries?**
H₀: There is no association between NDVI and self-reported population health.

H₁: There is an association between NDVI and self-reported population health.

<img width="1242" height="715" alt="imagem" src="https://github.com/user-attachments/assets/1a8dd25e-56bd-4934-b903-06f6cb4a7c31" />


The analysis shows a negative association between NDVI and self-reported population health. On average, countries with higher NDVI have slightly lower population health, but the relationship is moderate.

### **4: Is there an association between NDVI and life expectancy at birth across countries?**
H₀: There is no association between NDVI and life expectancy at birth.

H₁: There is an association between NDVI and life expectancy at birth.

<img width="1242" height="715" alt="imagem" src="https://github.com/user-attachments/assets/da772567-aeba-4796-a83f-9b2530043836" />


The analysis shows no meaningful association between NDVI and life expectancy at birth.

### **5: Is there a relationship between happiness index and suicide rates across countries?**
H₀: There is no relationship between happiness index and suicide rates.

H₁: There is a relationship between the happiness index and suicide rates.

<img width="1242" height="716" alt="imagem" src="https://github.com/user-attachments/assets/1d0e0e6d-bcbc-4383-ae67-837abdc6aa65" />


The analysis shows a negative association between the happiness index and suicide rates. On average, countries with a higher happiness index have slightly lower suicide rates. However, the spread of points suggests that this relationship is weak and influenced by other factors.

### **6: Is there a relationship between the happiness index and average mean temperatures?**
H₀: There is no relationship between happiness index and average mean temperatures.

H₁: There is a relationship between the happiness index and average mean temperatures.

<img width="1242" height="716" alt="imagem" src="https://github.com/user-attachments/assets/02f3c5f9-24c8-4a35-bad1-659cdfc6c39b" />


The analysis reveals a negative association between the happiness index and average annual temperatures. Countries with a higher happiness index tend to have lower average annual temperatures on average, although the relationship is weak with substantial variability.

## Key Variables
* **happiness_index:** Average National Happiness Score
* **life_expectancy:** Average Life Expectancy at Birth
* **good_health_percentage:** Percentage of People With Good or Very Good Perceived Health
* **ndvi:** Normalized Difference Vegetation Index
* **population_density:** Estimated Total Population
* **suicide_rate:** Deaths by Suicide Per 100,000 People
* **avg_mean_temp:** Average Annual Mean Temperature

## Data:
**Geographic Scope:** European Countries

**Time Period:** 2015 – 2023

**Unit of Analysis:** Country – Year

## Tools Used:
* MySQL
* Tableau

## Conclusion:
The findings show that greener environments, population density, temperature, and other factors are linked to well-being, but these relationships are generally weak to moderate and influenced by other variables. This suggests that environmental conditions contribute to well-being, but they are only one part of a complex set of factors.

## Links:
[Tableau Dashboard](https://public.tableau.com/app/profile/antmgomes/viz/EnvironmentalConditionsAndWellbeingInEurope/Dashboard2?publish=yes)
