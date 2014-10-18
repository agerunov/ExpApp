library(ggplot2)
library(MASS)
expdata <- read.csv("expdata.csv")


shinyServer(function(input, output){
  
  output$text1 <- renderText({
    paste("You have selected to investigate the connection between", input$exp, "and economic activity.")
  })
  
    output$text2 <- renderText({
      exp <- switch(input$exp, 
                    "Overall Expectations" = expdata$ovcond,
                    "Consumer Confidence" = expdata$consconf,
                    "Industry Confidence" = expdata$indconf, 
                    "Service confidence" = expdata$servconf, 
                    "Unemployment Expectations" = expdata$unemp)
      options(digits=3)
      corov <- cor(as.numeric(exp), as.numeric(expdata$rgrow))
      paste("The correlation between", input$exp, "and Economic Growth stands at", round(corov, digits=3), ".")
      })
  
    output$plot <- renderPlot({
    
    exp <- switch(input$exp, 
                    "Overall Expectations" = expdata$ovcond,
                    "Consumer Confidence" = expdata$consconf,
                    "Industry Confidence" = expdata$indconf, 
                    "Service confidence" = expdata$servconf, 
                    "Unemployment Expectations" = expdata$unemp)
      
    smooth <- switch(input$smooth,
                     "None" = NULL, 
                     "Linear Model" = "lm", 
                     "Robust Linear Model"= "rlm", 
                     "Loess"="loess")
    title <- paste("Connections between", input$exp, "and Economic Growth (%)")
    
    if (input$crisis==TRUE){ 
      Color <- expdata$crisis
            qplot(x=as.numeric(exp), y=as.numeric(expdata$rgrow), 
            xlab=input$exp, ylab="Real GDP Growth", main=title, size=I(3), color=Color) + geom_smooth(method=smooth, lwd=1, se=input$se)
          } 
    
    else {qplot(x=as.numeric(exp), y=as.numeric(expdata$rgrow), 
                xlab=input$exp, ylab="Real GDP Growth", main=title, size=I(3)) + geom_smooth(method=smooth, lwd=1, se=input$se)
    }
    
  })
  
})