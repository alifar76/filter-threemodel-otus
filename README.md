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

There is 1 script in the folder ```src```. It is called ```nb_regression_outlier_filtering.R```. The script is run via command line using the Rscript command (in terminal). There are 3 scripts in the folder ```old_code``` but they can be ignored as they are just older versions, saved for trouble-shooting. There is also an additional Python script in the ```filtering```. It is called ```filter_mapper.py```. It is to be used to further results by lowest BIC of the 3 models tested and a user-defined q-value threshold.

To run the script, pass the command in following format:

```Rscript nb_regression_outlier_filtering.R high_vs_low_otu_table.txt high_low_mapfile.txt High Low Treatment ZINB_NB_Output_result.txt 2```

As seen from the command, the script takes in 7 commands. They are as follows:

1) OTU table generated via QIIME (which is called **high_vs_low_otu_table.txt** in the above example)

2) QIIME compatible mapping file (which is called **high_low_mapfile.txt** in the above example)

3) Level 1 of the category being compared (which is called **High** in the above example)

4) Level 2 of the category being compared (which is called **Low** in the above example)

5) Column name of the category being compared as labelled in the mapping file (which is called **Treatment** in the above example)

6) Output file contaiing result (which is called **ZINB_NB_Output_result.txt** in the above example)

7) No. of cores to use. More cores on machine, faster the analysis will complete (which is **2** in the above example)

Please ensure that all the 7 arguments are provided, in the correct order and format. Otherwise, the script will crash and cause problems.

Input file format
------

Input of file format should be one compatabile with QIIME. However, please ensure that the sample IDs are not numeric. That is, the sample IDs should not be like: 1560.1, 1561.1, 1559.1, etc. If such is the case, please slightly modify the sample IDs in both the mapping file and OTU table by adding any alphabet. So, for example, sample ID 1560.1 will become p1560.1.

Also, please make sure that the mapping file has the same number of samples as the OTU tables, having the same sample IDs. If mapping file has more or less sample IDs than the samples in the OTU table, the script will crash.

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
