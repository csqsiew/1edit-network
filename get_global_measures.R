# function to generate global network measures from a network 
# measures for the entire network: number of nodes, number of edges, mean degree, network density 
# for largest connected component only: average shortest path length, global transitivity (clustering coefficient), assortativity by degree 
# supplementary measures: number of nodes in the LCC, number of island nodes, number of hermits, number of islands 

# requires:  
# library(igraph)

get_global_measures <- function(network) {
  
  if (igraph::is_igraph(network) == FALSE) {    # check if network is igraph object 
    stop("Input network is not of igraph class.") # if not, output an error message
  }
  
  # use entire network 
  nodes <- igraph::gorder(network)
  edges <- igraph::gsize(network)
  density <- igraph::edge_density(network)

  # giant component only
  lcc <- igraph::induced_subgraph(network, igraph::components(network)$membership == which.max(igraph::components(network)$csize)) 
  
  # ASPL, transitivity, assortativity by degree for LCC only 
  aspl <- igraph::mean_distance(lcc)
  trans <- igraph::transitivity(lcc, type = 'global')
  assort <- igraph::assortativity_degree(lcc, directed = FALSE)
  
  # number of giant component nodes
  giants <- igraph::gorder(lcc)
  
  # number of hermits 
  hermits <- which(igraph::degree(network) == 0) |> length()
    
  # number of lexical island nodes 
  islands <- igraph::gorder(network) - hermits - giants
  
  # number of islands
  island_num <- length(which(igraph::components(network)$csize > 1)) - 1
  
  # output
  return(data.frame(nodes = nodes,
                    edges = edges,
                    mean_degree = signif(mean(igraph::degree(network))),
                    density = signif(density, 4),
                    ASPL_LCC = signif(aspl, 4),
                    C_LCC = signif(trans, 4),
                    assortativity_k = signif(assort, 4),
                    giant_nodes = giants,
                    island_nodes = islands,
                    hermit_nodes = hermits,
                    island_num = island_num))
  }

# example 
# get_global_measures(pnet)
# get_global_measures(data_e)
