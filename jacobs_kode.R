library(daiR)
library(googleCloudStorageR)
project_id <- daiR::get_project_id()
gcs_list_buckets(project_id)

# Synchronous OCR with a file already in the working directory:
Arblog <- dai_sync("Arabicblog.pdf")
text <- text_from_dai_response(Arblog)
cat(text)

# Asynchronous OCR from Arabic pdf image (a book)
# Create the bucket. Note: GCS doesn't like capitals in bucket names
gcs_create_bucket("muqabasat", project_id, location = "EU")

#You need to set the global bucket for R to find it
gcs_global_bucket("muqabasat")
gcs_list_objects()

#ٍOverriding default size limit of 5MB
gcs_upload_set_limit(upload_limit = 2000000000L)

# Upload the file
treatises <- gcs_upload("Threetreatises.pdf")
# Then do the same for other files. I didn't get the function to
# upload several files in one go.

# Processing the pdf file (goes to root bucket directory in GCS)
response1 <- dai_async(c("Threetreatises.pdf", "muqabasat_ocrexercise.pdf"))
#NOTE: Got a strange error message here: "invalid bucket parameter". It
#turned out that there was no GCS_DEFAULT_BUCKET parameter in the 
#environment, and the dai_async() function requires that parameter. I
# ran Sys.setenv(GCS_DEFAULT_BUCKET = "muqabasat") and it worked.

dai_status(response1)

# Checking the contents of the cloud
gcs_list_objects()

# If processing resulted in many .json files, gather them in one object. Use gcs_list_objects()
# to get the file list, make a tibble of it and delete anything but
# the file name from the tibble (I used regex in Atom for this). Then
# simply copypaste the resulting list, with "", into a vector. Jeg
# gjorde de første trinnene slik:
#Samle alle .json-filene fra GCS i en vektor

jsonvektor <- gcs_list_objects()
library(tidyverse)
as_tibble(jsonvektor)
view(jsonvektor)
#Velg filnavnet og skriv det til en .csv-fil for behandling i editor
select(jsonvektor, name) %>% 
  write.csv(file = "twopdfs.csv")

# Skrell bort alt annet enn filnavnet og lim inn listen i en vektor:

twopdfs <- c("18387260004667668490/0/Threetreatises-0.json", 
             "18387260004667668490/0/Threetreatises-1.json", 
             "18387260004667668490/0/Threetreatises-10.json", 
             "18387260004667668490/0/Threetreatises-11.json", 
             "18387260004667668490/0/Threetreatises-12.json", 
             "18387260004667668490/0/Threetreatises-13.json", 
             "18387260004667668490/0/Threetreatises-14.json", 
             "18387260004667668490/0/Threetreatises-15.json", 
             "18387260004667668490/0/Threetreatises-16.json", 
             "18387260004667668490/0/Threetreatises-17.json", 
             "18387260004667668490/0/Threetreatises-18.json", 
             "18387260004667668490/0/Threetreatises-19.json", 
             "18387260004667668490/0/Threetreatises-2.json", 
             "18387260004667668490/0/Threetreatises-20.json", 
             "18387260004667668490/0/Threetreatises-21.json", 
             "18387260004667668490/0/Threetreatises-22.json", 
             "18387260004667668490/0/Threetreatises-23.json", 
             "18387260004667668490/0/Threetreatises-3.json", 
             "18387260004667668490/0/Threetreatises-4.json", 
             "18387260004667668490/0/Threetreatises-5.json", 
             "18387260004667668490/0/Threetreatises-6.json", 
             "18387260004667668490/0/Threetreatises-7.json", 
             "18387260004667668490/0/Threetreatises-8.json", 
             "18387260004667668490/0/Threetreatises-9.json", 
             "18387260004667668490/1/muqabasat_ocrexercise-0.json", 
             "18387260004667668490/1/muqabasat_ocrexercise-1.json", 
             "18387260004667668490/1/muqabasat_ocrexercise-10.json", 
             "18387260004667668490/1/muqabasat_ocrexercise-11.json", 
             "18387260004667668490/1/muqabasat_ocrexercise-12.json", 
             "18387260004667668490/1/muqabasat_ocrexercise-13.json", 
             "18387260004667668490/1/muqabasat_ocrexercise-14.json", 
             "18387260004667668490/1/muqabasat_ocrexercise-15.json", 
             "18387260004667668490/1/muqabasat_ocrexercise-16.json", 
             "18387260004667668490/1/muqabasat_ocrexercise-2.json", 
             "18387260004667668490/1/muqabasat_ocrexercise-3.json", 
             "18387260004667668490/1/muqabasat_ocrexercise-4.json", 
             "18387260004667668490/1/muqabasat_ocrexercise-5.json", 
             "18387260004667668490/1/muqabasat_ocrexercise-6.json", 
             "18387260004667668490/1/muqabasat_ocrexercise-7.json", 
             "18387260004667668490/1/muqabasat_ocrexercise-8.json", 
             "18387260004667668490/1/muqabasat_ocrexercise-9.json")

# Downloading many jsons: Iteration solution with "for" loop.
#First create vector with all the filenames, as described above. Then run 
#the loop to download each .json file:
for (file in twopdfs) {
  gcs_get_object(file, saveToDisk = basename(file), overwrite=TRUE)
}

#Samle alle nedlastede .json-filer fra forrige loop i én vektor:
twopdfs_jsons <- list.files(pattern = "*.json")
twopdfs_jsons

#Trekke ut teksten fra .json-filene i vektoren:
library(daiR)

# først lager vi en tom tekstvektor
full_text <- character() 

# Så looper vi over vektoren med json-filene
for (json in twopdfs_jsons) {
  txt <- text_from_dai_file(json)
  full_text <- paste(full_text, "\n", txt)
}
# her fyller vi på den tomme tekstvektoren med tekst fra json-filene.

# Lagre R-objektet som fil i Windows:
Sys.setlocale("LC_CTYPE", "arabic")
write(full_text, "fullpdfs.txt")
Sys.setlocale("LC_CTYPE", "English")
#This produces a file that Word can read, but not Atom or Notepad. Why?
# The text writes fine when opened as an object inside RStudio. 
#Something must be wrong with the Sys.setlocale script.

cat(full_text)
