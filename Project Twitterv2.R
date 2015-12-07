require(twitteR)
require(qdap)
require(dplyr)

consumerKey <- "gBfTFnBgkOMOTyGMHfn7Yi61Q"
consumerSecret <- "O6a8nQqP4mxwoycLboQKN0UUQO4KZ5VBtOXSxtLtZlYqj3OazG"
access_token <- "4121943856-Pi6FbcLXcZ6loEdogKupf3UyezreT5my5E5CIS2"
access_secret <- "Xt2ojwIIhlymq77oqgH0mO0vEmKK3pysdsdLfh4oFLOT1"


setup_twitter_oauth(consumerKey, consumerSecret, access_token, access_secret)

tweets112615 <- userTimeline('NatGeo', n=3200)

save(tweets112615, file = "tweets(11-26-15).save")

CNNtweets112515 <- userTimeline('CNN', n=3200)

save(CNNtweets112515, file = "CNNtweets(11-25-15).save")

FOXtweets112515 <- userTimeline('FOXTV', n=3200)

save(FOXtweets112515, file = "FOXtweets(11-25-15).save")

BBCtweets112515 <- userTimeline('WORLD', n=3200)

save(BBCtweets112515, file = "BBCtweets(11-25-15).save")

CBStweets112515 <- userTimeline('CBS', n=3200)

save(CBStweets112515, file = "CBStweets(11-25-15).save")

sapply(x, "[[", "retweetCount")

sapply(x, "[[", "favoriteCount")

Cleanup <- lapply(x, function(y){
  
y = gsub('http\\S+\\s*','',y)
})

#Twitter Analysis 

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
  #score <- c(vNegMatches, negMatches, posMatches, vPosMatches)
  # Add rows 
  #newrow <- c(initial_sentence, score)
  #final_scores <- rbind(final_scores, newrow)
  final_score <- -vNegMatches - negMatches + posMatches + vPosMatches
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



dft.2 <- dft.1 %>% select(text,favoriteCount,retweetCount,Sentiment_Score, Popularity_Score, created)
