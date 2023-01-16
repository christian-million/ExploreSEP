# Filters SEP data by metric and disagg group
#
# Values for metric: 300, 453, 501, 619, 620
filter_SEP <- function(data, metric = 300, disagg = "Ethnicity"){

    subset(data, metric_id == metric & primary_disagg == disagg & gender_disagg_subgroup == 'Overall')

}

# Identifies unique list of metrics from data
metric_list <- function(data){

    x <- unique(data[, c("metric_id", "metric_description")])

    split(x$metric_id, x$metric_description)

}

# Identifies unique list of groups from data
group_list <- function(data){

    x <- unique(data$primary_disagg)

    out <- as.list(x)

    names(out) <- x

    out

}

