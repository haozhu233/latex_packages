library(httr)
library(xml2)
library(tidyverse)

pkg_names <- NULL

for(i in LETTERS){
  url <- paste0("https://www.ctan.org/pkg/:", i)
  loop_pkg_names <- GET(url) %>%
    content() %>%
    xml_find_all("//*[contains(@class, 'dt')]/a") %>%
    xml_contents() %>%
    as.character()
  pkg_names <- c(pkg_names, loop_pkg_names)
}
pkg_names <- data.frame(pkg_names = pkg_names)

write_csv(pkg_names, "latex_packages.csv")
write_file(as.character(Sys.time()), "update_time.txt")
