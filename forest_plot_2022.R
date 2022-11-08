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
xlab_text = "aHR (95% CI)" #Set x label
#Set range of x axis
xrange = seq(0.9, 1.2, by=0.05)

#Set fontsizes
fontsize_lab = 1.0 #label
fontsize_xlab = 1.2 #label of x axis
fontsize_ticks = 0.9 #ticks of x axis

#Set box size
boxsize = 0.1

#Set colors
boxcolor = "red"
textcolor = "black"
linecolor = "steelblue" #for the line of each sample
labelcolor = "darkgreen" #color of label text
axiscolor = "green"
colorlabel = "orange"
hrelcolor = "black"

#Generate forestplot
forestplot(tabletext,
           line.margin =0.0000001,
           cochrane_from_rmeta,
           new_page = TRUE,
           xlog=FALSE,
           boxsize=boxsize,
           col.lab=colorlabel,
           #is.summary=c(TRUE,TRUE,rep(FALSE,8),TRUE,rep(FALSE,7),TRUE,rep(FALSE,6),TRUE,rep(FALSE,5),TRUE,rep(FALSE,4),TRUE,rep(FALSE,3),TRUE,rep(FALSE,2)),
           is.summary = rep(FALSE, length(data$HR)), #Set which one is summary
           #xlog=TRUE,
           xlab=xlab_text,
           txt_gp = fpTxtGp(label =gpar(fontfamily = "Arial", cex=fontsize_lab,col=labelcolor),
                            xlab = gpar(fontfamily = "Arial", cex=fontsize_xlab,col=axiscolor),
                            ticks = gpar(fontfamily = "Arial", cex=fontsize_ticks)),
           col=fpColors(box=boxcolor,line=linecolor,text=textcolor),
           xticks = xrange,
           zero = 1,
           fn.ci_norm = fpDrawCircleCI, #Change the mark to circle
           ci.vertices = TRUE,
           ci.vertices.height = 0.1,
           hrzl_lines = list("2" = gpar( col = hrelcolor)))

