HybridHistoricalSimulation <- function(Returns,Decay, Probability, WindowLenght){
  
  Weight <-as.numeric(vector())
  n <-length(Returns)
  CommonDenominator = (1-(Decay **WindowLenght))
  
  for( i in 1:n)
  {
    Weight[i] = (Decay**(i-1)*(1-Decay))/CommonDenominator
    
  }
  Weight <- sort(Weight, decreasing = FALSE)
  x_name <-"returns"
  y_name <- "weights"
  
  DataFrame <- data.frame(Returns, Weight)
  names(df) <-c(x_name,y_name)
  
  
  DataFrame <- DataFrame[with(DataFrame, order(Returns)),]
  
  Sum <- 0
  for(i in 1:WindowLenght)
  {
    Sum = Sum + DataFrame[i,2]
    if(Sum>= Probability)
    {
      break()
    }
  }
  UpperVaR <- (df[i,1])
  LowerVaR <- (df[i-1,1])
  Excess <- Sum - probability
  Shortage <- Sum -(df[i,2])
  Deviation <- Excess +Shortage
  RelativeExcess <- Excess/Deviation
  RelativeShortage <- Shortage/Deviation
  
  return((UpperVaR * RelativeExcess + LowerVaR * RelativeShortage)*(-1))
  
}