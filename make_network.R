# function to create network from a list of words

# library(igraph)
# library(stringdist)
# library(dplyr)
# 
# source('helper-functions.R')
# 
# load('data/sample_list_20240605.RData')

make_network <- function(data, col) {

  # the column containing the information used for segmentation (e.g., phonological transcriptions or spellings)
  col <- dplyr::enquo(col)
  
  # use this list for neighbor generation 
  wordlist <- data |> dplyr::select(!!col) |> unlist(use.names = FALSE)
  
  data_e <- data.frame() # create an empty data frame to store edges

  for(x in 1:length(wordlist)) { # for all words in the list
  
    y<-unlist(levenshtein.neighbors.number(wordlist[x],wordlist)[1]) # list of 1-hop neighbors of word x
  
    if (length(y) > 0) {              # if the word has at least one neighbor
      a <- as.data.frame(cbind(x, y)) # generate edges: word x-neighbor 1, word x-neighbor 2, and so on...
      data_e <- rbind(data_e, a)      # add edge to data frame
      }
 
    }

  # create network 
  network <- igraph::graph_from_data_frame(data_e, directed = F, vertices = data)
  
  return(igraph::simplify(network))
    
}

# example 
# pnet <- make_network(data = sample_list, col = ipa)
# summary(pnet)
# 
# # plot - example 
# p1 <- make_ego_graph(pnet, nodes = '1')[[1]] 
# plot(p1, vertex.label = V(p1)$word)
# plot(p1, vertex.label = V(p1)$ipa)
