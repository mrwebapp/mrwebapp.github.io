#!/usr/bin/Rscript
# Purpose:         Analyse data
# Date:            2014-10-30
# Author:          tim.hagmann@baloise.ch
# Notes:           In order for it to work on Windows, RTools() has to be installed
# R Version:       R version 3.1.1 -- "Sock it to Me"
################################################################################

## Download init File
# download.file(url="https://rawgit.com/greenore/initR/master/init.R",
#               destfile="src/analysis/01_initialize.R",
#               method=ifelse(Sys.info()["sysname"][[1]] == "Linux", "wget", "auto"))

## Source Files
update_packages <- FALSE
source("src/analysis/01_initialize.R")
source("src/analysis/02_load.R")
source("src/analysis/03_data.R")

packagesGithub(c("visualizeR"), repo_name="greenore",
               proxy_url="webproxy.balgroupit.com", port=3128,
               auth_token="af8bd0071e5aef71efd5aded3aee60ec68f8a41f",
               update=T)

packagesGithub(c("beeplotR"), repo_name="greenore",
               proxy_url="webproxy.balgroupit.com", port=3128,
               auth_token="af8bd0071e5aef71efd5aded3aee60ec68f8a41f",
               update=T)
