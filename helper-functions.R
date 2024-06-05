# helper functions to generate indexed list of neighbors based on 1-edit distance

# required packages
# library(stringdist) 

levenshtein.distance.number <- function (xsource, targets)
{
  distances <- stringdist::stringdist(xsource, targets, method = "lv")
  names(distances) <- 1:length(targets) # orginal code from vwr library: names(distances) <- targets
  return(distances)
}

levenshtein.neighbors.number <- function (xsource, targets)
{
  results <- list()
  distances <- levenshtein.distance.number(xsource, targets)
  for (distance in min(distances):max(distances)) {
    results[distance] = list(names(which(distances == distance)))
  }
  return(results)
}
