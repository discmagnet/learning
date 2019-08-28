## Formulas for Different Types of Mixed Effect Models

Using the `lmer()` function in the **lme4** package
  * `y ~ 1` is the intercept-only model
  * `y ~ x` is a typical regression model with a single fixed effect
  * `y ~ (1 | a)` is a model with a random effect
    + everything to the left of `|` indicates the effects we want to be random
    + everything to the right of `|` is the grouping variable across which the effects should vary
    + `(1 | a)` random intercept only
    + `(0+x | a)` random slope only
    + `(x | a)` correlated random intercept and slope
    + `(x || a)` or `(1 | a) + (0+x | a)` uncorrelated random intercept and slope
    + `(1 | x1/x2)` or `(1 | x1) + (1 | x1:x2)` intercept varying among x1 and x2 within x1 (*nested* design)
    + `(1 | x1) + (1 | x2)` intercept varying among x1 and x2 (*crossed* design)
  * `y ~ x + (1 | a)` is a mixed effects model (both fixed and random effects)
  
## Useful links

  * [Difference between nested and crossed random effects and how they are specified in lme4](https://stats.stackexchange.com/questions/228800/crossed-vs-nested-random-effects-how-do-they-differ-and-how-are-they-specified?newreg=6fcfb7321a334ac5bfa68ec236d750b5)
  * [Using lme4 to fit different two- and three-level MLMs](https://rpsychologist.com/r-guide-longitudinal-lme-lmer)
  