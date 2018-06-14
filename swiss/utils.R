
midrange <- function(value) {
  (max(value) + min(value)) / 2;
}

medmed <- function(value) {
  median(abs(value - median(value)))
}

range <- function(value){
  max(value) - min(value)
}
