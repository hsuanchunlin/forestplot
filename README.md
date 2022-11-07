## Source code to plot a Forest Plot

1.  Import necessary packages

<!-- -->

    ## Loading required package: grid

    ## Loading required package: magrittr

    ## Loading required package: checkmate

1.  Import data

<!-- -->

    data<-read.csv("demo.csv")
    print(data)

    ##   Group              VALUE    HR LOWER UPPER X X.1 X.2
    ## 1 Group        HR (95% CI)    NA    NA    NA          
    ## 2     5          Reference 1.000 1.000 1.000          
    ## 3     1  1.033(1.01-1.056) 1.033 1.010 1.056 (   )   -
    ## 4     2 1.078(1.032-1.127) 1.078 1.032 1.127 (   )   -
    ## 5     3 1.052(1.017-1.087) 1.052 1.017 1.087 (   )   -
    ## 6     4  0.978(0.94-1.018) 0.978 0.940 1.018 (   )   -

1.  Assign values from specific columns for your forest plot

<!-- -->

    cochrane_from_rmeta <- 
      structure(list(
        mean = c(data$HR),
        lower = c(data$LOWER),
        upper = c(data$UPPER)),
        .Names = c("mean", "lower", "upper"), 
        row.names = c(NA, -(length(data$HR))), 
        class = "data.frame")

    tabletext<-cbind(data$Group, data$VALUE)

1.  Set the format parameters

-   xrange(a, b, by = c) : here a is the lower limit, b is the upper
    limit, and c is the interval of of x axis.
-   fontsize: set the size of the fonts in the plot.
-   boxsize: set the circle size which indecates the mean value of the
    plot.

<!-- -->

    #Setting parameters
    xrange = seq(0.9, 1.2, by=0.05)
    fontsize = 1.0
    boxsize = 0.1

1.  Visualization

<!-- -->

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

![](README_files/figure-markdown_strict/unnamed-chunk-5-1.png)
