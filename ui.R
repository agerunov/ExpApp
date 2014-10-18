shinyUI(fluidPage(
  
  titlePanel("Public Expectations and Economic Growth in the EU"),
  
  sidebarLayout(
    
    sidebarPanel(
      selectInput("exp", "Please select type of expectations:", choices = c("Overall Expectations", "Consumer Confidence", "Industry Confidence", "Service confidence", "Unemployment Expectations"), selected = "Overall Expectations"),
      br(),
      checkboxInput("crisis", label = "Differentiate between pre-crisis and post-crisis years", FALSE),
      br(),
      selectInput("smooth", "Please select the type of smoother:", choices = c("None", "Linear Model", "Robust Linear Model", "Loess"), selected = "Linear Model"),
      br(),
      checkboxInput("se", label = "Turn Standard Errors for Smoother On", FALSE)
    ),
    
    mainPanel(
      "Public expectations about how the economy will behave are sometimes predictive of actual dynamics, and sometimes not. 
      We can investigate the connection between different economic expectations and actual growth in the European Union, ranging from Q1 1998 to Q2 2014.",
      br(),
      br(),
      h5(textOutput("text1")),
      h5(textOutput("text2")),
      plotOutput("plot"),
      p("Documentation:",
      a("Public Expectations and Economic Growth in the EU",href="ExpHelp.html"))
      
      )
    )
  
  ))