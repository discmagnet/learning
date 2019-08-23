## Formulas for Different Types of Mixed Effect Models

  * `y ~ 1` is the intercept-only model
  * `y ~ x` is a typical regression model with a single fixed effect
  * `y ~ 1|a` is a model with a random effect
    + everything to the left of `|` indicates the effects we want to be random
    + everything to the right of `|` is the grouping variable across which the effects should vary
    + `(1|a)` is a random-intercept-only model
    + `(1+x|a)` is a model with both random intercepts and random slopes
    + `(0+x|a)` is a random-slope-only model
  * `y ~ x + (1|a)` is a mixed effects model (both fixed and random effects)