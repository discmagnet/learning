# Joint Modeling of Longitudinal and Time-To-Event Data

The best way I can describe this is that joint modeling gets the best of both worlds. We're ultimately doing survival analysis, but we're also taking into account the correlation among the repeated measures. Suppose we are interested in using biomarkers to describe the progression of a disease. With the use of joint modeling, we are now able to handle rates of progression that are different between two patients as well as rates of progression that change over time for the same patient.

A typical time-to-event analysis that would utilize biomarker data would be a Cox regression model that includes the biomarker as a time-varying covariate. This framework means you're making the following assumptions:
* there is no measurement error
* the time-varying covariate follows a step-function path
* the covariate is exogeneous (not related to failure status)

These assumptions don't particularly hold true for many biomarkers. This is where joint modeling comes in and typically does a better job. The intuitive idea behind this approach is (1) use a mixed effects model to describe the evolution of the biomarker and (2) use the estimated evolutions in the Cox model.

A key assumption in this model is Full Conditional Independence.
* the longitudinal outcome is independent of the time-to-event outcome
* the repeated measurements in the longitudinal outcome are independent of each other

## Resources

[Joint Modeling with R Course Notes](http://www.drizopoulos.com/courses/Int/JMwithR_CEN-ISBS_2017.pdf) | [Joint Modeling Course Notes](http://www.drizopoulos.com/courses/EMC/ESP72.pdf)