library(Dowd)

GetSampleReturns <- function(Sample, Returns){
  SampleReturns <- as.vector(as.numeric())
  for(i in 1:(length(Sample)))
  {
    SampleReturns[i] <- Returns[i]
  }
  return(SampleReturns)
}
FilteredHistoricalSimulation <- function(Returns, Sigma, WindowLength, Probability ){
  
  NumberOfInteration <-length(Returns) - WindowLength
  
  StandarizedReturns <-as.numeric(vector())
  StandarizedHsVaRs <-as.numeric(vector())
  for(j in 1:NumberOfInteration)
  {
    Return <- as.numeric(Returns[j+(WindowLength)])
    sigmaCurrent <- Sigma[j]
    StandarizedReturn <- Return/SigmaCurrent
    StandarizedReturns[j] <- StandarizedReturn
  }
  SampleRoof <- length(StandarizedReturns)
  for(k in 1:(NumberOfInteration))
  {
    
    Sample <- sample(1:SampleRoof,WindowLength,replace = TRUE)
    WindowData <- GetSampleReturns(Sample,StandarizedReturns)
    
    StandarizedHsVaRs[k] <- HSVaR(WindowData,probability) 
    StandarizedHsVaRs[k] <- StandarizedHsVaRs[k]*sigma[k]
  }
  return(StandarizedHsVaRs)
}
