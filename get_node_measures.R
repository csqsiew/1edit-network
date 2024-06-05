# function to generate node level measures from a network 
# measures for the entire network: degree, local C, location 
# for largest connected component nodes only: closeness, betweenness, eigenvector, pagerank  

# requires:  
# library(igraph)

get_node_measures <- function(network) {
  
  if (igraph::is_igraph(network) == FALSE) {    # check if network is igraph object 
    stop("Input network is not of igraph class.") # if not, output an error message
  }
 
  # extract all existing node attributes in network as dataframe 
  node_attr <- igraph::vertex_attr(network) |> as.data.frame()
  
  # node location 
  location <- rep('L', igraph::gorder(network))

  location[which(igraph::degree(network) == 0)] <- 'H'

  location[igraph::components(network)$membership == which.max(igraph::components(network)$csize)] <- 'G'
  
  # node measures 
  node_measures <- data.frame(
                   location = location,
                    degree = igraph::degree(network),
                    local_C = igraph::transitivity(network, type = 'local', isolates = 'zero')
                    )
  
  #output
  return(cbind(node_attr, node_measures))
  
}

# example 
# get_node_measures(pnet) |> tail()
# get_node_measures(data_e)
