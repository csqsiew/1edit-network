# script to make a sample word list from Alderete's SUBTLEX-US adjacency lists 

library(tidyverse)

ipa <- read.delim('IPA1024.adjlist', header = F)

ipa_first <- gsub(" .*", "", ipa$V1) # get first word only 

word <- read.delim('words1024.adjlist', header = F)

word_first <- gsub(" .*", "", word$V1) # get first word only 

sample_list <- data.frame(index = 1:length(ipa_first),
                          ipa = ipa_first,
                          word = word_first)

save(sample_list, file = 'sample_list_20240605.RData')

write.csv(sample_list, file = 'sample_list_20240605.csv', row.names = FALSE)
