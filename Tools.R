library(hash)
ResultsToDataFrame <- function(Results){
  
  ResultKeys <- keys(Results)
  for(i in 1:(length(ResultKeys)))
  {
    List <- vector()
    Key <- ResultKeys[i]
    # list <- append(list, key)
    HashList <- Results[[Key]]
    List <- append(List,HashList[-c(3,8)])
    
    if(i==1)
    {
      df <-data.frame(List)
    }
    else
    {
      List <- data.frame(List)
      df <- rbind(df,List)
    }
    
  }
  df <-cbind(ResultKeys,df)
  dfNames <- c("method","Expected Exceedances",
               "Actual Exceedances","Kupiec stat",
               "Kupiec Critical","Kupiec p-value",
               "Kupiec Decision","Christoffersen-stat",
               "Christoffersen Critical","Christoffersen p-value"
               ,"Christoffersen Decision")
  colnames(df) <- dfNames
  return(df)
}