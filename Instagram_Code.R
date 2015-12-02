#Class project

require(twitteR)
require(httr)
require(httpuv)
require(RJSONIO)
require(RCurl)

#Instagram #http://www.r-bloggers.com/analyze-instagram-with-r/
full_url <- oauth_callback()
full_url <- gsub("(.*localhost:[0-9]{1,5}/).*",
x=full_url, replacement="\\1")
print(full_url)

app_name <- "Math 154 Class Project"
client_id <- "d4ee8a29a9794a34a91968569f34da70"
client_secret <- "9cf6bcad38d6414198337e6bcfc2fdfe"
scope = "basic"

instagram <- oauth_endpoint(
  authorize = 
    "https://api.instagram.com/oauth/authorize",
  access = 
    "https://api.instagram.com/oauth/access_token")
myapp <- oauth_app(app_name, client_id, client_secret)

ig_oauth <- oauth2.0_token(instagram, myapp, scope="basic", type = "application/x-www-form-urlencoded", cache=FALSE)
tmp <- strsplit(toString(names(ig_oauth$credentials)),
'"')
token <- tmp[[1]][4]

username <- "natgeo"
user_info <- fromJSON(getURL(paste('https://api.instagram.com/v1/users/search?q=',
                                   username,'&access_token=',token,sep="")),
                                   unexpected.escape="keep")
natgeo_profile <- user_info$data[[1]]

natgeo_id = 787132

media112615 <- fromJSON(getURL(paste('https://api.instagram.com/v1/users/',natgeo_id,'/media/recent/?access_token=',token,sep="")))

save(media112615,file = "natgeo_11-26-15.saved")
#Most recent post
df = media$data[[1]]
#filenames = media(11-??-??).saved

df$caption$text
df$likes$count
df$tags
df$created_time
#Twitter
require(streamR)
require(ROAuth)
require(RCurl)
require(RJSONIO)
require(stringr)
require(httr)
require("twitteR")
require("tm")
requestURL <- "https://api.twitter.com/oauth/request_token"
accessURL <- "https://api.twitter.com/oauth/access_token"
authURL <-"https://api.twitter.com/oauth/authorize"
consumerKey <- "BfTFnBgkOMOTyGMHfn7Yi61Q"
consumerSecret <- "O6a8nQqP4mxwoycLboQKN0UUQO4KZ5VBtOXSxtLtZlYqj3OazG"
access_token <- "4121943856-Pi6FbcLXcZ6loEdogKupf3UyezreT5my5E5CIS2"
access_secret <- "Xt2ojwIIhlymq77oqgH0mO0vEmKK3pysdsdLfh4oFLOT1"

setup_twitter_oauth(consumerKey, consumerSecret, access_token, access_secret)




my_oauth <- OAuthFactory$new(consumerKey = consumerKey, 
                             consumerSecret = consumerSecret,
                             requestURL = requestURL,
                             accessURL = accessURL,
                             authURL = authURL)

my_oauth$handshake(cainfo = system.file("CurlSSL", "cacert.pem", package="RCurl"))

#Twitter2 
require(base64enc)
library(devtools)
library(httr)
install_github("twitteR", username = "geoffjentry/twitteR")
library(twitteR)
getTwitterOAuth("BfTFnBgkOMOTyGMHfn7Yi61Q","O6a8nQqP4mxwoycLboQKN0UUQO4KZ5VBtOXSxtLtZlYqj3OazG")

