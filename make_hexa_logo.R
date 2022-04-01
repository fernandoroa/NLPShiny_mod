{
  png(filename = "readme_logo.png",width = 338, height=391)
  {
    par(bg=NA)
    par(oma=rep(0,4) , mar=rep(0,4))
    
    {
      plot(c(-9.9, 11.9)+10, c(-9.5, 15.5),  type = "n", axes = FALSE, xlab = "",
           ylab = "",yaxs="i", xaxs="i", asp=1)
      
    
      par(family="Aller_Rg")
      
      {
        
        text(5-.2, 6-2,"NLP",cex=2.5, font=2)
        text(5-.2, 2.5-2,"tag",cex=2.5, font=2)
        
          x1<-6
          y1<-3
          x2<-10+1
          y2<-seq(1,12, by=3)[1:3]-4.5
        }
        
        z1 <- rep(c('I want ...', "I guess ...","I need ..."),4)
        #
        # text
        #
        mapply(FUN= function(x1,y1,x2,y2,z1) text(x=(c(0)*x1)+x2+2, y= (c(0.35)*y1)+y2
                                                  , col="black", label=z1, 
                                                  font=2, pos=4,
                                                  cex=1.5)
               ,x1=x1,y1=y1,x2=x2,y2=y2, z1=z1[1:3])
        
        x2<-7+3
        
        x1<-x1-2
        
        c2<- rep(c("darkolivegreen","darksalmon","orange"),4)
        y2<-y2+.1
        x2<-x2-2
        mapply(FUN= function(x1,y1,x2,y2,c2) polygon(x=(c(0,1,1.25,1,0)*x1)+x2, y= (c(0,0,.35,.7,.7)*y1)+y2
                                                     , col=c2[1])
               ,x1=x1,y1=y1,x2=x2,y2=y2,c2=c2)
        
        posx <- 10+3
        posy <- 6
        pts  <- seq(-pi/2, 
                    pi/2,
                    length.out = 25)
        # plot(c(-10, 10), c(-10, 10))
        polygon( c( (posx + sin(pts)*2.5),rev(posx + sin(pts)*2.3) ), 
                 c( (posy + cos(pts)*1.8),rev(posy + cos(pts)*1.6) ), col="darkolivegreen")
        
        polygon( c(17,18,17.5)- 6.9, c(5,5,4.5)+1, col="darkolivegreen")
        par(family="Roboto Thin", mar=rep(1,4) )
        text(13,9,"python.pkl",cex=3, font=2)
      
      #

      h <- 3
      
      x2 = (h/2)^2 - (h/4)^2
      
      x = x2^(1/2)
      
      lines((c(0,x,x,0,-x,-x,0)*8)+11,(c(0, h/4, h-h/4, h, h-h/4,h/4,0)*8)-9, col="darkblue", lwd=10 )
    }
  }
  
  dev.off()
}

