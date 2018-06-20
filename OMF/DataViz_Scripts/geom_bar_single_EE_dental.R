
# OMF_rates_3 <- read_csv('OMF/OMF_2018_rates_final-2.csv')

selected_employee <- "Tony Shawcross"
clean_selected_employee <- str_replace_all(selected_employee, " ", "_")
PLANS <- OMF_rates_3 %>%
  group_by(Name) %>%
  filter(Name == selected_employee)
# plot
cols <- c("Anthem" = "blue",
          "Kaiser" = "deepskyblue2")
ggplot(PLANS, aes(x = Plan, y = EE_Portion, fill = Carrier)) +
  geom_bar(position="dodge", stat="identity") +
  geom_text(aes(label= paste0("$", format(EE_Portion, trim=TRUE))), vjust = -0.5) +
  xlab(" ") +
  ylab("Employee Portion of Premium") +
  ggtitle(str_c("2018 Dental Plan Options for ", selected_employee)) +
  scale_fill_manual(values = cols) +
  # labs(caption = "  Graphic by Colorado Health Insurance Insider / @lukkyjay                                                                                                                                                           Source: SERFF") +
  theme(plot.margin = margin(5, 5, 5, 5),
        plot.title = element_text(family = "Trebuchet MS", color="#666666", face="bold", size=18, hjust=0),
        legend.position = "none",
        plot.caption = element_text(family = "Arial", size = 10, color = "grey", hjust = 0.5)) +
  ggsave(filename = paste0("OMF/Charts/Dental/", clean_selected_employee, ".png"),
         width = 12, height = 8, dpi = 1200)
