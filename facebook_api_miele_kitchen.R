library(devtools)
install_github('selesnow/rfacebookstat')
library(rfacebookstat)

load(file="fb_tok.RData")

stat <- fbGetMarketingStat(accounts_id = "act_667348143393426",
                           sorting = NULL,
                           level = "ad",
                           breakdowns = "age",
                           fields = "impressions",
                           filtering = NULL,
                           date_start = Sys.Date()-3,
                           date_stop = Sys.Date(),
                           api_version = "v3.1",
                           access_token = longtime_token)
