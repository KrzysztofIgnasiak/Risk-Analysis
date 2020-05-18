library(hash)
library(rugarch)
library(MCS)

EvaluateVaR <- function(Returns, VaRForecasts, Probability ,ConfidenceLevel){
  
  
  Keys <- keys(VaRForecasts)
  Results <- hash()
  for(i in 1:(length(Keys)))
  {
    Key <- Keys[i]
    VaRForecast <- VaRForecasts[[Key]]
    Results[[Key]]<- VaRTest(Probability,Returns,(-1)*VaRForecast, conf.level = ConfidenceLevel)
  }
  return(Results)
}

CalculateLosses <-function(Returns, VaRForecast, Probability){
  
  return (sum(LossVaR(Returns,(-1)*VaRForecast, which = "asymmetricLoss", type = "normal",tau =Pprobability)))
  
}
ChooseCorrect <- function(Results, VARForecasts){
  Keys <- keys(Results)
  CorrectVaRForecast <- hash()
  for(i in 1:(length(Keys)))
  {
    Key <- Keys[i]
    ucDecision <- (Results[[Key]]$uc.Decision)
    ccDecision <- (Results[[Key]]$cc.Decision)
    if((ucDecision == "Fail to Reject H0") && (ccDecision == "Fail to Reject H0"))
    {
      CorrectVaRForecast[[Key]] <- VARForecasts[[Key]]
    }
    
  }
  return(CorrectVaRForecast)
}
ChooseTheBest <- function(Results, Returns, Probability){
  Keys <- keys(Results)
  Losses <- as.numeric(vector())
  for(i in 1:(length(Keys)))
  {
    key <- Keys[i]
    Losses[i] <-  CalculateLosses(Returns, Results[[key]],Probability)
  }
  Losses <- data.frame(Losses)
  Losses <- cbind(Keys,Losses)
  dfNames <- c("method","loss")
  colnames(Losses) <- dfNames
  return(Losses)
}

