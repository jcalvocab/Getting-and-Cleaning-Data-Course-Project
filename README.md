Introduction
===========

This repo contains project code for 'Getting and Cleaning Data' course given by John Hopkins university on Coursera.

The purpose of this project is to demonstrate the ability to *collect, work with, and clean a data set*. The goal is to prepare tidy data that can be used for later analysis. 

The data set
==============
The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available [at the site where the data was obtained](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

[Here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) are the data for the project in zip format.

Content of the repo
===============

* README.md: This file
* CodeBook.md:  A description of the variables, the data, and any transformations or work needed to clean up the data
* run_analysis.R: The R script that collect, work with, and clean the data sets.

Instrucctions to run the code
============================

* In R, set the working directory to the directory containing the 'run_analysis.R' script
* Manually donwload the data set to the working directory from [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
* Unzip the zip file
* In R, execute the following code:
        ```r
        source('run_analysis.R')
        run.analysis() 
        ```
* The result will be a new file named 'tidy_mean.txt' in the working directory containing the tidy data.

