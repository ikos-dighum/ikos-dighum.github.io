[**HOME**](/index.md) - [**ABOUT**](/about.md) - [**CALENDAR**](/calendar.md) - [**RESOURCES**](/resources.md) - [**REPOSITORIES**](/repositories.md)

# Resources


## R resources

* Downloading R and R Studio: [Homepage of the R-project](https://cran.r-project.org/).

### Using R for Optical Character Recognition (OCR)

* Setting up a Google Storage bucket: [Thomas Hegghammer's walkthrough](https://dair.info/articles/setting_up_google_storage.html).
* How to use daiR to process big file batches: [Erik Skare's example](/contents/htmls/using_dair.html).

### Data visualization 

* How to create a timeline with gg_vistime: [Jacob Høigilt's example](/contents/htmls/tidslinje.html). Can be used with this [.csv file](/contents/tidslinje.csv). Tutorial for the [gg_vistime package](https://shosaco.github.io/vistime/articles/gg_vistime-vignette.html).

## Python resources

### Installing and running Python and Anaconda

* How to install Python and Anaconda, create environments and install packages, and execute Python scripts: [Erik Skare's quick guide](/contents/htmls/python.html).

### Text preprocessing

We usually need to preprocess our text before analysis (removing [stopwords](https://kavita-ganesan.com/what-are-stop-words/#.Y9kqAq3MJaQ), [lemmatization](https://www.techtarget.com/searchenterpriseai/definition/lemmatization), and [tokenization](https://www.geeksforgeeks.org/nlp-how-tokenizing-text-sentence-words-works/)). Although R is one of our favourite tools for text mining and analysis, Python has several packages that are superior:

* Norwegian text preprocessing with SpaCy: [Erik Skare's example](/contents/htmls/spacy_language_processing.html).
* Arabic text preprocessing with Camel Tools: [Thomas Hegghammer's exmaple](https://gist.github.com/Hegghammer/f6b10677a03416642caae6426912eed9).
* Persian text preprocessing with Hazm: [Erik Skare's example](/contents/htmls/persian_nlp.html).
* Turkish text preprocessing with Zemberek and Zeyrek: [Erik Skare's example](/contents/htmls/turkish_nlp.html).
* Chinese text preprocessing with Jieba: [Erik Skare's example](/contents/htmls/chinese_nlp.html).
* Japanese text preprocessing with Janome: [Erik Skare's example](/contents/htmls/japanese_nlp.html).

## Markdown resources:

* Markdown with Zotero and Better Bibtex: [Jacob Høigilt's example](/contents/betterbibtex/markdown_zotero.html). 
* Writing markdown in Quarto: [Jacob Høigilt's markdown script](/contents/htmls/miniguide_quarto.html).
* Modifying VS Codium through its settings.json file: [Erik Skare's example](/contents/htmls/optimizing_vs_codium.html).

## A quick guide for High Performance Computing

High Performance Computing (HPC) is becoming increasingly important as we process, analyze, and perform complex calculations of increasing amounts of data. HPC uses clusters of powerful processors that work in parallel at extremely high speeds. The University of Oslo has its own HPC cluster called [Fox](https://www.uio.no/english/services/it/research/hpc/fox/index.html).

* How run Python and R scripts in Fox: [Erik Skare's quick guide](/contents/htmls/quick_guide_to_hpc_and_slurm.html).

