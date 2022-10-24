library(tidyverse)
library(xcms)

fnames <- list.files("data/apples/","CDF", full.names = TRUE)
apples <- readMSData(fnames, mode = "onDisk") 



new_times <- adjustRtime(apples, param = ObiwarpParam(binSize = 0.6))

new_times %>% 
  as_tibble(rownames = "scan_id") %>% 
  separate(scan_id, into = c("file_id", "scan"), remove = FALSE) %>%
  left_join(apples %>% rtime() %>% as_tibble(rownames = "scan_id"), by = "scan_id") %>% 
  mutate(scan = as.numeric(substr(scan, start = 2, stop = nchar(scan)))) %>% 
  mutate(rtcorr = value.x - value.y) %>% 
  ggplot() + 
  geom_line(aes(x = value.x, y = rtcorr, col = file_id)) + 
  xlab("Retention Time (s)") + 
  theme_bw()
  
  

