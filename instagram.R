Sources from http://thinktostart.com/analyze-instagram-r/
  https://cran.r-project.org/doc/contrib/de_Jonge+van_der_Loo-Introduction_to_data_cleaning_with_R.pdf

require(dplyr)
require(sentiment)

load("statsProject-master/natgeo_11-13-15.saved")
load("statsProject-master/natgeo_11-14-15.saved")
load("statsProject-master/natgeo_11-15-15.saved")
load("statsProject-master/natgeo_11-16-15.saved")
load("statsProject-master/natgeo_11-17-15.saved")
load("statsProject-master/natgeo_11-19-15.saved")
load("statsProject-master/natgeo_11-22-15.saved")
load("statsProject-master/natgeo_11-23-15.saved")
load("statsProject-master/natgeo_11-26-15.saved")

df13 <- data.frame(no = 1:length(media$data))
for(i in 1:length(media$data)){
  # # of comments 
  df13$comments[i] <- media$data[[i]]$comments$count
  
  # # of likes
  df13$likes[i] <- media$data[[i]]$likes$count
  
  # # 
  df13$date[i] <- toString(as.POSIXct(as.numeric(media$data[[i]]$created_time), origin="1970-01-01"))
  
  # caption
  df13$caption[i] <- media$data[[i]]$caption$text
  
  # time 
  df13$time[i] <- media$data[[i]]$created_time
}
df14 <- data.frame(no = 1:length(media111415$data))
for(i in 1:length(media111415$data)){
  # # of comments 
  df14$comments[i] <- media111415$data[[i]]$comments$count
  
  # # of likes
  df14$likes[i] <- media111415$data[[i]]$likes$count
  
  # 
  df14$date[i] <- toString(as.POSIXct(as.numeric(media111415$data[[i]]$created_time), origin="1970-01-01"))
  
  # caption
  df14$caption[i] <- media111415$data[[i]]$caption$text
  
  # time 
  df14$time[i] <- media111415$data[[i]]$created_time
}
df15 <- data.frame(no = 1:length(media111515$data))
for(i in 1:length(media111515$data)){
  # # of comments 
  df15$comments[i] <- media111515$data[[i]]$comments$count
  
  # # of likes
  df15$likes[i] <- media111515$data[[i]]$likes$count
  
  #  
  df15$date[i] <- toString(as.POSIXct(as.numeric(media111515$data[[i]]$created_time), origin="1970-01-01"))
  
  # caption
  df15$caption[i] <- media111515$data[[i]]$caption$text
  
  # date
  df15$time[i] <- media111515$data[[i]]$created_time
}
df16 <- data.frame(no = 1:length(media111615$data))
for(i in 1:length(media111515$data)){
  # # of comments 
  df16$comments[i] <- media111615$data[[i]]$comments$count
  
  # # of likes
  df16$likes[i] <- media111615$data[[i]]$likes$count
  
  # 
  df16$date[i] <- toString(as.POSIXct(as.numeric(media111615$data[[i]]$created_time), origin="1970-01-01"))
  
  # caption
  df16$caption[i] <- media111615$data[[i]]$caption$text
  
  # date
  df16$time[i] <- media111615$data[[i]]$created_time
}
df17 <- data.frame(no = 1:length(media111715$data))
for(i in 1:length(media111715$data)){
  # # of comments 
  df17$comments[i] <- media111715$data[[i]]$comments$count
  
  # # of likes
  df17$likes[i] <- media111715$data[[i]]$likes$count
  
  # 
  df17$date[i] <- toString(as.POSIXct(as.numeric(media111715$data[[i]]$created_time), origin="1970-01-01"))
  
  # caption
  df17$caption[i] <- media111715$data[[i]]$caption$text
  
  # date
  df17$time[i] <- media111715$data[[i]]$created_time
}
df19 <- data.frame(no = 1:length(media111915$data))
for(i in 1:length(media111915$data)){
  # # of comments 
  df19$comments[i] <- media111915$data[[i]]$comments$count
  
  # # of likes
  df19$likes[i] <- media111915$data[[i]]$likes$count
  
  # # 
  df19$date[i] <- toString(as.POSIXct(as.numeric(media111915$data[[i]]$created_time), origin="1970-01-01"))
  
  # date
  df19$time[i] <- media111915$data[[i]]$created_time
}
df22 <- data.frame(no = 1:length(media112215$data))
for(i in 1:length(media112215$data)){
  # # of comments 
  df22$comments[i] <- media112215$data[[i]]$comments$count
  
  # # of likes
  df22$likes[i] <- media112215$data[[i]]$likes$count
  
  # 
  df22$date[i] <- toString(as.POSIXct(as.numeric(media112215$data[[i]]$created_time), origin="1970-01-01"))
  
  # caption
  df22$caption[i] <- media112215$data[[i]]$caption$text
  
  # date
  df22$time[i] <- media112215$data[[i]]$created_time
}
df23 <- data.frame(no = 1:length(media112315$data))
for(i in 1:length(media112315$data)){
  # # of comments 
  df23$comments[i] <- media112315$data[[i]]$comments$count
  
  # # of likes
  df23$likes[i] <- media112315$data[[i]]$likes$count
  
  # 
  df23$date[i] <- toString(as.POSIXct(as.numeric(media112315$data[[i]]$created_time), origin="1970-01-01"))
  
  # caption
  df23$caption[i] <- media112315$data[[i]]$caption$text
  
  # date
  df23$time[i] <- media112315$data[[i]]$created_time
}
df26 <- data.frame(no = 1:length(media112615$data))
for(i in 1:length(media112615$data)){
  # # of comments 
  df26$comments[i] <- media112615$data[[i]]$comments$count
  
  # # of likes
  df26$likes[i] <- media112615$data[[i]]$likes$count
  
  # 
  df26$date[i] <- toString(as.POSIXct(as.numeric(media112615$data[[i]]$created_time), origin="1970-01-01"))
  
  # caption
  df26$caption[i] <- media112615$data[[i]]$caption$text
  
  # date
  df26$time[i] <- media112615$data[[i]]$created_time
}
#bind all the data frames together 
df <- bind_rows(df13,df14)
df <- bind_rows(df,df15)
df <- bind_rows(df,df16)
df <- bind_rows(df,df17)
df <- bind_rows(df,df19)
df <- bind_rows(df,df22)
df <- bind_rows(df,df23)
df <- bind_rows(df,df26)
# remove duplicate posts 
df.2 <- df[!duplicated(df$date),]
#order by date
df.2$time <- as.numeric(df.2$time)
# clean text 
# Remove @photographer
df.2$caption <- gsub("@\\w+", "", df.2$caption)
#remove \n
df.2$caption <- gsub("\n", "", df.2$caption)
#remove Photo by
df.2$caption <- gsub("Photo by", "", df.2$caption)
#remove hashtages
df.2$caption <- gsub("#", "", df.2$caption)
#remove slashes 
df.2$caption <- gsub("//", "", df.2$caption)
#Sentiment Analysis 
#Source: http://andybromberg.com/sentiment-analysis/
#Source: Positive Words https://github.com/williamgunn/SciSentiment/blob/master/positive-words.txt
#Source: Negative Words https://github.com/jeffreybreen/twitter-sentiment-analysis-tutorial-201107/blob/master/data/opinion-lexicon-English/negative-words.txt
require(stringr)
# Additional Positive and Negative Words 
positiveText <- read.delim(file = '~/math154/statsProject/statsProject-master/Positive Words.txt', header=FALSE, stringsAsFactors = FALSE)
positiveText <- positiveText$V1
positiveText <- unlist(lapply(positiveText, function(x) { str_split(x, "\n")}))
positiveText <- gsub("\\\\", "", positiveText)
positiveText <- positiveText[7:2011]
negativeText <- read.delim(file = '~/math154/statsProject/statsProject-master/Negative Words.txt', header=FALSE, stringsAsFactors = FALSE)
negativeText <- negativeText$V1
negativeText <- unlist(lapply(negativeText, function(x) { str_split(x, "\n")}))
negativeText <- gsub("\\\\", "", negativeText)
negativeText <- negativeText[14:4794]
#
afinn_list <- read.delim(file= '~/math154/statsProject/statsProject-master/AFINN-111.txt', header=FALSE, stringsAsFactors = FALSE)
names(afinn_list) <- c('word', 'score')
afinn_list$word <- tolower(afinn_list$word)
vNegTerms <- afinn_list$word[afinn_list$score==-5 | afinn_list$score==-4]
negTerms <- c(afinn_list$word[afinn_list$score==-3 | afinn_list$score==-2 | afinn_list$score==-1])
posTerms <- c(afinn_list$word[afinn_list$score==3 | afinn_list$score==2 | afinn_list$score==1])
vPosTerms <- afinn_list$word[afinn_list$score==5 | afinn_list$score==4]
#
sentimentScore <- function(sentences, vNegTerms, negTerms, posTerms, vPosTerms){
  final_scores <- matrix('',0,5)
  scores <- laply(sentences, function(sentence, vNegTerms, negTerms, posTerms, vPosTerms){
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
    #score <- c(vNegMatches, negMatches, posMatches, vPosMatches)
    # Add rows 
    #newrow <- c(initial_sentence, score)
    #final_scores <- rbind(final_scores, newrow)
    final_score <- -2*vNegMatches - negMatches + posMatches + 2*vPosMatches
    return(final_score)
  }, vNegTerms,negTerms,posTerms,vPosTerms)
  return(scores)
}#
#Sentiment Score calculator Taken primarily from source 
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
  #score <- c(vNegMatches, negMatches, posMatches, vPosMatches)
  # Add rows 
  #newrow <- c(initial_sentence, score)
  #final_scores <- rbind(final_scores, newrow)
  final_score <- -vNegMatches - negMatches + posMatches + vPosMatches
  return(final_score)
}
#Add in sentiment scores 
for(i in 1:nrow(df.2)){
  df.2$Sentiment_Score[i] <- sentimentScore(df.2$caption[i],vNegTerms,negTerms,posTerms,vPosTerms)
}
df.2$Sentiment_Score
#Add in popularity score 
for(i in 1:nrow(df.2)){
  df.2$Popularity_Score[i] <- df.2$likes[i] + 50*df.2$comments[i]
}
#install.packages(sentiment,repos = "http://www.omegahat.org/R)
require(randomForest)

