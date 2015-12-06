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
