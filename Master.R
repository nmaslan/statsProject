require(twitteR)
require(qdap)
require(dplyr)
require(stringr)
require(randomForest)
require(tree)

load("statsProject/Tweets/tweets(11-14-15).save")
load("statsProject/Tweets/tweets(11-15-15).save")
load("statsProject/Tweets/tweets(11-16-15).save")
load("statsProject/Tweets/tweets(11-17-15).save")
load("statsProject/Tweets/tweets(11-18-15).save")
load("statsProject/Tweets/tweets(11-19-15).save")
load("statsProject/Tweets/tweets(11-22-15).save")
load("statsProject/Tweets/tweets(11-23-15).save")
load("statsProject/Tweets/tweets(11-24-15).save")
load("statsProject/Tweets/tweets(11-25-15).save")
load("statsProject/Tweets/tweets(11-26-15).save")

dft1 <- twListToDF(tweets111415)
dft2 <- twListToDF(tweets111515)
dft3 <- twListToDF(tweets111615)
dft4 <- twListToDF(tweets111715)
dft5 <- twListToDF(tweets111815)
dft6 <- twListToDF(tweets111915)
dft7 <- twListToDF(tweets112215)
dft8 <- twListToDF(tweets112315)
dft9 <- twListToDF(tweets112415)
dft10 <- twListToDF(tweets112515)
dft11 <- twListToDF(tweets112615)

dft.1 <- rbind(dft1,dft2,dft3,dft4,dft5,dft6,dft7,dft8,dft9,dft10,dft11)

df.2 <- dft.1 %>% select(text,favoriteCount,retweetCount,created)

#Code taken from https://sites.google.com/site/miningtwitter/questions/sentiment/sentiment

df.2$text = gsub("(RT|via)((?:\\b\\W*@\\w+)+)", "", df.2$text)
# remove at people
df.2$text = gsub("@\\w+", "", df.2$text)
# remove punctuation
df.2$text = gsub("[[:punct:]]", "", df.2$text)
# remove numbers
df.2$text = gsub("[[:digit:]]", "", df.2$text)
# remove html links
df.2$text = gsub("http\\w+", "", df.2$text)
# remove unnecessary spaces
df.2$text = gsub("[ \t]{2,}", "", df.2$text)
df.2$text = gsub("^\\s+|\\s+$", "", df.2$text)

#Sentiment Analysis 

afinn_list <- read.delim(file= '~/statsProject/AFINN-111.txt', header=FALSE, stringsAsFactors = FALSE)
names(afinn_list) <- c('word', 'score')
afinn_list$word <- tolower(afinn_list$word)

vNegTerms <- afinn_list$word[afinn_list$score==-5 | afinn_list$score==-4]
negTerms <- c(afinn_list$word[afinn_list$score==-3 | afinn_list$score==-2 | afinn_list$score==-1])
posTerms <- c(afinn_list$word[afinn_list$score==3 | afinn_list$score==2 | afinn_list$score==1])
vPosTerms <- afinn_list$word[afinn_list$score==5 | afinn_list$score==4]


sentimentScore <- function(sentence, vNegTerms, negTerms, posTerms, vPosTerms){
  initial_sentence <- sentence
  sentence <- gsub("[[:punct:]]","", sentence)
  sentence <- gsub("[[:cntrl:]]","", sentence)
  sentence <- gsub("\\d+","", sentence)
  sentence <- tolower(sentence)
  wordList <- str_split(sentence, '\\s+')
  words <- unlist(wordList)
  #Match positive and negative Terms 
  vPosMatches <- match(words, vPosTerms)
  posMatches <- match(words, posTerms)
  vNegMatches <- match(words, vNegTerms)
  negMatches <- match(words,negTerms)
  # Sum up the matches 
  vPosMatches <- sum(!is.na(vPosMatches))
  posMatches <- sum(!is.na(posMatches))
  vNegMatches <- sum(!is.na(vNegMatches))
  negMatches <- sum(!is.na(negMatches))

  final_score <- -vNegMatches - negMatches + posMatches + vPosMatches
  return(final_score)
}

