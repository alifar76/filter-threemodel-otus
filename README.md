# filter-threemodel-otus

Background
------

This is a simple R script that parses the output of [NegBinSig-Test](https://github.com/alifar76/NegBinSig-Test) to select the best model on a per-OTU basis and give a more human readable output.

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

The output of the script contains information for all of the OTUs tested. Currently, there are 51 columns in the output file (called **ZINB_NB_Output_result.txt** in the example above) as generated via this script. The columns and their descriptions of the output file are as follows:

1) **OTU_ID**: Indicates the OTU ID

2) **Poiss_Coeff**: Indicates the expoentiated regression coefficient estimated when fitting the Poisson model on the OTU count data. This value is the is the multiplicative change in OTU abundance, comparing one level of a specific treatment group to another. It is to be interpreted in a similar way to the NB_Coeff value, which is explained further.

3) **Poiss_pval**: p-value of estimated Poisson Coeff

4) **Poiss_qval**: q-value of the estimated Poisson Coeff

5) **NB_Coeff**: Indicates the exponentiated regression coefficient for the regular negative binomial model. To elaborate more,
in our example dataset, OTU_26 has a NB_Coeff value of 1.329890281. This means that the abundance of OTU_26 is 1.329890281 times higher in the Low group of treatment compared to the High group of treatment. To find out which group is the base group, we look at the column called **High_minus_Low_mean** for our example dataset. (The name of this group will change from mapping file to mapping file as explained later in detail) In our example dataset, the **High_minus_Low_mean** column has the value of -176.8338789. This suggests that the mean OTU_26 is higher in Low group when compared to High group.

6) **NB_pval**: p-value of the estimated NB_Coeff
