require(stringr)

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

#Add in passive scores 
for(i in 1:nrow(df.2)){
  df.2$passive_score[i] <- passiveScore(df.2$caption[i],passive_list)
}
plot(df.2$passsive_score,df.2$Popularity_Score)