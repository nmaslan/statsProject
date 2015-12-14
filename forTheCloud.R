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
