# Analysis for CBS

require(twitteR)
require(qdap)
require(dplyr)
require(stringr)
require(randomForest)

load("statsProject/Tweets/CBStweets(11-15-15).save")
load("statsProject/Tweets/CBStweets(11-16-15).save")
load("statsProject/Tweets/CBStweets(11-17-15).save")
load("statsProject/Tweets/CBStweets(11-18-15).save")
load("statsProject/Tweets/CBStweets(11-19-15).save")
load("statsProject/Tweets/CBStweets(11-22-15).save")
load("statsProject/Tweets/CBStweets(11-23-15).save")
load("statsProject/Tweets/CBStweets(11-24-15).save")
load("statsProject/Tweets/CBStweets(11-25-15).save")


dftB2 <- twListToDF(CBStweets111515)
dftB3 <- twListToDF(CBStweets111615)
dftB4 <- twListToDF(CBStweets111715)
dftB5 <- twListToDF(CBStweets111815)
dftB6 <- twListToDF(CBStweets111915)
dftB7 <- twListToDF(CBStweets112215)
dftB8 <- twListToDF(CBStweets112315)
dftB9 <- twListToDF(CBStweets112415)
dftB10 <- twListToDF(CBStweets112515)

dftB.1 <- rbind(dftB1,dftB2,dftB3,dftB4,dftB5,dftB6,dftB7,dftB8,dftB9,dftB10,dftB11)

dfCB.2 <- dftB.1 %>% select(text,favoriteCount,retweetCount,created)

#Code taken from https://sites.google.com/site/miningtwitter/questions/sentiment/sentiment

dfCB.2$text = gsub("(RT|via)((?:\\b\\W*@\\w+)+)", "", dfCB.2$text)
# remove at people
dfCB.2$text = gsub("@\\w+", "", dfCB.2$text)
# remove punctuation
dfCB.2$text = gsub("[[:punct:]]", "", dfCB.2$text)
# remove numbers
dfCB.2$text = gsub("[[:digit:]]", "", dfCB.2$text)
# remove html links
dfCB.2$text = gsub("http\\w+", "", dfCB.2$text)
# remove unnecessary spaces
dfCB.2$text = gsub("[ \t]{2,}", "", dfCB.2$text)
dfCB.2$text = gsub("^\\s+|\\s+$", "", dfCB.2$text)

for(i in 1:nrow(dfCB.2)){
  dfCB.2$photo_score[i] <- photoScore(dfCB.2$text[i],isPhoto)
}




for(i in 1:nrow(dft.1)){
  dfCB.2$Sentiment_Score[i] <- sentimentScore(dfCB.2$text[i],vNegTerms,negTerms,posTerms,vPosTerms)
}    

for(i in 1:nrow(dfCB.2)){
  dfCB.2$Popularity_Score[i] <- dfCB.2$favoriteCount[i] + 2*dfCB.2$retweetCount[i]
} 

for(i in 1:nrow(dfCB.2)){
  if(dfCB.2$Popularity_Score[i] >= 1000){
    dfCB.2$isPopular[i] = 1
  } else {
    dfCB.2$isPopular[i] = 0
  }
}


dfCB.2$isPopular <- as.factor(dfCB.2$isPopular)

for(i in 1:nrow(dfCB.2)){
  dfCB.2$Word_Count[i] <- sapply(gregexpr("\\W+", (dfCB.2$text[i])), length) + 1
}

for(i in 1:nrow(dfCB.2)){
  dfCB.2$passive_score[i] <- passiveScore(dfCB.2$text[i],passive_list)
}

for(i in 1:nrow(dfCB.2)){
  dfCB.2$personal_score[i] <- personalScore(dfCB.2$text[i],personal_list)
}

for(i in 1:nrow(dfCB.2)){
  dfCB.2$animal_score[i] <- animalScore(dfCB.2$text[i],isAnimal)
}

for(i in 1:nrow(dfCB.2)){
  dfCB.2$impersonal_score[i] <- impersonalScore(dfCB.2$text[i],impersonal_list)
}

for(i in 1:nrow(dfCB.2)){
  dfCB.2$geo_score[i] <- geoScore(dfCB.2$text[i],isGeo)
}

for(i in 1:nrow(dfCB.2)){
  if(as.numeric(substr(dfCB.2$created[i],11,13))>=12){
    dfCB.2$Time[i] <- "0"
  } 
  else{
    dfCB.2$Time[i] <- "1"
  }
}


dfCB.2$animal_score <- as.factor(dfCB.2$animal_score)
dfCB.2$geo_score <- as.factor(dfCB.2$geo_score)
dfCB.2$photo_score <- as.factor(dfCB.2$photo_score)
dfCB.2$passive_score <- as.factor(dfCB.2$passive_score)
dfCB.2$personal_score <- as.factor(dfCB.2$personal_score)
dfCB.2$impersonal_score <- as.factor(dfCB.2$impersonal_score)
dfCB.2 <- dfCB.2 %>% select(-text,-created,-Popularity_Score, -favoriteCount, -retweetCount)
modelCB1 <- randomForest(isPopular~.,data=dfCB.2, mtry=9, importance=TRUE)
modelCB2 <- randomForest(isPopular~.,data=dfCB.2, mtry=8, importance=TRUE)
modelCB1
modelCB2
importance(modelCB1)
importance(modelCB2)