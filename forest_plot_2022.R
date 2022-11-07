# Forest plot
library(ggplot2)
#install.packages("plyr")
library(plyr)

#Import data
data<-read.csv("demo.csv")

#windowsFonts(Times=windowsFont("Arial"))
library(lattice)
#Remember to change device="windows" if you use windows
#getOption("device")
#trellis.device(device = "windows", height = 2500, width = 2000, color=TRUE)
library(forestplot)

#Setting forest plot
cochrane_from_rmeta <- 
  structure(list(
    mean = c(data$HR),
    lower = c(data$LOWER),
    upper = c(data$UPPER)),
    .Names = c("mean", "lower", "upper"), 
    row.names = c(NA, -(length(data$HR))), 
    class = "data.frame")

tabletext<-cbind(data$Group, data$VALUE)

#Setting parameters
xrange = seq(0.9, 1.2, by=0.05)
fontsize = 1.0
boxsize = 0.1


#Generate forestplot
forestplot(tabletext,
           line.margin =0.0000001,
           cochrane_from_rmeta,
           new_page = TRUE,
           xlog=FALSE,
           boxsize=boxsize,
           col.lab="grey29",
           #is.summary=c(TRUE,TRUE,rep(FALSE,8),TRUE,rep(FALSE,7),TRUE,rep(FALSE,6),TRUE,rep(FALSE,5),TRUE,rep(FALSE,4),TRUE,rep(FALSE,3),TRUE,rep(FALSE,2)),
           is.summary = rep(FALSE, length(data$HR)), #Set which one is summary
           #xlog=TRUE,
           xlab="aHR (95% CI)",
           txt_gp = fpTxtGp(label =gpar(fontfamily = "Arial", cex=fontsize,col=1),
                            xlab = gpar(fontfamily = "Arial", cex=fontsize,col=1),
                            ticks = gpar(fontfamily = "Arial", cex=fontsize)),
           col=fpColors(box="black",line="black",text="black"),
           xticks = xrange,
           zero = 1,
           fn.ci_norm = fpDrawCircleCI, #Change the mark to circle
           ci.vertices = TRUE,
           ci.vertices.height = 0.1,
           hrzl_lines = list("2" = gpar( col = "#000044")))
