# Getting and Cleaning Data: Course Project

## About Repository

This repository was created to satisfy the requirements for the Getting and Cleaning Data course project.
The purpose of this project is to demonstrate the ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis.

This repository contains the following files:
- `README.md` - Provides a quick summary of the repository contents.
- `CodeBook.md` - Describes the variables, the data, and transformations needed to produce tidy_data.csv.
- `run_analysis.R` - Consolidates data and performs transformations on the data.
- `tidy_data.csv` - The product output from `run_analysis.R` script.

## More on CodeBook.md

The codebook does contain some information found in the original source material, however, it is important to review the original source README.txt for complete context.

## More on run_analysis.R

The run_analysis.R script is setup to retrieve, extract and process the original data set. The user only needs to "source" the R file in an active R session to begin. The script will check for and attempt to install any required libraries needed. Currently, the only non-base library needed is reshape2. Upon completion the tidy_data.csv is created. If the script was started from inside the R console all variables and intermediate work products will still be available to the user (these are described in the codebook).

## More on tidy_data.csv

While tidy_data.csv has been committed to the repository, it will be generated each time the run_analysis.R script is executed (should result in the same content each time). 