model.1 <- randomForest(Popularity_Score~time+Sentiment_Score,data=df.2, mtry=2, importance=TRUE)

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

isAnimal <- c(animal_list$V1)
isAnimal <- tolower(isAnimal)

#Add in animal scores 
for(i in 1:nrow(df.2)){
  df.2$animal_score[i] <- animalScore(df.2$caption[i],isAnimal)
}
plot(df.2$animal_score,df.2$Popularity_Score)

geo_list <- read.delim(file= '~/math154/statsProject/statsProject-master/geowords.txt', header=FALSE, stringsAsFactors = FALSE)
geoScore <- function(sentence, animalTerms){
  initial_sentence <- sentence
  sentence <- gsub("[[:punct:]]","", sentence)
  sentence <- gsub("[[:cntrl:]]","", sentence)
  sentence <- gsub("\\d+","", sentence)
  sentence <- tolower(sentence)
  wordList <- str_split(sentence, '\\s+')
  words <- unlist(wordList)
  #Match positive and negative Terms
  num <- 1
  posMatches <- c()
  while(num <= length(words)){
  posMatch <- intersect(words[num], animalTerms)
  if(length(posMatch) > 0){
  posMatches[num] <- posMatch
  }
  num <- num+1
  }
  # Sum up the matches 
  #posMatches <- sum(!is.na(posMatches))
  #score <- c(vNegMatches, negMatches, posMatches, vPosMatches)
  # Add rows 
  #newrow <- c(initial_sentence, score)
  #final_scores <- rbind(final_scores, newrow)
  #if(posMatches > 0){
  #  final_score <- 1
  #} else {
  #  final_score <- 0
  #}
  return(posMatches)
}

