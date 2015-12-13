#Analysis for BBC

require(twitteR)
require(qdap)
require(dplyr)
require(stringr)
require(randomForest)

load("statsProject/Tweets/BBCtweets(11-15-15).save")
load("statsProject/Tweets/BBCtweets(11-16-15).save")
load("statsProject/Tweets/BBCtweets(11-17-15).save")
load("statsProject/Tweets/BBCtweets(11-18-15).save")
load("statsProject/Tweets/BBCtweets(11-19-15).save")
load("statsProject/Tweets/BBCtweets(11-22-15).save")
load("statsProject/Tweets/BBCtweets(11-23-15).save")
load("statsProject/Tweets/BBCtweets(11-24-15).save")
load("statsProject/Tweets/BBCtweets(11-25-15).save")


dftB2 <- twListToDF(BBCtweets111515)
dftB3 <- twListToDF(BBCtweets111615)
dftB4 <- twListToDF(BBCtweets111715)
dftB5 <- twListToDF(BBCtweets111815)
dftB6 <- twListToDF(BBCtweets111915)
dftB7 <- twListToDF(BBCtweets112215)
dftB8 <- twListToDF(BBCtweets112315)
dftB9 <- twListToDF(BBCtweets112415)
dftB10 <- twListToDF(BBCtweets112515)

dftB.1 <- rbind(dftB1,dftB2,dftB3,dftB4,dftB5,dftB6,dftB7,dftB8,dftB9,dftB10,dftB11)

dfB.2 <- dftB.1 %>% select(text,favoriteCount,retweetCount,created)

#Code taken from https://sites.google.com/site/miningtwitter/questions/sentiment/sentiment

dfB.2$text = gsub("(RT|via)((?:\\b\\W*@\\w+)+)", "", dfB.2$text)
# remove at people
dfB.2$text = gsub("@\\w+", "", dfB.2$text)
# remove punctuation
dfB.2$text = gsub("[[:punct:]]", "", dfB.2$text)
# remove numbers
dfB.2$text = gsub("[[:digit:]]", "", dfB.2$text)
# remove html links
dfB.2$text = gsub("http\\w+", "", dfB.2$text)
# remove unnecessary spaces
dfB.2$text = gsub("[ \t]{2,}", "", dfB.2$text)
dfB.2$text = gsub("^\\s+|\\s+$", "", dfB.2$text)

for(i in 1:nrow(dfB.2)){
  dfB.2$photo_score[i] <- photoScore(dfB.2$text[i],isPhoto)
}




for(i in 1:nrow(dft.1)){
  dfB.2$Sentiment_Score[i] <- sentimentScore(dfB.2$text[i],vNegTerms,negTerms,posTerms,vPosTerms)
}    

for(i in 1:nrow(dfB.2)){
  dfB.2$Popularity_Score[i] <- dfB.2$favoriteCount[i] + 2*dfB.2$retweetCount[i]
} 

for(i in 1:nrow(dfB.2)){
  if(dfB.2$Popularity_Score[i] >= 1000){
    dfB.2$isPopular[i] = 1
  } else {
    dfB.2$isPopular[i] = 0
  }
}


dfB.2$isPopular <- as.factor(dfB.2$isPopular)

for(i in 1:nrow(dfB.2)){
  dfB.2$Word_Count[i] <- sapply(gregexpr("\\W+", (dfB.2$text[i])), length) + 1
}

for(i in 1:nrow(dfB.2)){
  dfB.2$passive_score[i] <- passiveScore(dfB.2$text[i],passive_list)
}

for(i in 1:nrow(dfB.2)){
  dfB.2$personal_score[i] <- personalScore(dfB.2$text[i],personal_list)
}

for(i in 1:nrow(dfB.2)){
  dfB.2$animal_score[i] <- animalScore(dfB.2$text[i],isAnimal)
}

for(i in 1:nrow(dfB.2)){
  dfB.2$impersonal_score[i] <- impersonalScore(dfB.2$text[i],impersonal_list)
}

for(i in 1:nrow(dfB.2)){
  dfB.2$geo_score[i] <- geoScore(dfB.2$text[i],isGeo)
}

for(i in 1:nrow(dfB.2)){
  if(as.numeric(substr(dfB.2$created[i],11,13))>=12){
    dfB.2$Time[i] <- "0"
  } 
  else{
    dfB.2$Time[i] <- "1"
  }
}


dfB.2$animal_score <- as.factor(dfB.2$animal_score)
dfB.2$geo_score <- as.factor(dfB.2$geo_score)
dfB.2$photo_score <- as.factor(dfB.2$photo_score)
dfB.2$passive_score <- as.factor(dfB.2$passive_score)
dfB.2$personal_score <- as.factor(dfB.2$personal_score)
dfB.2$impersonal_score <- as.factor(dfB.2$impersonal_score)
dfB.2 <- dfB.2 %>% select(-text,-created,-Popularity_Score, -favoriteCount, -retweetCount)
modelB1 <- randomForest(isPopular~.,data=dfB.2, mtry=9, importance=TRUE)
modelB2 <- randomForest(isPopular~.,data=dfB.2, mtry=8, importance=TRUE)
modelB1
modelB2
importance(modelB1)
importance(modelB2)