#Passive Analysis
passive_list <- c("are","is","were","being","was","has", "will")
passiveScore <- function(sentence, passiveTerms){
  initial_sentence <- sentence
  sentence <- gsub("[[:punct:]]","", sentence)
  sentence <- gsub("[[:cntrl:]]","", sentence)
  sentence <- gsub("\\d+","", sentence)
  sentence <- tolower(sentence)
  wordList <- str_split(sentence, '\\s+')
  words <- unlist(wordList)
  #Match positive and negative Terms 
  posMatches <- match(words, passiveTerms)
  # Sum up the matches 
  posMatches <- sum(!is.na(posMatches))
  #score <- c(vNegMatches, negMatches, posMatches, vPosMatches)
  # Add rows 
  #newrow <- c(initial_sentence, score)
  #final_scores <- rbind(final_scores, newrow)
  if(posMatches > 0){
    final_score <- posMatches
  } else {
    final_score <- 0
  }
  return(final_score)
}

#Personal Analysis

personal_list <- c("you","guys","youve","your","yours","yall")

personalScore <- function(sentence, personalTerms){
  initial_sentence <- sentence
  sentence <- gsub("[[:punct:]]","", sentence)
  sentence <- gsub("[[:cntrl:]]","", sentence)
  sentence <- gsub("\\d+","", sentence)
  sentence <- tolower(sentence)
  wordList <- str_split(sentence, '\\s+')
  words <- unlist(wordList)
  #Match positive and negative Terms 
  posMatches <- match(words, personalTerms)
  # Sum up the matches 
  posMatches <- sum(!is.na(posMatches))
  #score <- c(vNegMatches, negMatches, posMatches, vPosMatches)
  # Add rows 
  #newrow <- c(initial_sentence, score)
  #final_scores <- rbind(final_scores, newrow)
  if(posMatches > 0){
    final_score <- posMatches
  } else {
    final_score <- 0
  }
  return(final_score)
}

#Impersonal Analysis

impersonal_list <- c("i","me","my","we","ours","our","weve","ive","mine","myself")

impersonalScore <- function(sentence, personalTerms){
  initial_sentence <- sentence
  sentence <- gsub("[[:punct:]]","", sentence)
  sentence <- gsub("[[:cntrl:]]","", sentence)
  sentence <- gsub("\\d+","", sentence)
  sentence <- tolower(sentence)
  wordList <- str_split(sentence, '\\s+')
  words <- unlist(wordList)
  #Match positive and negative Terms 
  posMatches <- match(words, personalTerms)
  # Sum up the matches 
  posMatches <- sum(!is.na(posMatches))
  #score <- c(vNegMatches, negMatches, posMatches, vPosMatches)
  # Add rows 
  #newrow <- c(initial_sentence, score)
  #final_scores <- rbind(final_scores, newrow)
  if(posMatches > 0){
    final_score <- posMatches
  } else {
    final_score <- 0
  }
  return(final_score)
}

#Animal Analysis

animal_list <- read.delim(file= '~/statsProject/animals.txt', header=FALSE, stringsAsFactors = FALSE)

animalScore <- function(sentence, animalTerms){
  initial_sentence <- sentence
  sentence <- gsub("[[:punct:]]","", sentence)
  sentence <- gsub("[[:cntrl:]]","", sentence)
  sentence <- gsub("\\d+","", sentence)
  sentence <- tolower(sentence)
  wordList <- str_split(sentence, '\\s+')
  words <- unlist(wordList)
  #Match positive and negative Terms 
  posMatches <- match(words, animalTerms)
  # Sum up the matches 
  posMatches <- sum(!is.na(posMatches))
  #score <- c(vNegMatches, negMatches, posMatches, vPosMatches)
  # Add rows 
  #newrow <- c(initial_sentence, score)
  #final_scores <- rbind(final_scores, newrow)
  if(posMatches > 0){
    final_score <- 1
  } else {
    final_score <- 0
  }
  return(final_score)
}

isAnimal <- c(animal_list$V1)
isAnimal <- tolower(isAnimal)

geo_list <- read.delim(file= '~/statsProject/geo_words.txt', header=FALSE, stringsAsFactors = FALSE)
geoScore <- function(sentence, Terms){
  initial_sentence <- sentence
  sentence <- gsub("[[:punct:]]","", sentence)
  sentence <- gsub("[[:cntrl:]]","", sentence)
  sentence <- gsub("\\d+","", sentence)
  sentence <- tolower(sentence)
  wordList <- str_split(sentence, '\\s+')
  words <- unlist(wordList)
  #Match positive and negative Terms 
  posMatches <- match(words, Terms)
  # Sum up the matches 
  posMatches <- sum(!is.na(posMatches))
  #score <- c(vNegMatches, negMatches, posMatches, vPosMatches)
  # Add rows 
  #newrow <- c(initial_sentence, score)
  #final_scores <- rbind(final_scores, newrow)
  if(posMatches > 0){
    final_score <- 1
  } else {
    final_score <- 0
  }
  return(final_score)
}

