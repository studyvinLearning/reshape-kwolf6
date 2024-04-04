
# Use data(federalistPapers, package='syllogi') to get the federalist paper data

# Create a data frame that paper number, author, journal, date
# Determine the day of the week that each paper was published.
# Get the count of papers by day of the week and author
# create a new data frame that has authors as column names and dates of publication as the values


data(federalistPapers, package='syllogi')

papers<-federalistPapers

number <- unlist(lapply(papers, function(paper) paper$meta$number))
author <- unlist(lapply(papers, function(paper) paper$meta$author))
journal <- unlist(lapply(papers, function(paper) paper$meta$journal))
date <- sapply(federalistPapers, function(paper) paper$meta$date)
date <- as.Date(dates)
paper <- unlist(lapply(papers, function(paper) paper$paper))

# Create a data frame that paper number, author, journal, date
papers_df <- data.frame(
  number = number,
  author = author,
  journal = journal,
  date = date,
  paper = paper,
  stringsAsFactors = FALSE
)

# Determine the day of the week that each paper was published.
weekdays(papers_df$date)


# Get the count of papers by day of the week and author
aggregate(paper ~ weekdays(papers_df$date)+author, data = papers_df, FUN = function(x) length((x)))


# create a new data frame that has authors as column names and dates of publication as the values
tidyr::pivot_wider(papers_df,
                   names_from='author', 
                   values_from='date')