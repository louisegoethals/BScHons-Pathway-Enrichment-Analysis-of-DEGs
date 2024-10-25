# BScHons-Pathway-Enrichment-Analysis-of-DEGs

Four scripts are included: main_script_gh, data_manager_gh, pea_enrichr_gh, pea_investigate_gh.
At the time of submission, the data used in this pipeline was not yet published. It is thus not included.

##MAIN SCRIPT:
Analysis is conducted from this script. 

##DATA MANAGER:
Data for analysis is imported into the workspace from this script. Format: csv files.

##PEA ENRICHR:
Pathway enrichment analysis function. Two plots are outputted for a particular timepoint: upregulated pathways and downregulated pathways.
Set databases for analysis here. Set the output path (where plots are saved).

##PEA INVESTIGATE:
After conducting pathway enrichment analysis, extract the eligible pathways (those that meet the p-value). Then extract the DEGs associated with those pathways.
