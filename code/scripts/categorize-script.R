data <- read.csv("data/data-sets/cleaned-data-set/clean-data.csv")

categorized_data = data[data$STABBR != "PR",]
categorized_data = categorized_data[categorized_data$STABBR != "VI",]

WM = c()
WN = c()
MM = c()
MN = c()
NM = c()
NN = c()
SM = c()
SN = c()

length(summary(data$STABBR))
for(i in 1:nrow(data)){
  row <- data[i,]
  
  W <- row$WEST
  M <- row$MIDWEST
  N <- row$NORTHEAST
  S <- row$SOUTH
  Major <- row$MAJOR_CITY

  if(W && Major){
    WM = c(WM, 1)
    WN = c(WN, 0)
    MM = c(MM, 0)
    MN = c(MN, 0)
    NM = c(NM, 0)
    NN = c(NN, 0)
    SM = c(SM, 0)
    SN = c(SN, 0)
  }
  if(W && !Major){
    WM = c(WM, 0)
    WN = c(WN, 1)
    MM = c(MM, 0)
    MN = c(MN, 0)
    NM = c(NM, 0)
    NN = c(NN, 0)
    SM = c(SM, 0)
    SN = c(SN, 0)
  }
  if(M && Major){
    WM = c(WM, 0)
    WN = c(WN, 0)
    MM = c(MM, 1)
    MN = c(MN, 0)
    NM = c(NM, 0)
    NN = c(NN, 0)
    SM = c(SM, 0)
    SN = c(SN, 0)
  }
  if(M && !Major){
    WM = c(WM, 0)
    WN = c(WN, 0)
    MM = c(MM, 0)
    MN = c(MN, 1)
    NM = c(NM, 0)
    NN = c(NN, 0)
    SM = c(SM, 0)
    SN = c(SN, 0)
  }
  if(N && Major){
    WM = c(WM, 0)
    WN = c(WN, 0)
    MM = c(MM, 0)
    MN = c(MN, 0)
    NM = c(NM, 1)
    NN = c(NN, 0)
    SM = c(SM, 0)
    SN = c(SN, 0)
  }
  if(N && !Major){
    WM = c(WM, 0)
    WN = c(WN, 0)
    MM = c(MM, 0)
    MN = c(MN, 0)
    NM = c(NM, 0)
    NN = c(NN, 1)
    SM = c(SM, 0)
    SN = c(SN, 0)
  }
  if(S && Major){
    WM = c(WM, 0)
    WN = c(WN, 0)
    MM = c(MM, 0)
    MN = c(MN, 0)
    NM = c(NM, 0)
    NN = c(NN, 0)
    SM = c(SM, 1)
    SN = c(SN, 0)
  }
  if(S && !Major){
    WM = c(WM, 0)
    WN = c(WN, 0)
    MM = c(MM, 0)
    MN = c(MN, 0)
    NM = c(NM, 0)
    NN = c(NN, 0)
    SM = c(SM, 0)
    SN = c(SN, 1)
  }
}
categorized_data$WM = WM
categorized_data$WN = WN
categorized_data$MM = MM
categorized_data$MN = MN
categorized_data$NM = NM
categorized_data$NN = NN
categorized_data$SM = SM
categorized_data$SN = SN

write.csv(categorized_data, file = "data/data-sets/cleaned-data-set/categorized-data.csv")
