
shinyServer(function (input, output, session) {
  
  datachoice <- reactive({
    if (input$checkDirection == 1) {

      thedata <- data.og %>% filter(day_of_week == input$checkDay, hour == input$slidertime)
      pal <- colorNumeric(palette = "YlOrRd", domain = thedata$pickups, na.color = NA)
      
      leaflet() %>% addTiles() %>%
        setView(lng = -122.4194, lat = 37.7749, zoom = 12) %>%
        addPolygons(data = map, weight = 1, col = "red", 
                    fillColor = ~pal(thedata$pickups), fillOpacity = 0.7) %>%
        addLegend("bottomright", pal = pal, values = thedata$pickups, title = "Legend", opacity = 1)
      
    } else {
      
      thedata <- data.og %>% filter(day_of_week == input$checkDay, hour == input$slidertime)
      pal <- colorNumeric(palette = "YlOrRd", domain = thedata$dropoffs, na.color = NA)
      
      leaflet() %>% addTiles() %>%
        setView(lng = -122.4194, lat = 37.7749, zoom = 12) %>%
        addPolygons(data = map, weight = 1, col = "red", 
                    fillColor = ~pal(thedata$dropoffs), fillOpacity = 0.7) %>%
        addLegend("bottomright", pal = pal, values = thedata$dropoffs, title = "Legend", opacity = 1)
    }
  })
  
  output$map <- renderLeaflet({
    datachoice()
   })

  #Plotting sidebar
  datachoice2 <- reactive({
    if (input$checkDirection == 1) {
      
      thedata2 <- data.og %>% group_by(day_of_week,hour) %>% summarise(pickups = mean(pickups), dropoffs = mean(dropoffs))
      thedata2 <- thedata2 %>% filter(day_of_week == input$checkDay)
      
  #Plotting pickups    
        ggplot(thedata2, aes(x=hour, y=pickups)) + 
        geom_point() +
        geom_line() +
        labs(x = "Hour", y = "Pickups", 
        title = "Stats")
      
    } else {
      
      thedata2 <- data.og %>% group_by(day_of_week,hour) %>% summarise(pickups = mean(pickups), dropoffs = mean(dropoffs))
      thedata2 <- thedata2 %>% filter(day_of_week == input$checkDay)
    
  #Plotting dropoffs
        ggplot(thedata2, aes(x=hour, y=dropoffs)) + 
        geom_point() +
        geom_line() +
        labs(x = "Hour", y = "Dropoffs", 
        title = "Stats")
     
        }
      })

  output$histgraph <- renderPlot({ 
    datachoice2()
    })
})
    

