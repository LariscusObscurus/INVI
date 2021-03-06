
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

#Magic from the CIS code
panel.cor <- function(x,
                      y,
                      digits = 2,
                      prefix = "",
                      cex.cor,
                      ...)
{
  usr <- par("usr")
  on.exit(par(usr))
  par(usr = c(0, 1, 0, 1))
  r <- abs(cor(x, y))
  txt <- format(c(r, 0.123456789), digits = digits)[1]
  txt <- paste0(prefix, txt)
  if (missing(cex.cor))
    cex.cor <- 0.8 / strwidth(txt)
  text(0.5, 0.5, txt, cex = cex.cor * r)
}

surroundWhitespace <- function(value) {
  if (grepl(".*\\s.*", value)) {
    sprintf("`%s`", value)
  } else{
    value
  }
}
