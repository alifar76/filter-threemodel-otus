# libraries
pacman::p_load(magrittr,dplyr,tidyr,broom,rio,methods)

best_model_select <- function(infile,difference,oname){
	d.data <- import(infile) %>% 
	select(OTU_IDs,Poiss_qval,NB_qval,ZINB_qval,matches(difference),taxonomy,bic.pois,bic.nb,bic.zinb) %>%
	rowwise() %>% 
  mutate(`bic.pois`= ifelse(is.na(`bic.pois`),  1e10,`bic.pois`),
         `bic.nb`     = ifelse(is.na(`bic.nb`),       1e10,`bic.nb`),
         `bic.zinb`   = ifelse(is.na(`bic.zinb`),     1e10,`bic.zinb`)) %>% 
  mutate(min_b = min(`bic.pois`,`bic.nb`,`bic.zinb`,na.rm=T)) %>% 
  mutate(best_model=ifelse(min_b==`bic.pois`,'Poisson',
                        ifelse(min_b==`bic.nb`,'NB','ZINB'))) %>%
	mutate(best_model_qvalue = ifelse(best_model=="Poisson",`Poiss_qval` ,ifelse(best_model=="NB",`NB_qval` ,`ZINB_qval`)) ) %>% 
  ## Change q-value to 0.05
  filter(best_model_qvalue<0.05)
	d.data <- d.data %>% 
  	select(
    	OTU_IDs,
    	best_model,best_model_qvalue,matches(difference),taxonomy)
	export(d.data,oname)
}

# Rscript three_model_output.txt High_minus_Low_mean best_model_otus.csv
# Rscript infile difference oname

### Variables to change:
workdir <- "/Users/alifaruqi/Desktop/Programming/Github_Repos/filter-threemodel-otus/src"
infile <- 'three_model_output.txt'
difference <- 'High_minus_Low_mean'
oname <- 'best_model_otus.csv'


# Code runs here. DO NOT CHANGE!
setwd(workdir)
best_model_select(infile,difference,oname)