#Sources from http://thinktostart.com/analyze-instagram-r/
#https://cran.r-project.org/doc/contrib/de_Jonge+van_der_Loo-Introduction_to_data_cleaning_with_R.pdf

require(dplyr)
require(sentiment)
require(plyr)

load("natgeo_11-13-15.saved")
load("natgeo_11-14-15.saved")
load("natgeo_11-15-15.saved")
load("natgeo_11-16-15.saved")
load("natgeo_11-17-15.saved")
load("natgeo_11-19-15.saved")
load("natgeo_11-22-15.saved")
load("natgeo_11-23-15.saved")
load("natgeo_11-26-15.saved")

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
  
  # # data
  df19$date[i] <- toString(as.POSIXct(as.numeric(media111915$data[[i]]$created_time), origin="1970-01-01"))
  
  # caption
  df19$caption[i] <- media111915$data[[i]]$caption$text
  
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
  
  # # of 
for(i in 1:length(media112315$data)){
  # # of comments 
  df23$comments[i] <- media112315$data[[i]]$comments$count
  
  # # of likes
  df23$likes[i] <- media112315$data[[i]]$likes$count
  
  # date
  df23$date[i] <- toString(as.POSIXct(as.numeric(media112315$data[[i]]$created_time), origin="1970-01-01"))
  
  # caption
  df23$caption[i] <- media112315$data[[i]]$caption$text
  
  # time
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

#SAVE df.2


#Sentiment Analysis 
#Source: http://andybromberg.com/sentiment-analysis/
#Source: Positive Words https://github.com/williamgunn/SciSentiment/blob/master/positive-words.txt
#Source: Negative Words https://github.com/jeffreybreen/twitter-sentiment-analysis-tutorial-201107/blob/master/data/opinion-lexicon-English/negative-words.txt
require(stringr)
# Additional Positive and Negative Words 
# clean up text
positiveText <- read.delim(file = 'Positive Words.txt', header=FALSE, stringsAsFactors = FALSE)
positiveText <- positiveText$V1
positiveText <- unlist(lapply(positiveText, function(x) { str_split(x, "\n")}))
positiveText <- gsub("\\\\", "", positiveText)
positiveText <- positiveText[7:2011]
negativeText <- read.delim(file = 'Negative Words.txt', header=FALSE, stringsAsFactors = FALSE)
negativeText <- negativeText$V1
negativeText <- unlist(lapply(negativeText, function(x) { str_split(x, "\n")}))
negativeText <- gsub("\\\\", "", negativeText)
negativeText <- negativeText[14:4794]
#

afinn_list <- read.delim(file= 'AFINN-111.txt', header=FALSE, stringsAsFactors = FALSE)
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


#Add AM/PM variable 

  for(i in 1:nrow(df.2)){
    if(as.numeric(substr(df.2$date[i],11,13))>=12){
      df.2$Time[i] <- "PM"
    } 
    else{
      df.2$Time[i] <- "AM"
    }
  }
#Add in popularity score 

for(i in 1:nrow(df.2)){
  df.2$Popularity_Score[i] <- df.2$likes[i] + 50*df.2$comments[i]
}

#save df.2
write.table(df.2, file = "df.2.csv")
write.csv(df.2, file = "df.2.csv")

#install.packages(sentiment,repos = "http://www.omegahat.org/R)
require(randomForest)
model.1 <- randomForest(Popularity_Score~time+Sentiment_Score,data=df.2, mtry=4, importance=TRUE)
