# Plots our SEP data
# Read in with read_SEP
# Filter with filter_SEP
plot_ppg1 <- function(data){

    disagg   <- unique(data$primary_disagg)[1]
    metric   <- unique(data$metric_description)[1]
    subtitle <- paste("Disproportionate Impact by", disagg, "for", unique(data$academic_year))
    data$text_pos <- ifelse(data$subgroup_outcome_rate == 0, max(data$subgroup_outcome_rate)/10, data$subgroup_outcome_rate)

    ggplot(data, aes(x = primary_disagg_subgroup, y = subgroup_outcome_rate, fill = primary_di_observed_y)) +
        geom_bar(stat = "identity") +
        geom_text(aes(y = text_pos, label = lbl_help(subgroup_outcome_rate, subgroup_denom))) +
        scale_y_continuous(labels = scales::percent, expand = expansion(mult = c(0, .05))) +
        scale_fill_manual(values = c("Y" = "#F4831B", "N" = "#BEBEBE")) +
        scale_x_discrete(labels = function(x) stringr::str_wrap(x, width = 10)) +
        labs(fill = "DI",
             x = NULL,
             y = NULL,
             title = metric,
             subtitle = subtitle) +
        theme_SEP()

}

lbl_help <- function(perc, n){

    lbl_perc <- paste0(round(perc, 3) * 100, "%")
    lbl_n <- paste0("(n=", n, ")")
    paste0(lbl_perc, "\n", lbl_n)

}

theme_SEP <- function(){

    theme_bw() %+replace%
        theme(
            plot.title = element_text(face = "bold", hjust = 0),
            legend.position = c(.9, 1.05),
            legend.direction = "horizontal",
            panel.grid.major.x = element_blank()
        )

}



