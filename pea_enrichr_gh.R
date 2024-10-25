
# DESCRIPTION

# Function for conducting pathway enrichment analysis (PEA)

# =================================================

# SETUP 

knitr::opts_chunk$set(echo = TRUE)
output_path <- 'path to: save plots'
setwd(output_path)

setEnrichrSite("Enrichr") 
dbs <- listEnrichrDbs()

# DATABASES
dbs_go <- c("GO_Biological_Process_2021")
dbs_pathway <- c("MSigDB_Hallmark_2020", "BioCarta_2016", "Reactome_2022", "DSigDB", "WikiPathways_2019_Human", "KEGG_2021_Human", "DisGeNET", "WikiPathway_2021_Human", "HDSigDB_Human_2021")

# =================================================

# FUNCTION: CONDUCT PATHWAY ENRICHMENT ANALYSIS

# ARGUMENTS
  # i_data: data for a specific timepoint (df)
  # plot_timepoint: string naming that timepoint, e.g. "Baseline"
  # output_p: path to save plot

conduct_pea <- function(i_data, plot_timepoint, output_p, pval){
  de_df <- i_data 
  
  genes_up <- de_df[
    de_df$logFC >=0.5 & de_df$PValue < pval,"genes"]
  
  genes_down <- de_df[
    de_df$logFC <=-0.5 & de_df$PValue < pval,"genes"]
  
  enriched_go <- enrichr(c(genes_up), dbs_go)
  enriched_pathway <- enrichr(c(genes_up), dbs_pathway)
  
  # UPREGULATED GENES
  up_title <- paste0("Pathways Upregulated at ", plot_timepoint)
  
  up_plot <- plotEnrich(enriched_go[[1]], showTerms = 20, numChar = 70, y = "Count", orderBy = "P.value") + 
    theme(axis.text.y = element_text(size = 12),
          axis.title.y = element_text(size = 20),
          axis.text.x = element_text(size = 20),
          axis.title.x = element_text(size = 20),
          plot.title = element_text(size = 24, hjust = 0.5)) + 
    ggtitle(up_title)
  # Save up-plot
  plot_name <- paste0(gsub(" ", "_", up_title), ".png")
  save_location <- file.path(output_p, plot_name)
  ggsave(filename = save_location, plot = up_plot, width = 15, height = 10, dpi = 300)
  
  # DOWNREGULATED GENES
  down_title <- paste0("Pathways Downregulated at ", plot_timepoint)
  
  enriched_go <- enrichr(c(genes_down), dbs_go)
  enriched_pathway <- enrichr(c(genes_down), dbs_pathway)
  down_plot <- plotEnrich(enriched_go[[1]], showTerms = 20, numChar = 70, y = "Count", orderBy = "P.value") + 
    theme(axis.text.y = element_text(size = 12),
          axis.title.y = element_text(size = 20),
          axis.text.x = element_text(size = 20),
          axis.title.x = element_text(size = 20),
          plot.title = element_text(size = 24, hjust = 0.5)) + 
    ggtitle(down_title)
  # Save down-plot
  plot_name <- paste0(gsub(" ", "_", down_title), ".png")
  save_location <- file.path(output_p, plot_name)
  ggsave(filename = save_location, plot = down_plot, width = 15, height = 10, dpi = 300)

  return(list(up_plot=up_plot, down_plot=down_plot))
}
