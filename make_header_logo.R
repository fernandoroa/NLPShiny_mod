{
  png(file="www/logoNLP.png",width=520, height=125, units = "px")  
  {
    par(family="Aller_Rg", mar=rep(0,4) )
    
    plot(c(3, 15), c(1.5, 3.5),  type = "n", axes = FALSE
         , xlab = "", ylab = "",yaxs="i", xaxs="i", asp=1)
    
    text(5,4-.8,"NLP",cex=4, font=2)
    text(5,2.5-.8,"tag",cex=4, font=2)
    
    
    {
      x1<-2
      y1<-1
      x2<-10
      y2<-seq(1,12, by=1)[1:3]
    }
    
    z1 <- rep(c('I want ...', "I guess ...","I need ..."),4)
    mapply(FUN= function(x1,y1,x2,y2,z1) text(x=(c(0)*x1)+x2, y= (c(0.35)*y1)+y2
                                              , col="black", label=z1, 
                                              font=2, pos=4,
                                              cex=3)
           ,x1=x1,y1=y1,x2=x2,y2=y2, z1=z1[1:3])
    
    x2<-7
    x1<-x1-.1
    c2<- rep(c("darkolivegreen","darksalmon","orange"),4)
    y2<-y2+.1
    mapply(FUN= function(x1,y1,x2,y2,c2) polygon(x=(c(0,1,1.25,1,0)*x1)+x2, 
                                                 y= (c(0,0,.35,.7,.7)*y1)+y2
                                                 , col=c2[1])
           ,x1=x1,y1=y1,x2=x2,y2=y2,c2=c2)
  }
  dev.off()
}