isGeo <- c(geo_list$V1)
isGeo <- tolower(isGeo) 


photo_list <- read.delim(file= '~/statsProject/photo.txt', header=FALSE, stringsAsFactors = FALSE)
photoScore <- function(sentence, Terms){
  initial_sentence <- sentence
  sentence <- gsub("[[:punct:]]","", sentence)
  sentence <- gsub("[[:cntrl:]]","", sentence)
  sentence <- gsub("\\d+","", sentence)
  sentence <- tolower(sentence)
  wordList <- str_split(sentence, '\\s+')
  words <- unlist(wordList)
  #Match positive and negative Terms 
  posMatches <- match(words, Terms)
  # Sum up the matches 
  posMatches <- sum(!is.na(posMatches))
  #score <- c(vNegMatches, negMatches, posMatches, vPosMatches)
  # Add rows 
  #newrow <- c(initial_sentence, score)
  #final_scores <- rbind(final_scores, newrow)
  if(posMatches > 0){
    final_score <- 1
  } else {
    final_score <- 0
  }
  return(posMatches)
}

isPhoto <- c(photo_list$V1)
isPhoto <- tolower(isPhoto) 

for(i in 1:nrow(df.2)){
  df.2$photo_score[i] <- photoScore(df.2$text[i],isPhoto)
}




for(i in 1:nrow(dft.1)){
  df.2$Sentiment_Score[i] <- sentimentScore(df.2$text[i],vNegTerms,negTerms,posTerms,vPosTerms)
}    

for(i in 1:nrow(df.2)){
  df.2$Popularity_Score[i] <- df.2$favoriteCount[i] + 2*df.2$retweetCount[i]
} 

for(i in 1:nrow(df.2)){
  df.2$isPopular[i]  <- ifelse(df.2$Popularity_Score[i] >= quantile(df.2$Popularity_Score,0.75),"Popular",
                               ifelse(df.2$Popularity_Score[i] < quantile(df.2$Popularity_Score,0.25),"UnPopular","Average"))
}

df.2$isPopular <- as.factor(df.2$isPopular)

for(i in 1:nrow(df.2)){
  df.2$Word_Count[i] <- sapply(gregexpr("\\W+", (df.2$text[i])), length) + 1
}

for(i in 1:nrow(df.2)){
  df.2$passive_score[i] <- passiveScore(df.2$text[i],passive_list)
}

for(i in 1:nrow(df.2)){
  df.2$personal_score[i] <- personalScore(df.2$text[i],personal_list)
}

for(i in 1:nrow(df.2)){
  df.2$animal_score[i] <- animalScore(df.2$text[i],isAnimal)
}

for(i in 1:nrow(df.2)){
  df.2$impersonal_score[i] <- impersonalScore(df.2$text[i],impersonal_list)
}

for(i in 1:nrow(df.2)){
  df.2$geo_score[i] <- geoScore(df.2$text[i],isGeo)
}

for(i in 1:nrow(df.2)){
  if(as.numeric(substr(df.2$created[i],11,13))>=12){
    df.2$Time[i] <- "0"
  } 
  else{
    df.2$Time[i] <- "1"
  }
}


df.2$animal_score <- as.factor(df.2$animal_score)
df.2$geo_score <- as.factor(df.2$geo_score)
df.2$photo_score <- as.factor(df.2$photo_score)
df.2$passive_score <- as.factor(df.2$passive_score)
df.2$personal_score <- as.factor(df.2$personal_score)
df.2$impersonal_score <- as.factor(df.2$impersonal_score)
df.3 <- df.2 %>% select(-text,-created,-isPopular,-favoriteCount, -retweetCount)
df.2 <- df.2 %>% select(-Popularity_Score, -favoriteCount, -retweetCount)
model1 <- randomForest(isPopular~.,data=df.2, mtry=9, importance=TRUE)
model2 <- randomForest(isPopular~.,data=df.2, mtry=7, importance=TRUE)
model1
model2
importance(model1)
importance(model2)

model1a <- tree(Popularity_Score~.,data=df.3)
model2a <- randomForest(Popularity_Score~.,data=df.3, mtry=8, importance=TRUE)
