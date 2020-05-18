library(PerformanceAnalytics)
library(Dowd)
library(forecast)
library(rugarch)
library(GAS)
library(MCS)
library(hash)
source("WeightedHistoricalSimulation.R")
source("hybridHistoricalSimulation.R")


CalculateVaRs <- function(Returns, Probability, WindowLength, Decay, Refit){
  
  NumberOfInteration <-(length(Returns) - WindowLength)
  HSVaRs <- as.numeric(vector())
  NormalVaRs <- as.numeric(vector())
  CornishFisherVaRs <- as.numeric(vector())
  WeightedHSVaRs <- as.numeric(vector())
  HybridHSNormalVaRs <- as.numeric(vector())
  HybridHSStudentVaRs <- as.numeric(vector())
  Level <- 1- Probability
  
  for(i in 1:NumberOfInteration)
  {
    WindowData <- as.numeric(Returns[i:(i+WindowLength-1)])
    HSVaRs[i] <- (HSVaR(WindowData,probability))
    NormalVaRs[i] <-NormalVaR(returns = Returns, cl = Probability, hp = 1)
    CornishFisherVaRs[i] <-VaR(Returns, p =Probability, method ="modified")*(-1)
    WeightedHSVaRs[i] <- HybridHistoricalSimulation(returns = Returns,decay = Decay, probability = Level, windowLenght = WindowLength+1) 
    
  }
  
  
  Arima <- auto.arima(Returns, i = "bic")
  MeanOrder <- as.vector(arimaorder(Arima))
  Garchspec <- ugarchspec(mean.model = list(armaOrder = MeanOrder), variance.model = list(model = "sGARCH"),
                          distribution.model = "norm")
  Student_tGarchspec<- ugarchspec(mean.model = list(armaOrder = MeanOrder), variance.model = list(model = "sGARCH"),distribution.model = "std")
  
  NormalGarchRoll <- ugarchroll(Student_tGarchspec, data = Returns, n.start = WindowLength, refit.window = "moving",
                                refit.every = Refit, calculate.VaR = TRUE,VaR.alpha = c(Level))
  
  Student_tGarchRoll <- ugarchroll(Student_tGarchspec, data = Returns, n.start = WindowLength, refit.window = "moving",
                                   refit.every = Refit, calculate.VaR = TRUE,VaR.alpha = c(Level))
  
  NormalGarchVars <- (-1)*NormalGarchRoll@forecast$VaR$`alpha(5%)`
  Student_tGarchVaRs <-(-1)*Student_tGarchRoll@forecast$VaR$`alpha(5%)`
  
  
  SigmaNormalGarch <- NormalGarchRoll@forecast$density$Sigma
  SigmaStudent_tGarch <- Student_tGarchRoll@forecast$density$Sigma
  
  
  HybridHSNormalVaRs <- FilteredHistoricalSimulation(Returns,SigmaNormalGarch, WindowLength, Probability)
  HybridHSStudentVaRs <-FilteredHistoricalSimulation(Returns,SigmaStudent_tGarch, WindowLength, Probability)
  
  Results <- hash()
  Results[["HistoricalVaR"]] <- HSVaRs
  Results[["NormalVaR"]] <-NormalVaRs
  Results[["CornishFisherVaR"]] <-CornishFisherVaRs
  Results[["WeightedHistoricalVaR"]] <- WeightedHSVaRs
  Results[["NormalGarchVaR"]] <- NormalGarchVars
  Results[["StudentGarchVaR"]] <- Student_tGarchVaRs
  Results[["HybridHSNormalVaR"]] <- HybridHSStudentVaRs
  Results["HybridHSStudentVaR"] <- HybridHSNormalVaRs
  
  return(Results)
  
}
