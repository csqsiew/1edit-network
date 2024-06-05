### UNDER CONSTRUCTION ###

load('data/sample_list_20240605.RData') # sample data for demonstration, see data/ for more details 

# load functions
source('helper-functions.R')
source('make_network.R')

# fake frequency values 
sample_list$frequency <- sample(1:7, size = nrow(sample_list), replace = T)

pnet <- make_network(data = sample_list, col = ipa) # we will select the column containing the IPA transcriptions

summary(pnet)

neighbors(pnet, 2)
V(pnet)$frequency[neighbors(pnet, '2')]
V(pnet)$frequency[neighbors(pnet, '2')] |> mean()

# get the mean node attribute of the neighbors of all nodes (c.f. neighborhood frequency)
out <- sapply(1:gorder(pnet), function(i) V(pnet)$frequency[neighbors(pnet, i)] |> mean())
