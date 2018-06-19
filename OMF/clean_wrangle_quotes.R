# From BM Employer Contribution Proposal with medical plans contribution set to 0%
# Combine plans with columns in this order: Name, Plan, Full_EE_Premium, Dependents, Total
# For spreadsheet titled: OMF_2018_rates.xls
numerics <- c('Full_EE_Premium1', 'Dependents1', 'Total1',
              'Full_EE_Premium2', 'Dependents2', 'Total2',
              'Full_EE_Premium3', 'Dependents3', 'Total3',
              'Full_EE_Premium4', 'Dependents4', 'Total4',
              'Full_EE_Premium5', 'Dependents5', 'Total5')
OMF_2018_rates_clean <- read_excel("OMF/OMF-2018-rates4.xls") %>%
  gather(Var, Val, Plan:Total) %>%
  group_by(Name, Var) %>%
  mutate(n = row_number()) %>%
  unite(VarT, Var, n, sep="") %>%
  spread(VarT, Val, fill=0) %>%
  select(Name, Plan1, Full_EE_Premium1, Dependents1, Total1,
                Plan2, Full_EE_Premium2, Dependents2, Total2,
                Plan3, Full_EE_Premium3, Dependents3, Total3,
                Plan4, Full_EE_Premium4, Dependents4, Total4,
                Plan5, Full_EE_Premium5, Dependents5, Total5)
OMF_2018_rates_clean[,numerics] <- lapply(OMF_2018_rates_clean[,numerics], as.numeric)
OMF_2018_rates_final <- mutate(OMF_2018_rates_clean, EE_Portion1 = as.numeric(format(round((Full_EE_Premium1 * 0.35), 2), nsmall = 2)),
                                 EE_Portion2 = as.numeric(format(round((Full_EE_Premium2 * 0.35), 2), nsmall = 2)),
                                 EE_Portion3 = as.numeric(format(round((Full_EE_Premium3 * 0.35), 2), nsmall = 2)),
                                 EE_Portion4 = as.numeric(format(round((Full_EE_Premium4 * 0.5), 2), nsmall = 2)),
                                 EE_Portion5 = as.numeric(format(round((Full_EE_Premium5 * 0.5), 2), nsmall = 2))) %>%
                          mutate(Employer_Portion1 = as.numeric(Full_EE_Premium1 - EE_Portion1),
                                 Employer_Portion2 = as.numeric(Full_EE_Premium2 - EE_Portion2),
                                 Employer_Portion3 = as.numeric(Full_EE_Premium3 - EE_Portion3),
                                 Employer_Portion4 = as.numeric(Full_EE_Premium4 - EE_Portion4),
                                 Employer_Portion5 = as.numeric(Full_EE_Premium5 - EE_Portion5)) %>%
                          mutate(Family_Portion1 = as.numeric(EE_Portion1 + Dependents1),
                                Family_Portion2 = as.numeric(EE_Portion2 + Dependents2),
                                Family_Portion3 = as.numeric(EE_Portion3 + Dependents3),
                                Family_Portion4 = as.numeric(EE_Portion4 + Dependents4),
                                Family_Portion5 = as.numeric(EE_Portion5 + Dependents5)) %>%
  select(Name, Plan1, Full_EE_Premium1, EE_Portion1, Employer_Portion1, Dependents1, Family_Portion1, Total1,
       Plan2, Full_EE_Premium2, EE_Portion2, Employer_Portion2, Dependents2, Family_Portion2, Total2,
       Plan3, Full_EE_Premium3, EE_Portion3, Employer_Portion3, Dependents3, Family_Portion3, Total3,
       Plan4, Full_EE_Premium4, EE_Portion4, Employer_Portion4, Dependents4, Family_Portion4, Total4,
       Plan5, Full_EE_Premium5, EE_Portion5, Employer_Portion5, Dependents5, Family_Portion5, Total5) %>%
  glimpse() %>%
  write_csv(path = "OMF/OMF_2018_rates_final.csv")
