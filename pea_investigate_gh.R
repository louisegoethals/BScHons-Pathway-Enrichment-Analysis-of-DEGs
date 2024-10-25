
# DESCRIPTION

# extract eligible pathways from PEA and the DEGs associated with them

# =================================================

## METHOD: EXTRACT ELIGIBLE PATHWAYS THAT MEET THE P-VALUE THRESHOLD

extract_top_pathways <- function(i_list, p_value_threshold) {
  # Initialize a list to hold the filtered data frames
  filtered_dfs <- list()
  
  # Loop over each data frame in the input list
  for (i in seq_along(i_list)) {
    df <- i_list[[i]]
    # Filter the results based on the input p-value threshold
    filtered_res <- df$data %>% 
      filter(P.value <= p_value_threshold) %>% 
      arrange(P.value)
    
    # Print the pathways
    df_name <- names(i_list)[i]  # Get the name of the current data frame
    print(paste("PATHWAYS IN", df_name, ":"))
    print(filtered_res$Term)
    
    # Append the filtered result to the list
    filtered_dfs[[i]] <- filtered_res
  }
  
  # Return the list of filtered data frames
  return(filtered_dfs)
}

# =================================================

## METHOD: DISPLAY DEGs ASSOCIATED WITH ELIGIBLE PATHWAYS

# Input filtered (eligible) pathways 

head_pathway_genes <- function(filtered_dfs) {
  # Loop over each filtered data frame in filtered_dfs
  for (i in seq_along(filtered_dfs)) {
    filtered_res <- filtered_dfs[[i]]
    
    # Iterate through each pathway in the filtered data frame
    for (pathway in filtered_res$Term) {
      # Filter the dataframe for the specific pathway
      pathway_genes <- filtered_res[filtered_res$Term == pathway, "Genes"]
      
      # Split the gene names and combine them into a string
      genes <- paste(unlist(strsplit(as.character(pathway_genes), ";")), collapse = ", ")
      
      # Print the gene list for the pathway
      cat(pathway, ":\n", genes, "\n\n")
    }
  }
}
