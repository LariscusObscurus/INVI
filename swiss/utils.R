
midrange <- function(value) {
  (max(value) + min(value)) / 2;
}

medmed <- function(value) {
  median(abs(value - median(value)))
}

range <- function(value){
  max(value) - min(value)
}

coefficientOfVariance <- function(value){
  sd(value) / mean(value)
}

mode <- function(value){
  uniqv <- unique(value)
  uniqv[which.max(tabulate(match(value, uniqv)))]
}
