
OMF_rates <- read_csv('OMF/OMF_2018_rates_final-2.csv')

selected_employee <- "Ann Theis"
clean_selected_employee <- str_replace_all(selected_employee, " ", "_")
PLANS <- OMF_rates %>%
  group_by(Name) %>%
  filter(Name == selected_employee)
# plot
ggplot(PLANS, aes(x = Plan, y = EE_Portion)) +
  geom_bar(position="dodge", stat="identity") +
  # geom_text(aes(label= format(count, big.mark=",", trim=TRUE)), vjust = -0.5) +
  # xlab(" ") +
  # ylab(NULL) +
  ggtitle(str_c("2018 Medical Plan Options for ", selected_employee)) +
  # scale_fill_manual(values = cols) +
  # labs(caption = "  Graphic by Colorado Health Insurance Insider / @lukkyjay                                                                                                                                                           Source: SERFF") +
  theme(plot.margin = margin(5, 5, 5, 5),
        plot.title = element_text(family = "Trebuchet MS", color="#666666", face="bold", size=18, hjust=0),
        legend.position = "none",
        plot.caption = element_text(family = "Arial", size = 10, color = "grey", hjust = 0.5)) +
  ggsave(filename = "OMF/Ann_Theis.png", width = 12, height = 8, dpi = 1200)
