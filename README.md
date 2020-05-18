# Risk-analysis

This repository contains functions which I wrote and used in my bachelor thesis.
It is about Value at Risk, a widely used measure of market risk.

The HybidHistoricalSimulation.R and FilteredHistoricalSimulation are implementations of estimation methods by the same names,
introduced accordingly by Boudouhk, Richardson and Whitelaw (1998) and Barone‐Adesi, Giannopoulos and Vosper (1999).

 The PerformCalculation.R contains function to calculate all estimation methods used in by study containing in addition to above
 also Cornish-Fisher Expansion (1938), ARMA-GARCH models, variance-covariance method and historical simulation.
 
The Evaluation.R contains functions to perform Kupiec (1995) and Christoffersen (1998) as well
as procedures to choose correct models and the most accurate forecast bast of asymmetric linear loss function 
(González-Rivera, Lee and Mishra, 2004).

 The Tools.R contains function which takes the return object of EvaluateVaR function (Evaluation.R) and transform it into dataframe.
The Example.R – as the name suggests.

References:
Barone‐Adesi, G., Giannopoulos, K., & Vosper, L. (1999). VaR without correlations for portfolios of derivative securities. Journal of Futures Markets, 19(5), 583-602.

Boudoukh, M. Richardson, M. Whitelaw (1998) The Best of Both Worlds. Risk, 11(5): 64-67

Christoffersen, P. (1998). Evaluating Interval Forecasts. International Economic Review, 39(4), 841-862.

Cornish, E. A., & Fisher, R. A. (1938). Moments and cumulants in the specification of distributions. Revue de l'Institut international de Statistique, (5) 307-320.

González-Rivera, G., Lee, T. H., & Mishra, S. (2004). Forecasting volatility: A reality check based on option pricing, utility function, value-at-risk, and predictive likelihood. International Journal of forecasting, 20(4), 629-645.

Kupiec, P. (1995). Techniques for verifying the accuracy of risk measurement models, Journal of Derivatives, 3(2),  173 – 184.
