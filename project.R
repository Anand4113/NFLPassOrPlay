#This file runs Lasso and the simple model and then compares both using AIC/BIC and then looks at model accuracy of each one

attach(nfl_cleaned)
nfl = nfl_cleaned

nfl <- subset(nfl, PlayType %in% c("Run", "Pass"))

# convert to factor AFTER subsetting
nfl$PlayType <- factor(nfl$PlayType)


table(nfl$PlayType)  # sanity check


#cols to standardize 
standardize_cols <- c(
  "ydstogo",
  "yrdline100",
  "ScoreDiff",
  "GoalToGo",
  "PlayTimeDiff",
  "TimeSecs",
  "WPA",
  "EPA",
  "Yards.Gained"  # optional as predictor; you can drop later if needed
)

#probability columns 
prob_cols <- c(
  "Win_Prob",
  "Touchdown_Prob",
  "Opp_Touchdown_Prob",
  "Away_WP_pre",
  "Home_WP_post",
  "Home_WP_pre",
  "Away_WP_post"
)

#standardize
nfl[standardize_cols] <- scale(nfl[standardize_cols])


#verify standardization worked 
means <- sapply(nfl[standardize_cols], mean, na.rm = TRUE)
sds   <- sapply(nfl[standardize_cols], sd,   na.rm = TRUE)

round(means, 4)
round(sds,   4)

range01 <- function(x) {
  (x - min(x, na.rm = TRUE)) / (max(x, na.rm = TRUE) - min(x, na.rm = TRUE))
}

nfl[prob_cols] <- lapply(nfl[prob_cols], range01)

# verify:
prob_check <- t(rbind(
  min = sapply(nfl[prob_cols], min, na.rm = TRUE),
  max = sapply(nfl[prob_cols], max, na.rm = TRUE)
))
round(prob_check, 3)

mf <- model.frame(
  PlayType ~ . - Yards.Gained,
  data = nfl,
  na.action = na.omit
)

# 2. Now build X from THIS model frame
X <- model.matrix(
  PlayType ~ . - Yards.Gained,
  data = mf
)[, -1]

# 3. And y from the same model frame
y <- mf$PlayType

library(glmnet)
set.seed(123)
cv.lasso <- cv.glmnet(
  X,
  y,
  alpha = 1,
  family = "binomial",
  nfolds = 10,
  type.measure = "deviance"
)

plot(cv.lasso)
best_lambda <- cv.lasso$lambda.min

lasso_model <- glmnet(
  X, y,
  alpha = 1,
  family = "binomial",
  lambda = best_lambda
)

coef(lasso_model)
pred_class <- predict(lasso_model, newx = X, type = "class")
mean(pred_class == y)
table(pred_class, y)


lasso_coef=coef(lasso_model)
selected_vars = rownames(lasso_coef)[lasso_coef[,1] != 0]
selected_vars = selected_vars[selected_vars != "(Intercept)"]


X_selected = X[, selected_vars, drop = FALSE]


post_lasso_glm = glm(y ~ X_selected, family = binomial())


summary(post_lasso_glm)



coef_table <- summary(post_lasso_glm)$coefficients


sig_table <- coef_table[coef_table[, "Pr(>|z|)"] <= 0.05, ]

# View significant predictors
sig_table

intervals = confint.default(post_lasso_glm)
intervals

contains_zero <- intervals[, 1] <= 0 & intervals[, 2] >= 0
contains_zero

no_zero <- rownames(intervals)[!contains_zero]
has_zero <- rownames(intervals)[contains_zero]

#confint results
no_zero
has_zero


