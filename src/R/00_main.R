#!/usr/bin/Rscript
# Purpose:         Analyse BFS Statistics
# Date:            2014-11-23
# Author:          Tim Hagmann
# Notes:
# R Version:       R version 3.1.2 -- "Pumpkin Helmet"
################################################################################

## Download init File
# download.file(url="https://rawgit.com/greenore/initR/master/init.R",
#               destfile="src/R/01_initialize.R",
#               method=ifelse(Sys.info()["sysname"][[1]] == "Linux", "wget", "auto"))

## Source Files
update_packages <- FALSE
source("src/R/01_initialize.R")
source("src/R/02_load.R")
source("src/R/03_data.R")
source("src/R/04_analysis.R")

