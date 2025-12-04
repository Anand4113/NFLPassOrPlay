# NFLPassOrPlay (Predicting NFL Play Type)
## A Machine Learning Analysis of Run vs. Pass Decisions (2009–2016)

### Team:
### Robert Reinartz, Jacinto Vicente Castro, Anand Sabnis
(University of Houston – MATH 6357 Final Project)

### Motivation

The NFL is one of the most complex and competitive sports leagues in the world, generating over $230 billion in value across 32 teams. Every offensive play represents a split-second strategic decision shaped by game situation, coaching philosophy, and countless contextual factors.

By analyzing large-scale play-by-play data, we can uncover hidden patterns behind how and why teams choose to run or pass in different situations. Through statistical modeling and machine learning, this project aims to transform raw play data into strategic insight, deepening our understanding of in-game decision-making.

### Objectives

Our goal is to uncover the strategic logic behind NFL play-calling using data-driven methods.

#### Predict Play Type:
Build a machine learning model that classifies whether the next play will be a Run or a Pass based on game situation.

#### Identify Key Factors:
Determine which contextual features (down, distance, yard line, score differential, time remaining, etc.) most influence play selection.

#### Analyze Team Tendencies:
Compare how teams vary in their run-pass balance and situational decision-making.

#### Capture Game Dynamics:
Study how play-calling behavior shifts during high-pressure or late-game scenarios.

#### Deliver Insights:
Translate model results into clear, interpretable visualizations and summary metrics.

### Research Question: 
#### How accurately can we predict whether a play will be a run or a pass using game-context features?


### Dataset Overview

Source:
NFL Play-by-Play Data (2009–2016, v3) from Kaggle
Compiled through the nflscrapR data pipeline using official NFL GameCenter JSON logs.

Link:
https://www.kaggle.com/datasets/maxhorowitz/nflplaybyplay2009to2016

Scope: 8 NFL seasons (2009–2016 Regular Season)
~350,000 plays
102 variables (100 features + Date + GameID)

Each row represents:
A single offensive play with complete game context, situational information, and outcome details.

Key Feature Categories:
Game Context: Season, Week, Teams, Quarter, Time Remaining
Situational Factors: Down, Yards to Go, Yard Line, Score Differential, Goal-to-Go
Play Outcomes: PlayType (Run/Pass), Yards Gained, Touchdown


### References

Horowitz, M. (2018). nflplaybyplay2009to2016 [Dataset]. Kaggle.
https://www.kaggle.com/datasets/maxhorowitz/nflplaybyplay2009to2016

Yurko, R., Horowitz, M., & Ventura, S. (2018). nflscrapR Data Repository. GitHub.
https://github.com/ryurko/nflscrapR-data/tree/master/R

James, G., Witten, D., Hastie, T., & Tibshirani, R. (2021).
An Introduction to Statistical Learning (2nd ed.).
https://www.karlin.mff.cuni.cz/~pesta/NMFM334/StatLearning/Book2nd/ISLRv2_website.pdf


### R Code:
There are files included in this github that you can use to run the model at home!


#### 📄 **Modeling (`playtype_logistic_model.Rmd`)**

This R Notebook contains the full workflow used to build and evaluate logistic regression models predicting whether an NFL play is a Run or Pass. The script loads and filters the dataset, identifies numeric and categorical variables, removes constant predictors, standardizes all numeric features, and constructs a clean model matrix with one-hot encoding.

Here you go — a **short, polished README description** plus a **professional file name suggestion** for this second exploratory-analysis notebook.

#### **Exploratory Visualization (`nfl_eda_visualizations.Rmd`)**

This notebook performs the exploratory data analysis (EDA) and visualization steps for the Run/Pass prediction project. It loads the cleaned NFL play-by-play dataset, selects key numeric features, and generates a comprehensive set of plots to better understand variable distributions and their relationships to play outcomes.

The script produces:

* **Histograms** of all numeric predictors (raw and standardized)
* **Boxplots** comparing numeric variables across Run vs Pass plays
* **Scatterplots** showing each predictor vs. Yards Gained, colored by play type
* **Standardized and Min–Max normalized versions** of the dataset for comparison

All visual outputs are automatically saved into organized folders (`plots_raw/` and `plots_scaled/`), making this notebook a centralized tool for diagnostic inspection and feature understanding. These visualizations help identify patterns, detect skewness/outliers, and support later modeling decisions.


