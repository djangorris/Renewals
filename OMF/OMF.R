# From BM Employer Contribution Proposal with medical plans contribution set to 0%
# Combine plans with columns in this order: Name, Plan, Employee, Dependents, Total
# For spreadsheet titled: OMF_2018_rates.xls
install.packages("readxl")
install.packages("tidyverse")
library(readxl)
library(tidyverse)
OMF_2018_rates_clean <- read_excel("OMF-2018-rates.xls") %>% 
  gather(Var, Val, Plan:Total) %>% 
  group_by(Name, Var) %>% 
  mutate(n = row_number()) %>% 
  unite(VarT, Var, n, sep="") %>% 
  spread(VarT, Val, fill=0) %>% 
  select(Name, Plan1, Employee1, Dependents1, Total1, 
                Plan2, Employee2, Dependents2, Total2, 
                Plan3, Employee3, Dependents3, Total3, 
                Plan4, Employee4, Dependents4, Total4)