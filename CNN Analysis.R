# Analysis for CNN

require(twitteR)
require(qdap)
require(dplyr)
require(stringr)
require(randomForest)

load("statsProject/Tweets/CNNtweets(11-15-15).save")
load("statsProject/Tweets/CNNtweets(11-16-15).save")
load("statsProject/Tweets/CNNtweets(11-17-15).save")
load("statsProject/Tweets/CNNtweets(11-18-15).save")
load("statsProject/Tweets/CNNtweets(11-19-15).save")
load("statsProject/Tweets/CNNtweets(11-22-15).save")
load("statsProject/Tweets/CNNtweets(11-23-15).save")
load("statsProject/Tweets/CNNtweets(11-24-15).save")
load("statsProject/Tweets/CNNtweets(11-25-15).save")


dftB2 <- twListToDF(CNNtweets111515)
dftB3 <- twListToDF(CNNtweets111615)
dftB4 <- twListToDF(CNNtweets111715)
dftB5 <- twListToDF(CNNtweets111815)
dftB6 <- twListToDF(CNNtweets111915)
dftB7 <- twListToDF(CNNtweets112215)
dftB8 <- twListToDF(CNNtweets112315)
dftB9 <- twListToDF(CNNtweets112415)
dftB10 <- twListToDF(CNNtweets112515)

dftB.1 <- rbind(dftB1,dftB2,dftB3,dftB4,dftB5,dftB6,dftB7,dftB8,dftB9,dftB10,dftB11)

dfCN.2 <- dftB.1 %>% select(text,favoriteCount,retweetCount,created)

#Code taken from https://sites.google.com/site/miningtwitter/questions/sentiment/sentiment

dfCN.2$text = gsub("(RT|via)((?:\\b\\W*@\\w+)+)", "", dfCN.2$text)
# remove at people
dfCN.2$text = gsub("@\\w+", "", dfCN.2$text)
# remove punctuation
dfCN.2$text = gsub("[[:punct:]]", "", dfCN.2$text)
# remove numbers
dfCN.2$text = gsub("[[:digit:]]", "", dfCN.2$text)
# remove html links
dfCN.2$text = gsub("http\\w+", "", dfCN.2$text)
# remove unnecessary spaces
dfCN.2$text = gsub("[ \t]{2,}", "", dfCN.2$text)
dfCN.2$text = gsub("^\\s+|\\s+$", "", dfCN.2$text)

for(i in 1:nrow(dfCN.2)){
  dfCN.2$photo_score[i] <- photoScore(dfCN.2$text[i],isPhoto)
}




for(i in 1:nrow(dft.1)){
  dfCN.2$Sentiment_Score[i] <- sentimentScore(dfCN.2$text[i],vNegTerms,negTerms,posTerms,vPosTerms)
}    

for(i in 1:nrow(dfCN.2)){
  dfCN.2$Popularity_Score[i] <- dfCN.2$favoriteCount[i] + 2*dfCN.2$retweetCount[i]
} 

for(i in 1:nrow(dfCN.2)){
  if(dfCN.2$Popularity_Score[i] >= 1000){
    dfCN.2$isPopular[i] = 1
  } else {
    dfCN.2$isPopular[i] = 0
  }
}


dfCN.2$isPopular <- as.factor(dfCN.2$isPopular)

for(i in 1:nrow(dfCN.2)){
  dfCN.2$Word_Count[i] <- sapply(gregexpr("\\W+", (dfCN.2$text[i])), length) + 1
}

for(i in 1:nrow(dfCN.2)){
  dfCN.2$passive_score[i] <- passiveScore(dfCN.2$text[i],passive_list)
}

for(i in 1:nrow(dfCN.2)){
  dfCN.2$personal_score[i] <- personalScore(dfCN.2$text[i],personal_list)
}

for(i in 1:nrow(dfCN.2)){
  dfCN.2$animal_score[i] <- animalScore(dfCN.2$text[i],isAnimal)
}

for(i in 1:nrow(dfCN.2)){
  dfCN.2$impersonal_score[i] <- impersonalScore(dfCN.2$text[i],impersonal_list)
}

for(i in 1:nrow(dfCN.2)){
  dfCN.2$geo_score[i] <- geoScore(dfCN.2$text[i],isGeo)
}

for(i in 1:nrow(dfCN.2)){
  if(as.numeric(substr(dfCN.2$created[i],11,13))>=12){
    dfCN.2$Time[i] <- "0"
  } 
  else{
    dfCN.2$Time[i] <- "1"
  }
}


dfCN.2$animal_score <- as.factor(dfCN.2$animal_score)
dfCN.2$geo_score <- as.factor(dfCN.2$geo_score)
dfCN.2$photo_score <- as.factor(dfCN.2$photo_score)
dfCN.2$passive_score <- as.factor(dfCN.2$passive_score)
dfCN.2$personal_score <- as.factor(dfCN.2$personal_score)
dfCN.2$impersonal_score <- as.factor(dfCN.2$impersonal_score)
dfCN.2 <- dfCN.2 %>% select(-text,-created,-Popularity_Score, -favoriteCount, -retweetCount)
modelCN1 <- randomForest(isPopular~.,data=dfCN.2, mtry=9, importance=TRUE)
modelCN2 <- randomForest(isPopular~.,data=dfCN.2, mtry=8, importance=TRUE)
modelCN1
modelCN2
importance(modelCN1)
importance(modelCN2)