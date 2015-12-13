# Analysis for FOX

require(twitteR)
require(qdap)
require(dplyr)
require(stringr)
require(randomForest)

load("statsProject/Tweets/FOXtweets(11-15-15).save")
load("statsProject/Tweets/FOXtweets(11-16-15).save")
load("statsProject/Tweets/FOXtweets(11-17-15).save")
load("statsProject/Tweets/FOXtweets(11-18-15).save")
load("statsProject/Tweets/FOXtweets(11-19-15).save")
load("statsProject/Tweets/FOXtweets(11-22-15).save")
load("statsProject/Tweets/FOXtweets(11-23-15).save")
load("statsProject/Tweets/FOXtweets(11-24-15).save")
load("statsProject/Tweets/FOXtweets(11-25-15).save")


dftB2 <- twListToDF(FOXtweets111515)
dftB3 <- twListToDF(FOXtweets111615)
dftB4 <- twListToDF(FOXtweets111715)
dftB5 <- twListToDF(FOXtweets111815)
dftB6 <- twListToDF(FOXtweets111915)
dftB7 <- twListToDF(FOXtweets112215)
dftB8 <- twListToDF(FOXtweets112315)
dftB9 <- twListToDF(FOXtweets112415)
dftB10 <- twListToDF(FOXtweets112515)

dftB.1 <- rbind(dftB1,dftB2,dftB3,dftB4,dftB5,dftB6,dftB7,dftB8,dftB9,dftB10,dftB11)

dfF.2 <- dftB.1 %>% select(text,favoriteCount,retweetCount,created)

#Code taken from https://sites.google.com/site/miningtwitter/questions/sentiment/sentiment

dfF.2$text = gsub("(RT|via)((?:\\b\\W*@\\w+)+)", "", dfF.2$text)
# remove at people
dfF.2$text = gsub("@\\w+", "", dfF.2$text)
# remove punctuation
dfF.2$text = gsub("[[:punct:]]", "", dfF.2$text)
# remove numbers
dfF.2$text = gsub("[[:digit:]]", "", dfF.2$text)
# remove html links
dfF.2$text = gsub("http\\w+", "", dfF.2$text)
# remove unnecessary spaces
dfF.2$text = gsub("[ \t]{2,}", "", dfF.2$text)
dfF.2$text = gsub("^\\s+|\\s+$", "", dfF.2$text)

for(i in 1:nrow(dfF.2)){
  dfF.2$photo_score[i] <- photoScore(dfF.2$text[i],isPhoto)
}




for(i in 1:nrow(dft.1)){
  dfF.2$Sentiment_Score[i] <- sentimentScore(dfF.2$text[i],vNegTerms,negTerms,posTerms,vPosTerms)
}    

for(i in 1:nrow(dfF.2)){
  dfF.2$Popularity_Score[i] <- dfF.2$favoriteCount[i] + 2*dfF.2$retweetCount[i]
} 

for(i in 1:nrow(dfF.2)){
  if(dfF.2$Popularity_Score[i] >= 1000){
    dfF.2$isPopular[i] = 1
  } else {
    dfF.2$isPopular[i] = 0
  }
}


dfF.2$isPopular <- as.factor(dfF.2$isPopular)

for(i in 1:nrow(dfF.2)){
  dfF.2$Word_Count[i] <- sapply(gregexpr("\\W+", (dfF.2$text[i])), length) + 1
}

for(i in 1:nrow(dfF.2)){
  dfF.2$passive_score[i] <- passiveScore(dfF.2$text[i],passive_list)
}

for(i in 1:nrow(dfF.2)){
  dfF.2$personal_score[i] <- personalScore(dfF.2$text[i],personal_list)
}

for(i in 1:nrow(dfF.2)){
  dfF.2$animal_score[i] <- animalScore(dfF.2$text[i],isAnimal)
}

for(i in 1:nrow(dfF.2)){
  dfF.2$impersonal_score[i] <- impersonalScore(dfF.2$text[i],impersonal_list)
}

for(i in 1:nrow(dfF.2)){
  dfF.2$geo_score[i] <- geoScore(dfF.2$text[i],isGeo)
}

for(i in 1:nrow(dfF.2)){
  if(as.numeric(substr(dfF.2$created[i],11,13))>=12){
    dfF.2$Time[i] <- "0"
  } 
  else{
    dfF.2$Time[i] <- "1"
  }
}


dfF.2$animal_score <- as.factor(dfF.2$animal_score)
dfF.2$geo_score <- as.factor(dfF.2$geo_score)
dfF.2$photo_score <- as.factor(dfF.2$photo_score)
dfF.2$passive_score <- as.factor(dfF.2$passive_score)
dfF.2$personal_score <- as.factor(dfF.2$personal_score)
dfF.2$impersonal_score <- as.factor(dfF.2$impersonal_score)
dfF.2 <- dfF.2 %>% select(-text,-created,-Popularity_Score, -favoriteCount, -retweetCount)
modelF1 <- randomForest(isPopular~.,data=dfF.2, mtry=9, importance=TRUE)
modelF2 <- randomForest(isPopular~.,data=dfF.2, mtry=8, importance=TRUE)
modelF1
modelF2
importance(modelF1)
importance(modelF2)