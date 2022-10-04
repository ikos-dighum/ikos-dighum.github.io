### The necessary packages ###

require(daiR)
require(googleCloudStorageR)
require(purrr)
require(fs)
require(stringr)
require(glue)
require(here)
require(rlang)
require(stringr)

### First we must open our .Renviron file to provide all necessary data ###
usethis::edit_r_environ()

### We will then put our Google Cloud project ID into the R environment ###
project_id <- daiR::get_project_id()


### Once information is provided, we will check our buckets in Google Cloud
gcs_list_buckets(project_id)


### The answer is, if first time, "NULL" so we need to create one. ###
### Information in quotation marks is bucket name, then we provide project ID vector, and choice of location ###
gcs_create_bucket("das_seminar_bucket", project_id, location = "EU")

### If our bucket name has not been written into our .Renviron file, then we can do it with the following code ###
gcs_global_bucket("das_seminar_bucket")

### We will then check the content of our newly created bucket, which obviously will be NULL ###
gcs_list_objects()

### Assuming that you have now uploaded your files, we will set up an iteration for waiting time ###

process_slowly <- function(file) {
  dai_async(file)
  Sys.sleep(30)
}

### And vectorize the content in our bucket ###
content <- gcs_list_objects()
big_batch <- content$name

### We will then process our files in bucket with the map() function###
map(big_batch, process_slowly)

### Very often, we will receive a HTTP status: 429 - unsuccesful if processing hundreds of files ###
### So we need to identify those unprocessed ###
### First we vectorize the .json files that we have produced and we mine their stems ###

contents <- gcs_list_objects()
jsons <- grep("*.json", contents$name, value = TRUE)

### We then use the head() and tail() functions to make sure we have all .json files ###
head(jsons)
tail(jsons)

### Depending on what you named the files you uploaded to your bucket ###
### We will use regex to identify the stems since the .jsons files have ###
### the prefix "100143430000013434530000" etc.
### The regex code below is based on file names based on dates such as "2018_08_31", "2011_10_01" etc. ###
### the d stands for "digit" and {2} and {4} is the amount of digits. For example d{4} are the four digits in year ###
### while d{2} are the two digits in months and days. Use a regex cheat sheet to write your regex code ###
json_stems <- unlist(str_extract_all(jsons, "\\d{4}_\\d{2}_\\d{2}")) 
head(json_stems)

### We will then try to find the unique .json stems ###
json_stems_unique <- unique(json_stems)
head(json_stems_unique)

### Once we have identified the unique .json stems, we will need to do the same with the files we uploaded. ###
### In this case, we uploaded .pdfs, but you can change this to .jpg or .tiff if that are the files you uploaded ###
### We will use the same regex code to find the stems ###

pdfs <- grep("*.pdf", contents$name, value = TRUE)
pdfs <- list.files(dir)
pdf_stems <- unlist(str_extract_all(pdfs, "\\d{4}_\\d{2}_\\d{2}"))
pdf_stems_unique <- unique(pdf_stems)

### We will then use the setdiff() function to compare the unique .json files and the unique .pdf files ###
remaining <- setdiff(pdf_stems_unique, json_stems_unique)

### If we try to run the map() function on the vector "remaining" it won't execute as there is no information ###
### in the vector that we are trying to reprocess .pdfs. The names in the vector are simply "2018_02_31" and not ###
### "2018_02_31.pdf". We will thus use the paste0() function to add a ".pdf" to the end of the file names ###
remaining <- paste0(remaining, ".pdf")

### We can then reprocess the unprocessed files with the same map() function ###
map(remaining, process_slowly)

### Once we have processed all files uploaded and we have all the .json files we need, we provide the following commands ###
### to download them. The grep() function makes sure we only download the .json files and not the .pdfs we uploaded ###
### the saveToDisk makes sure to download the files to your wd. Also, all .json files have been put in folders ###
### So you need the str_replace_all() function to replace the / in the directory paths to a "-" so that R can find the ###
### .json files ###
bucket_contents <- gcs_list_objects()
only_jsons <- grep("*.json", bucket_contents$name, value = TRUE)
map(only_jsons, ~ gcs_get_object(.x, saveToDisk = str_replace_all(.x, "/", "_")))

### Once you have the .json files, you can delete all content in the bucket with the following command ###
contents <- gcs_list_objects()
map(contents$name, gcs_delete_object)

### Once we have all the .json files, then we will want to extract the text from them ###

### Extracting text from .jsons by first providing the path to the directory with all the .json files ###
### and a destination directory for where we want to place all the shards ###
jsons_on_file <- dir_ls(here("D:\\GreenMENA\\newspapers\\vg_remaining_jsons"))
jsons <- dir_ls(here("D:\\GreenMENA\\newspapers\\vg_remaining_jsons"))
destdir <- here("D:\\GreenMENA\\newspapers\\vg_shards")

#Elias will need to explain this one -> map(jsons_on_file, ~ draw_blocks(.x, dir=here("box_images"))) ###
x <- jsons_on_file

### Don't worry. We will explain iterations in a couple of weeks ###
### Just remember, the Sys.setlocale() is necessary for Windows users and can be ignored on Linux ###
get_text_and_name <- function(x) {
  print(glue("Parsing {basename(x)} .."))
  text <- text_from_dai_file(x)
  stem <- str_sub(basename(x), end = -5)
  filename <- paste0(stem, "txt")
  filepath <- file.path(destdir, filename)
  Sys.setlocale("LC_CTYPE", "arabic")
  write.csv(text, filepath, fileEncoding = "utf8", row.names = FALSE)
  Sys.setlocale("LC_CTYPE", "English")
}

### Then we provide the command to extract the .txt files ###
map(jsons, get_text_and_name)

### Once you have extracted all .txt shards, you have to merge them ###
### But to do so, we will need to install the GitHub version of daiR ###
devtools::install_github("hegghammer/daiR", force = TRUE)

### and then we provide the directory with the shards and the directory in which we want to place the merged shards ###
### Merging shards ###
shard_dir <- here("D:\\GreenMENA\\newspapers\\vg_shards")
dest_dir <- here("D:\\GreenMENA\\newspapers\\vg_merged")

### We then run the merge_shards() function ###
merge_shards(shard_dir, dest_dir)




