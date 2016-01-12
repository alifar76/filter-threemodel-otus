# filter-threemodel-otus

Background
------

This is a simple R script that parses the output of [NegBinSig-Test](https://github.com/alifar76/NegBinSig-Test) to select the best model on a per-OTU basis and give a more human readable output. The best model for a given OTU is selected via BIC and OTUs are reported having an FDR-corrected p-value of less than 0.05.

It was developed as a collaboration between researchers at UCSF and Rho World.

Required R packages
------

- [pacman 0.3.0](https://cran.r-project.org/web/packages/pacman/index.html)

All other packages will be loaded and/or installed by pacman.

Running the script
------

There is 1 script in the folder ```src```. It is called ```best_model_selection.R```. The script is run through R or Rstudio.

To run the script, open it in R or Rstudio and change the following 4 variables in it:

1) **workdir** (Line 28 of script): This refers to the working directory in which the script will reside and will be run from.

2) **infile** (Line 29 of script): This refers to the input file produced as the ouput of [NegBinSig-Test](https://github.com/alifar76/NegBinSig-Test). In the example provided, it is called **three_model_output.txt**.

3) **difference** (Line 30 of script): This is the header showing the mean difference in abundance of OTUs between two treatment groups as labelled in the ouput of [NegBinSig-Test](https://github.com/alifar76/NegBinSig-Test). In the example provided, it is called **High_minus_Low_mean**.

4) **oname** (Line 31 of script): This refers to the name of the final ouput file. In the example provided, it is called **best_model_otus.csv**.

Please ensure that all the 4 variable are adjusted, in the correct order and format. Otherwise, the script will crash and cause problems.

Output Explained
------

The output of the script contains information for all of the OTUs tested. Currently, there are 5 columns in the output file (called **best_model_otus.csv** in the example above) as generated via this script. The columns and their descriptions of the output file are as follows:

1) **OTU_IDs**: Indicates the OTU ID

2) **best_model**: Indicates the best model that fits the OTU (based on the lowest BIC value)

3) **best_model_qvalue**: q-value of the OTU selected

4) **High_minus_Low_mean**: Indicates the mean difference between the two treatment groups

5) **taxonomy**: Shows the taxonomic classification of the OTU
