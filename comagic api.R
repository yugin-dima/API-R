# получаем данные из api comagic
library("httr")
library("RGA")
library(bigrquery)

tok <- "tai78ognipdgigkeo1w2lysobmzlx4lj34btklq2"

rtrytr <- getwd()

get_comagic_calls <- function(day_from, day_to, token){
  url <- "https://dataapi.comagic.ru/v2.0"
  req <- paste0('{
                "jsonrpc":"2.0",
                "id":"',7777,'",
                "method":"get.calls_report",
                "params":{
                "access_token":"',token,'",
                "limit":10000,
                "date_from":"',day_from,' 00:00:00",
                "date_till":"',day_to,' 23:59:59",
                "fields":[
                "id",
                "start_time",
                "finish_time",
                "finish_reason",
                "direction",
                "source",
                "is_lost",
                "contact_phone_number",
                "communication_id",
                "wait_duration",
                "total_wait_duration",
                "talk_duration",
                "clean_talk_duration",
                "total_duration",
                "call_records",
                "ua_client_id",
                "is_transfer",
                "channel",
                "tags",
                "employees",
                "last_answered_employee_id",
                "last_answered_employee_full_name",
                "first_answered_employee_id",
                "first_answered_employee_full_name",
                "last_talked_employee_id",
                "last_talked_employee_full_name",
                "first_talked_employee_id",
                "first_talked_employee_full_name",
                "campaign_name",
                "campaign_id",
                "visit_other_campaign",
                "visitor_id",
                "person_id",
                "visitor_type",
                "visitor_session_id",
                "visits_count",
                "visitor_first_campaign_id",
                "visitor_first_campaign_name",
                "visitor_city",
                "visitor_region",
                "visitor_country",
                "visitor_device",
                "utm_source",
                "utm_medium",
                "utm_term",
                "utm_content",
                "utm_campaign"
                ]}}')
  res <- POST(url,body = req, encode = "json", verbose())
  out <- jsonlite::fromJSON(content(res, "text"),flatten = TRUE)
  return(out)
}





start_day <- as.POSIXlt("2018-08-01")
#yesterday <- as.POSIXlt.date(as.character(Sys.Date() - 1))
yesterday <- as.POSIXlt("2018-09-30")

day_diff <- diff.Date(yesterday,start_day )



while (day_diff) {
  
  day = yesterday - day_diff
  day_diff <- day_diff - 1
  
  out_tesr <- get_comagic_calls("2018-08-01", "2018-09-30",tok)
 
  
  out_table$employees <- paste(out_table$employees,sep = ",")
  out_table$tags <- paste(out_table$tags,sep = ",")
  out_table$call_records <- paste(out_table$call_records,sep = ",")
  
  
  out_table$utm_content <- as.character(out_table$utm_content)
  out_table$utm_campaign <- as.character(out_table$utm_campaign)
  out_table$utm_term <- as.character(out_table$utm_term)
  out_table$utm_source <- as.character(out_table$utm_source)
  out_table$utm_medium <- as.character(out_table$utm_medium)
  
  out_table$last_talked_employee_full_name <- as.character(out_table$last_talked_employee_full_name)
  out_table$last_talked_employee_id <- as.integer(out_table$last_talked_employee_id)
  out_table$last_answered_employee_id <- as.integer(out_table$last_answered_employee_id)
  out_table$last_answered_employee_full_name <- as.character(out_table$last_answered_employee_full_name)
  
  out_table$first_talked_employee_id <- as.integer(out_table$first_talked_employee_id)
  out_table$first_answered_employee_id<- as.integer(out_table$first_answered_employee_id)
  out_table$first_talked_employee_full_name <- as.character(out_table$first_talked_employee_full_name)
  out_table$first_answered_employee_full_name <- as.character(out_table$first_answered_employee_full_name)
  #out_table$communication_type <- paste(out_table$communication_type,sep = ",")
  
  out_table$visitor_session_id <- as.integer(out_table$visitor_session_id)

  write.csv2(out_table,fileEncoding = "UTF-8", file = "C:/Users/russian/OneDrive/comagic.csv")
  