# A function to read in our SEP data
read_SEP <- function(filepath){

    # Read in the data
    data <- read.csv(filepath, na.strings = c("N/A"))

    # This gets read in as numeric, instead of integer
    data$subgroup_value <- as.integer(data$subgroup_value)

    return(data)
}

# A function to present key columns and rename them
tbl_SEP <- function(data){

    cols <- c(
        Metric = "metric_description",
        Group = "primary_disagg_subgroup",
        DI = "primary_di_observed_y",
        Count = "subgroup_value",
        Overall = "subgroup_denom",
        Outcome = "subgroup_outcome_rate"
    )

    # Select specific columns and give them human readable names
    setNames(data[, cols], names(cols))

}
