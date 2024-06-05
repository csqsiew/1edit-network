# function to generate the largest connected component of a network 

# requires:  
# library(igraph)

get_global_measures <- function(network) {
  
  if (igraph::is_igraph(network) == FALSE) {    # check if network is igraph object 
    stop("Input network is not of igraph class.") # if not, output an error message
  }
  
  if (igraph::components(network)$no == 1) {
    stop("Input network is a single connected component.") # if network is fully connected, do not proceed
  } else {
    lcc <- igraph::induced_subgraph(network, igraph::components(network)$membership == which.max(igraph::components(network)$csize)) 
  }
  
  return(lcc)
}

# example 
# pnet_lcc <- get_global_measures(pnet)
# summary(pnet_lcc)
# 
# get_global_measures(pnet_lcc)
# get_global_measures(data_e)
