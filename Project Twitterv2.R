require(twitteR)
require(qdap)

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
