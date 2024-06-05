# readme for pnet-package-v1

This is a development space for a future R package that produces a network of items based on the 1-edit distance rule (substitution, addition, or deletion of 1 segment). 

Basic global network measures and node-level measures are also provided. Please see the "Usage" section for a simple working example.

Rationale: There is growing interest among psycholinguists to construct networks of words based on phonological similarity (e.g., Vitevitch, 2008). Words are considered to be phonological neighbors if they differ based on substitution, addition, or deletion of 1 phoneme in any position (Luce & Pisoni, 1998). However, there are no readily available tools for researchers to construct their own networks, and the lexicon used in most studies of language network science have relied on the phonological network based on the Hoosier Mental Lexicon (e.g., Siew & Vitevitch, 2019; Vitevitch et al., 2012), which is unfortunately not openly available. Creating these functions will enable researchers to create phonological (or orthographic) similarity networks from their own word lists or dictionaries, and for other languages beyond English. Note that phonological similarity networks will require phonological transcriptions, whereas for orthographic similarity the spellings can be directly used. 

README last updated 5th June 2024.

If you have any questions or comments, please feel free to email `cynthia@nus.edu.sg` or leave a note in the "Issues" tab.

## Usage 

Required packages: `igraph`, `stringdist`, 'dplyr'. Please install these first via: `install.packages(c('igraph', 'stringdist', 'dplyr'))`

Then, download the entire repository.

1. Set up 

``` 
load('data/sample_list_20240605.RData') # sample data for demonstration, see data/ for more details 

# load functions
source('helper-functions.R')
source('make_network.R')
source('get_global_measures.R')
source('get_network_measures.R')
source('get_lcc.R')
```

Note: There is a bug where you need to manually source the `get_global_measures.R` file to get the function to run as expected.

2. Create a network 

```
pnet <- make_network(data = sample_list, col = ipa) # we will select the column containing the IPA transcriptions
```

3. Get global measures of the network 

```
get_global_measures(pnet)
```

4. Get node-level measures 

```
get_node_measures(pnet) |> head()
```

## Future plans

- Inclusion of additional node-level measures: closeness centrality, betweenness centrality, eigenvector centrality, Page Rank
- The current segmentation strategy assumes each character = 1 segment; future version enables the user to designate the segments by a separator (e.g.,hap|pi|est). This enables a greater variety of networks to be created based on syllables, morphology, word co-occurrences, etc.
- Computation of neighborhood statistics based on node-level attributes, e.g., average neighborhood frequency (mean of the frequency of the neighbors of the target node)
- Compile these functions into a R package, write documentation, further testing 

### References 

Luce, P. A., & Pisoni, D. B. (1998). Recognizing spoken words: The Neighborhood Activation Model. *Ear and Hearing, 19*(1), 1–36.

Siew, C. S. Q., & Vitevitch, M. S. (2019). The phonographic language network: Using network science to investigate the phonological and orthographic similarity structure of language. *Journal of Experimental Psychology: General, 148*(3), 475–500. https://doi.org/10.1037/xge0000575

Vitevitch, M. S. (2008). What can graph theory tell us about word learning and lexical retrieval? *Journal of Speech, Language, and Hearing Research, 51*(2), 408–422. https://doi.org/10.1044/1092-4388(2008/030)

Vitevitch, M. S., Chan, K. Y., & Roodenrys, S. (2012). Complex network structure influences processing in long-term and short-term memory. *Journal of Memory and Language, 67*(1), 30–44. https://doi.org/10.1016/j.jml.2012.02.008

