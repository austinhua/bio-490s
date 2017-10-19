library(ggplot2)
library(plyr)
library(datasets)
data(iris)

## Scatterplots (geom_point, geom_line)
ggplot(iris, aes(x = Sepal.Length, y = Petal.Length, col="red")) + geom_point() 

ggplot(iris, aes(x = Sepal.Length, y = Petal.Length, col=Species)) + geom_point()
ggplot(iris, aes(x = Sepal.Length, y = Petal.Length, col=Sepal.Width)) + geom_point()

### Exploring Different Geoms
## Boxplots (geom_boxplot)
ggplot(iris, aes(x=Species, y=Sepal.Length)) + geom_boxplot()

## Histograms (geom_histogram)
ggplot(iris, aes(x=Sepal.Length)) + geom_histogram()
ggplot(iris, aes(x=Sepal.Length, fill=as.factor(Species))) + geom_histogram()

## Plotting means for discrete factors (geom_barplot, geom_point)
v<-ddply(iris, c("Species"), summarise, N=length(Sepal.Length), mean=mean(Sepal.Length), sd=sd(Sepal.Length), se=sd/sqrt(N))
ggplot(v, aes(x=Species, y=mean)) + geom_point() + geom_errorbar(aes(ymin=mean-se, max=mean+se))

## Reaction norms (geom_line)
isoforms <- read.csv("isoforms.csv")
col <- isoforms[which(isoforms$gene=="col-107"),]
ggplot(col, aes(x=time, y=mean, col=isoform)) + geom_line() + geom_errorbar(aes(ymin=lo, ymax=hi))


### Additional Aesthetics -- added on (+)
## Change labels: [x/y]lab("title"), ggtitle("title")
## Change colors: scale_color_manual(values=c("color1", "color2", "color3", ...)) -- ex: scale_color_manual(values=c("aliceblue", "cadetblue", "darkslategrey"))
## Add lines (show a cutoff, or mean, or slope): geom_[v/h/ab]line() -- abline shows a line with a specified slope -- ex: geom_abline(aes(slope=.2, intercept=5))
## Themes: theme_"[theme]"

### Facets -- multiple plots
#ggplot(isoforms, aes(x=time, y=mean, col=isoform, shape=gene)) + geom_point() # illegibile!
ggplot(isoforms, aes(x=time, y=mean, col=isoform)) + geom_line() + facet_wrap(~gene, scale="free_y") + scale_y_log10()

### All together:
ggplot(isoforms, aes(x=time, y=mean, col=isoform)) + 
  geom_line() + 
  geom_point() + 
  geom_errorbar(aes(ymin=lo, ymax=hi)) + 
  facet_wrap(~gene, scale="free_y") + 
  scale_y_log10() + 
  ylab("mean isoform expression, +/- 95% CI") + 
  xlab("Time(hours)") + 
  scale_color_manual(values=c("dodgerblue","goldenrod","firebrick","mediumseagreen","lightcoral","darkorange","darkmagenta","aquamarine")) + 
  theme_bw()
  facet_wrap(~gene, scale="free_y") + scale_y_log10()