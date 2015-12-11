require(stringr)

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

#Add in personal scores 
for(i in 1:nrow(df.2)){
  df.2$personal_score[i] <- personalScore(df.2$caption[i],personal_list)
}