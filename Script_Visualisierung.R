##################################
## Visualisierung
## Grundlagen in R

x <- c(2,3,5)
is.numeric(x)
is.numeric(as.character(x))
y <- 4:9

x+y
x*y
exp(x)
sin(y)
#########################
# generische Funktionen
summary(x)
str(x)
matrix(y,nrow = 3)
?matrix
m<-matrix(y,nrow = 3,byrow=TRUE)
str(m)
m[1,]
m[,2]
################
print(m)
m
############
plot(x)

char<-c("r",3,5)
x
logic <- x<3
str(logic)
factor(c(char,5,3,"r",3))  #nominale Variable
factor(c(char,5,3,"r",3),ordered = TRUE)  # ordinal
factor(c(char,5,3,"r",3),ordered = TRUE,levels = c("r","5","3"))  # ordinal

#######################
# Liste

l1 <- list(name="ich",zahl=3,neu="hallo!",matrix=m)
str(l1)
str(l1[1])
str(l1[[1]]) 
l1$name

# Datenmatrix
df <- data.frame(cbind(c("W","M","M","M","W"),c(23,25,31,27,26)))
names(df) <- c("Geschlecht","Alter")
df
str(df)
as.numeric(levels(df[,2]))
as.numeric(df$Alter)
as.numeric(levels(df$Alter))
df[,2] <- as.numeric(levels(df[,2])[df[,2]])
str(df)

# Funktionen
lm
summary
summary.default
ls()
ls

m[1,2]
##########################################
## Titanic
Titanic
str(Titanic)
mosaicplot(Titanic, main = "Survival on the Titanic", color = TRUE)
ftable(Titanic)

mosaicplot(~ Sex + Age + Survived, data = Titanic, color = TRUE)

########################################
## dichte
x<-rnorm(1000)
hist(x)
par(mfrow=c(2,1))
hist(x,freq = F)
lines(density(x))
boxplot(x,horizontal = T)
par(mfrow=c(1,1))
qqnorm(x)
qqline(x,col=2)

x<-rgamma(1000,shape = 4,scale = 20)
hist(x)
par(mfrow=c(2,1))
hist(x,freq = F)
lines(density(x))
boxplot(x,horizontal = T)
par(mfrow=c(1,1))
qqnorm(x)
qqline(x,col=2)

x<-rt(1000,df=2)
hist(x)
par(mfrow=c(2,1))
hist(x,freq = F,breaks = 20,ylim=c(0,0.4))
lines(density(x))
boxplot(x,horizontal = T)
par(mfrow=c(1,1))
qqnorm(x)
qqline(x,col=2)

y<-c(x,rnorm(1000))
hist(y,freq=F)
lines(density(y))

#############################
## Transformationen 
x<-rnorm(250,mean=10,sd=1)
y<-x+rnorm(250)
plot(x,y)
abline(lm(y~x))
x2<-exp(x)
plot(x2,y)
plot(log(x2),y)
y2<-exp(y)
plot(x,y2)
plot(x,log(y2))
plot(x2,y2)
plot(log(x2),log(y2))

plot(x2,y2,log = "xy")

plot(DNase$conc~DNase$density)
plot(log(DNase$conc)~DNase$density)
plot(log(DNase$conc)~log(DNase$density))
lm1<-lm(log(DNase$conc)~log(DNase$density))
summary(lm1)
plot(lm1)


## put (absolute) correlations on the upper panels,
## with size proportional to the correlations.
panel.cor <- function(x, y, digits = 2, prefix = "", cex.cor, ...)
{
  usr <- par("usr"); on.exit(par(usr))
  par(usr = c(0, 1, 0, 1))
  r <- abs(cor(x, y))
  txt <- format(c(r, 0.123456789), digits = digits)[1]
  txt <- paste0(prefix, txt)
  if(missing(cex.cor)) cex.cor <- 0.8/strwidth(txt)
  text(0.5, 0.5, txt, cex = cex.cor * r)
}
pairs(iris[-c(5)], lower.panel = panel.smooth, upper.panel = panel.cor)

pairs(iris[-5], log = "xy", lower.panel = panel.smooth)
pairs(iris[-5], log = "x", lower.panel = panel.smooth)
