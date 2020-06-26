library(shiny)
library(dplyr)
library(ggplot2)
library(lubridate)
library(rsconnect)
library(maps)
library(stringr)
library(leaflet)
library(sf)
library(rmapshaper)
require(plotly)


source("filter_data.R")


sever <- function(input, output) {
  
  #output image
  output$seattle_sky <-renderImage({
    return(list(
      src="img/seattle_skyline.png",
      alt ="a seattle picture"
    ))
  },deleteFile = FALSE)
  
  filtered_data <- filter_dates("Crime_Datav2.csv")
  
  output$crime <- renderPlot({
    filtered_data  %>%
      filter(Year.Occurred == input$year) %>%
      select(Offense.Parent.Group,Year.Occurred,MCPP,total_crime) %>%
      group_by(Offense.Parent.Group,Year.Occurred) %>%
      summarise(total_crime =sum(total_crime)) %>%

      #group_by(Year.Occurred,Crime.Subcategory,total_crime) %>%
      arrange(total_crime) %>%
      ungroup() %>%
      
      top_n(n=15, w= total_crime) %>%
    
      #reorder(top_ten =reorder(Crime.Subcategory,total_crime)) %>%
      
      #plots graph
      ggplot(aes(x = reorder(Offense.Parent.Group,total_crime),total_crime , fill = Offense.Parent.Group))+
      geom_bar(stat = "identity") +
      coord_flip() +
      theme(axis.text.x = element_text(angle = 30, hjust = 1))+
      geom_text(aes(label=total_crime))+
      guides(fill=FALSE)+
      labs(title = paste0("Crime in Seattle for the year ", input$year))
  })
  
  output$texting <- renderText({
    "Please work!"
  })
  
  
  output$text_output <-renderUI({
    text1 <- paste0(" fjkdhfdjdhfkjdh")
    HTML(paste(text1))
    
})
#####################################################################################  
  # plots the box plot 
  output$boxplot <- renderPlotly({
    boxplotcrime <- filtered_data %>%
      group_by(Offense.Parent.Group,Year.Occurred,Precinct) %>%
      summarise(total_crime =sum(total_crime)) %>%
      filter(Offense.Parent.Group == input$crime) %>%
      filter(Precinct != "UNKNOWN", Precinct!= "") 
    
    
    plot_ly(boxplotcrime, y=~total_crime,
                 boxplots = "suspectedoutliers") %>%
      add_boxplot(color = ~Precinct) %>%
      layout(title =paste0(input$crime, " crimes by Precinct"),
             xaxis = list(title = "Precinct"),
             yaxis = list(title = "Total Crime")) %>%
      layout(legend=list(title=list(text='<b> Precinct </b>')))
    
    
      #ggplot(boxplotcrime,aes(Precinct,y=total_crime, fill = Precinct))+
        #geom_boxplot()+
        #labs(title = paste0(input$crime, " crimes by Precinct")) +
        #labs(y = "Total Crime")
  })
  
####################################################################################  
#plot line graph of crime throught years 
  output$linegraph <- renderPlotly({
    line_graph_crime <- filtered_data %>%
      filter(Crime.Against.Category %in% input$line) %>%
      group_by(Crime.Against.Category, Year.Occurred) %>%
      summarise(total_crime =sum(total_crime))
    
     n <- ggplot(data = line_graph_crime,aes(x = Year.Occurred, y = total_crime,color =Crime.Against.Category)) +
      geom_line()+
      geom_point()+
      scale_x_continuous(breaks = c(2008,2010,2012,2014,2016,2018),
                         labels = c(2008,2010,2012,2014,2016,2018))+
    
      labs(x = "Year", y ="Total Crime") +
      labs(title = paste0("Top Crime Throughtout the Years")) +
      scale_color_discrete(name =" Crime Category")
     
     fig <- ggplotly(n)
     fig
  })
########################################################################
#filters data here, which saves me time in the ui.R
  output$neighborhood <- renderUI({
    selectInput(
      "neighborhood",
      h3("Neighborhood"),
      choices = unique(filtered_data$MCPP))
  })
  
#neighborhoods and year 
  output$lineplot <- renderPlotly({
    months <- filtered_data %>%
      filter(Year.Occurred == input$year2) %>%
      filter(MCPP == input$neighborhood) %>%
      group_by(Year.Occurred,Month.Occurred) %>%
      summarise(total_crime =sum(total_crime)) %>%
      arrange(Month.Occurred)
    
    b <- ggplot(data = months,aes(x=Month.Occurred, y=total_crime)) +
      #geom_line()+
      geom_bar(stat = "identity",fill="orange")+
      #geom_text(aes(label=total_crime), position=position_dodge(width=0.9), vjust=-0.25)+ maybe i dont need this?????
      #geom_point()+
      scale_x_discrete(limits = c("Jan","Feb","Mar","April","May","June","July","Aug","Sept","Oct","Nov","Dec"))+
      theme(axis.text.x = element_text(angle = 30, hjust = 1))+
      labs(x = "Months", y="Total Crime")+
      labs(title =paste0("Breakdown of Total Crimes Commited in ",input$neighborhood," Year ", input$year2))
    
    fib <- ggplotly(b)
    fib
  })
##########################################################################
   
  #plot linear regression for neighborhoods
  output$linear_graph <- renderPlotly({
    line_graph_crime <- filtered_data %>%
      filter(Offense.Parent.Group == input$reg) %>%
      group_by(Offense.Parent.Group, Year.Occurred) %>%
      summarise(total_crime =sum(total_crime))
    
 
    p <- ggplot(line_graph_crime, aes(x=Year.Occurred,y=total_crime))+
      geom_point()+
      geom_smooth(method= "lm",se = FALSE,color = "red")+
      scale_x_continuous(breaks = c(2008,2010,2012,2014,2016,2018),
                         labels = c(2008,2010,2012,2014,2016,2018)) +
      labs(x= "Years", y= "Total Crime") +
      labs(title = paste0(input$reg," Crimes Commited and Regression Plot"))
    
    fig <- ggplotly(p)
    fig
  })
  
  
####### new stuf##################################################
  data.p <- sf::st_read("./Micro_Community_Policing_Plans-shp/Micro_Community_Policing_Plans.shp") %>% 
    st_transform(4326) %>%
    rmapshaper::ms_simplify()
  
  lng.center <- -122.318039
  lat.center <- 47.596508 
  zoom.def <- 10
  
  #dataframe with same structure as statscan csv after processing
  seattle_crime <- read.csv2("Crime_Data.csv")
  
  
  
  data <- left_join(data.p, seattle_crime, by = c("OBJECTID"= "OBJECTID"))
  
  output$crimes <- renderLeaflet({
    leaflet(data = data.p) %>%
      addProviderTiles("OpenStreetMap.Mapnik", options = providerTileOptions(opacity = 1), group = "Open Street Map") %>%
      setView(lng = lng.center, lat = lat.center, zoom = zoom.def) %>%
      addPolygons(group = 'base', 
                  fillColor = 'transparent', 
                  color = 'black',
                  weight = 1.5)  %>%
      addLegend(pal = pal(), values = seattle_crime$total_crime, opacity = 0.7, title = "Total Crime",
                position = "topright")
  })
  
  # get_data <- reactive({
  #   data[which(data$Year.Occurred == input$year2),]
  # })
  
  get_data <- reactive({
    
    data <- data %>%
      filter(Year.Occurred == input$year2)
    
  })

# color palette
  pal <- reactive({
    colorNumeric(c('#fef0d9','#fdd49e','#fdbb84','#fc8d59','#ef6548','#d7301f','#990000'), domain = data$total_crime)
  })
  
  observe({
    data <- get_data()
    leafletProxy('crimes', data = data) %>%
      clearGroup('polygons') %>%
      addPolygons(group = 'polygons', 
                  fillColor = ~pal()(total_crime), 
                  fillOpacity = 0.9,
                  color = 'black',
                  weight = 1.5)
  })
  
}



