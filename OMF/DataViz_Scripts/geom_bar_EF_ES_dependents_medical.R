
# OMF_rates_3 <- read_csv('OMF/OMF_2018_rates_final-2.csv')

selected_employee <- "John Doe"
clean_selected_employee <- str_replace_all(selected_employee, " ", "_")
OMF_rates_3$Plan <- str_replace(OMF_rates_3$Plan, "Anthem Bronze PPO 6650/0%/6650 HSA", "Anthem Bronze PPO 6650/0% HSA")
EF_PLANS <- OMF_rates_3 %>%
  group_by(Name) %>%
  filter(Name == selected_employee) %>%
  rename("Employee" = EE_Portion,
         "Spouse & Children" = Dependents,
         "Total Family" = Family_Portion) %>%
  gather(Rating, Value, -Plan, -Name, -Full_EE_Premium, -Employer_Portion, -Total, -Carrier)
# plot
cols <- c("Employee" = "forestgreen",
          "Spouse & Children" = "khaki3",
          "Total Family" = "firebrick")
ggplot(EF_PLANS, aes(x = Plan, y = Value, fill = Rating)) +
  geom_bar(position="dodge", stat="identity") +
  geom_text(aes(label= paste0("$", format(Value, trim=TRUE))), position = position_dodge(0.9), vjust = -0.5) +
  xlab(" ") +
  ylab("Employee Portion of Premium") +
  ggtitle(str_c("2018 Medical Plan Options for ", selected_employee)) +
  scale_fill_manual(values = cols) +
  scale_y_continuous(labels = dollar) +
  # labs(caption = "  Graphic by Colorado Health Insurance Insider / @lukkyjay                                                                                                                                                           Source: SERFF") +
  theme(plot.margin = margin(5, 5, 5, 5),
        plot.title = element_text(family = "Trebuchet MS", color="#666666", face="bold", size=18, hjust=0),
        # legend.position = "none",
        plot.caption = element_text(family = "Arial", size = 10, color = "grey", hjust = 0.5)) +
  ggsave(filename = paste0("OMF/Charts/Medical/", clean_selected_employee, ".png"),
         width = 12, height = 8, dpi = 1200)
