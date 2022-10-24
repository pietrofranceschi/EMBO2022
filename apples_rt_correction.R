library(tidyverse)
library(xcms)

fnames <- list.files("data/apples/","CDF", full.names = TRUE)
apples <- readMSData(fnames, mode = "onDisk") 