isGeo <- c(geo_list$V1)
isGeo <- tolower(isGeo) 

for(i in 1:nrow(df.2)){
  df.2$geo_score[i] <- photoScore(df.2$caption[i],isGeo)
}
plot(df.2$geo_score,df.2$Popularity_Score)

photo_list <- read.delim(file= '~/math154/statsProject/statsProject-master/photo.txt', header=FALSE, stringsAsFactors = FALSE)
photoScore <- function(sentence, animalTerms){
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
  return(posMatches)
}

isPhoto <- c(photo_list$V1)
isPhoto <- tolower(isPhoto) 

for(i in 1:nrow(df.2)){
  df.2$photo_score[i] <- photoScore(df.2$caption[i],isPhoto)
}
plot(df.2$photo_score,df.2$Popularity_Score)

model.2 <- randomForest(Popularity_Score~.,data=df.2, mtry=2, importance=TRUE)

test <- data.frame
test <- cbind(t(df.2$Popularity_Score)[1,],t(df.2$animal_score)[1,])
for(i in 1:nrow(df.2)){
  if(df.2$Popularity_Score[i] > 477031.5){
    df.2$isPopular[i] <- 2
  } else if(df.2$Popularity_Score[i] > 376675.5){
    df.2$isPopular[i] <- 1
  } else {
    df.2$isPopular[i] <- 0
  }
}
impersonal_list <- c("i","me","my","we","ours","our","weve","ive","mine","myself")
personal_list <- c("you","guys","youve","your","yours","yall")
passive_list <- c("are","is","were","being","was","has", "will")
for(i in 1:nrow(df.2)){
  df.2$Word_Count[i] <- sapply(gregexpr("\\W+", (df.2$caption[i])), length) + 1
}

for(i in 1:nrow(df.2)){
  df.2$passive_score[i] <- photoScore(df.2$text[i],passive_list)
}

for(i in 1:nrow(df.2)){
  df.2$personal_score[i] <- photoScore(df.2$text[i],personal_list)
}

for(i in 1:nrow(df.2)){
  if(as.numeric(substr(df.2$date[i],11,13))>=12){
    df.2$Time[i] <- "0"
  } 
  else{
    df.2$Time[i] <- "1"
  }
}

for(i in 1:nrow(df.2)){
  df.2$impersonal_score[i] <- photoScore(df.2$text[i],impersonal_list)
}

df.2$isPopular <- as.factor(df.2$isPopular)
df.3 <- df.2[,-c(1,2,3,4,5,6,8)]
df.3$animal_score <- as.factor(df.3$animal_score)
df.3$geo_score <- as.factor(df.3$geo_score)
df.3$photo_score <- as.factor(df.3$photo_score)
myFOrst <- randomForest(isPopular~.,data=df.3, mtry=2, importance=TRUE)
