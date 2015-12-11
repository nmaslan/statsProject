require(twitteR)
require(qdap)
require(dplyr)
require(stringr)

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

dft.1 <- c(dft.1$text,dft.1$favoriteCount,dft.1$retweetCount,dft.1$created)

#Code taken from https://sites.google.com/site/miningtwitter/questions/sentiment/sentiment

dft.1$text = gsub("(RT|via)((?:\\b\\W*@\\w+)+)", "", dft.1$text)
# remove at people
dft.1$text = gsub("@\\w+", "", dft.1$text)
# remove punctuation
dft.1$text = gsub("[[:punct:]]", "", dft.1$text)
# remove numbers
dft.1$text = gsub("[[:digit:]]", "", dft.1$text)
# remove html links
dft.1$text = gsub("http\\w+", "", dft.1$text)
# remove unnecessary spaces
dft.1$text = gsub("[ \t]{2,}", "", dft.1$text)
dft.1$text = gsub("^\\s+|\\s+$", "", dft.1$text)

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
  posMatches <- match(words, animalTerms)
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

animal_list <- read.delim(file= '~/math154/statsProject/statsProject-master/animals.txt', header=FALSE, stringsAsFactors = FALSE)

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



for(i in 1:nrow(dft.1)){
  dft.1$Sentiment_Score[i] <- sentimentScore(dft.1$text[i],vNegTerms,negTerms,posTerms,vPosTerms)
}    

for(i in 1:nrow(dft.1)){
  dft.1$Popularity_Score[i] <- dft.1$favoriteCount[i] + 2*dft.1$retweetCount[i]
}    

for(i in 1:nrow(dft.1)){
  dft.1$Word_Count[i] <- word.count(dft.1$text[i])
}

for(i in 1:nrow(df.1)){
  df.1$passive_score[i] <- passiveScore(df.2$caption[i],passive_list)
}

for(i in 1:nrow(df.1)){
  df.1$personal_score[i] <- personalScore(df.2$caption[i],personal_list)
}

for(i in 1:nrow(df.1)){
  df.1$animal_score[i] <- animalScore(df.2$caption[i],isAnimal)
}

for(i in 1:nrow(df.1)){
  df.1$impersonal_score[i] <- impersonalScore(df.2$caption[i],impersonal_list)
}
