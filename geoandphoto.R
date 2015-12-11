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

isGeo <- c(geo_list$V1)
isGeo <- tolower(isGeo) 

for(i in 1:nrow(df.2)){
  df.2$geo_score[i] <- geoScore(df.2$caption[i],isGeo)
}
plot(df.2$geo_score,df.2$Popularity_Score)

photo_list <- read.delim(file= '~/math154/statsProject/statsProject-master/photo.txt', header=FALSE, stringsAsFactors = FALSE)
geoScore <- function(sentence, animalTerms){
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
  df.2$photo_score[i] <- geoScore(df.2$caption[i],isPhoto)
}
plot(df.2$photo_score,df.2$Popularity_Score)

model.2 <- randomForest(Popularity_Score~.,data=df.2, mtry=2, importance=TRUE)

test <- data.frame
test <- cbind(t(df.2$Popularity_Score)[1,],t(df.2$animal_score)[1,])
for(i in 1:nrow(df.2)){
  if(df.2$Popularity_Score[i] > 500000){
  df.2$isPopular[i] <- 1
  } else {
    df.2$isPopular[i] <- 0
  }
}
df.2$isPopular <- as.factor(df.2$isPopular)
df.3 <- df.2[,-c(1,2,3,4,5,6,7,8)]
df.3$animal_score <- as.factor(df.3$animal_score)
df.3$geo_score <- as.factor(df.3$geo_score)
df.3$photo_score <- as.factor(df.3$photo_score)
randomForest(isPopular~.,data=df.3, mtry=2, importance=TRUE)
