

shinyUI(dashboardPage(skin = "purple",
  #Add Header
  dashboardHeader(title = "Uber/Lyft Pickups and Dropoffs", titleWidth = 450),
  #Disable sidebar
  dashboardSidebar(disable = TRUE),
  #Add map
  dashboardBody(
    fluidRow(column(width=9,box(width=NULL,solidHeader=TRUE,
                                leafletOutput("map",height = 1000)),

  #Add info boxes
             infoBoxOutput("rphBox"),
             infoBoxOutput("minBox"),
             infoBoxOutput("avgBox")),
       
        #Add slider box and check boxes 
        #Day of Week
           column(width = 3,
                 box(background = "black", width = NULL, status = "warning",
                  
                   radioButtons("checkDay", label = h3("Choose Day of the Week:"),
                                choices = list("Monday" = 0, "Tuesday" = 1, "Wednesday" = 2, "Thursday" = 3, 
                                               "Friday" = 4, "Saturday" = 5, "Sunday" = 6), selected = 0), 
                               selected = 1),
                   radioButtons("checkDirection", label = h3("Choose Direction:"),
                                choices = list("Pick-ups" = 1, "Drop-offs" = 2), 
                                selected = 1),
                  
         #Time slider
         box(title = "Summary Statistics:",background = "black", width = NULL, status = "warning",
                   chooseSliderSkin("Modern"),
                   plotOutput("histgraph"),
                   sliderInput("slidertime", label = h3("Time Of Day (Military)"), min = 0, 
                    max = 23, value = 0, step = 1,
                    animate = animationOptions(interval = 1500, loop = TRUE))

                     
                 )
           )
        )
  )))
      
         
                        
 
