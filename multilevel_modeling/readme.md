## Formulas for Different Types of Mixed Effect Models

  * `y ~ 1` is the intercept-only model
  * `y ~ x` is a typical regression model with a single fixed effect
  * `y ~ 1|a` is a model with a random effect
    + everything to the left of `|` indicates the effects we want to be random
    + everything to the right of `|` is the grouping variable across which the effects should vary
    + `(1|a)` is a random-intercept-only model
    + `(x|a)` is a model with both random intercepts and random slopes
    + `(0+x|a)` is a random-slope-only model
  * `y ~ x + (1|a)` is a mixed effects model (both fixed and random effects)
  
## Useful links

  * [Difference between nested and crossed random effects and how they are specified in lme4](https://stats.stackexchange.com/questions/228800/crossed-vs-nested-random-effects-how-do-they-differ-and-how-are-they-specified?newreg=6fcfb7321a334ac5bfa68ec236d750b5)
  * [Using lme4 to fit different two- and three-level MLMs](https://rpsychologist.com/r-guide-longitudinal-lme-lmer)
  