# Setting up environment 
gc() # free up memory and report the memory usage
options(max.print = .Machine$integer.max, scipen = 999, stringsAsFactors = F, dplyr.summarise.inform = F) # avoid truncated output in R console and scientific notation

suppressPackageStartupMessages({
  library(Seurat)
  library(Rlabkey)
  library(UCell)
  library(ggrepel)
  library(tibble)
  library(writexl)
  library(enrichR)
  library(tidyverse)
  library(openintro)
  library(dplyr)
  library(readr)
  library(stringr)
  library(BiocManager)
  library(clusterProfiler)
  library(org.Hs.eg.db)
  library(DOSE)
  library(ggupset)
  library(ggplot2)
})

# =================================================

# IMPORT DATA AND FUNCTIONS

# Data manager
source("path to: data_manager_gh.R")
# Enrichment analysis
source("path to:pea_enrichr_gh.R")
# Enrichment analysis deep dive
source("path to: pea_investigate_gh.R")

# =================================================

# VARIABLES
p_value <- 0.005
# set output_path in pea_enrichr_gh.R

# =================================================

# CONDUCT PATHWAY ENRICHMENT ANALYSIS

baseline_plots <- conduct_pea(i_data=baseline_data, plot_timepoint="Baseline", output_p=output_path, pval=p_value)
w4_plots <- conduct_pea(i_data=w4_data, plot_timepoint="Week 4", output_p=output_path, pval=p_value)
w16_plots <- conduct_pea(i_data=w16_data, plot_timepoint="Week 16", output_p=output_path, pval=p_value)
w24_plots <- conduct_pea(i_data=w24_data, plot_timepoint="Week 24", output_p=output_path, pval=p_value)

# =================================================

# PEA INVESTIGATION

# WHICH PATHWAYS PER TIMEPOINT MEET THE P-VALUE
filt_baseline <- extract_top_pathways(baseline_plots, p_value)
filt_w4 <- extract_top_pathways(w4_plots, p_value)
filt_w16 <- extract_top_pathways(w16_plots, p_value)
filt_w24 <- extract_top_pathways(w24_plots, p_value)

# WHICH DEGs ARE ASSOCIATED WITH THESE PATHWAYS
head_pathway_genes(filt_baseline)
head_pathway_genes(filt_w4)
head_pathway_genes(filt_w16)
head_pathway_genes(filt_w24)


