library("RGA")
library(bigrquery)

rga_auth <- authorize(client.id = "763027251379-oi1e09vt1ihldj5hopjeud1hfqccqnpt.apps.googleusercontent.com", client.secret = "50OtdUyjIyMQ1Y4Lhd3FWrtO")
accs <- list_accounts(token = rga_auth)
prop <- list_webproperties(token = rga_auth)
views <- list_profiles(token = rga_auth)
gaData <- get_ga(profileId = "ga:80806929",
                 start.date    = "2018-08-01",
                 end.date      = "2018-08-31",
                 dimensions     = "ga:date,ga:sourceMedium,ga:campaign,ga:adContent,ga:keyword",
                 metrics       = "ga:sessions,ga:goal16Starts,ga:goal17Starts,ga:goal18Starts,ga:goal19Starts,ga:goal20Starts,ga:bounces,ga:entrances,ga:sessionDuration,ga:pageviews",
                 samplingLevel =  "HIGHER_PRECISION",
                 filters = "ga:landingPagePath=@domestic/fridge-freezers-1728,ga:landingPagePath=@brand/k-20000-30231,ga:landingPagePath=@brand/artline-30228,ga:landingPagePath=@brand/miele-cm-31419,ga:landingPagePath=@brand/kmda-34970,ga:landingPagePath=@domestic/hobs-1492,ga:landingPagePath=@brand/ecoflex-30229,ga:landingPagePath=@domestic/wine-units-1746,ga:landingPagePath=@domestic/cooker-hoods-1638,ga:landingPagePath=@domestic/baking-and-steam-cooking-1442",
                 max.results   = 10000,
                 token = rga_auth)


insert_upload_job(project = "model-creek-196411",
                  dataset = "Miele_Kitchen_Experience",
                  table = "analytics",
                  values = gaData,
                  create_disposition = "CREATE_IF_NEEDED",
                  write_disposition = "WRITE_APPEND")
