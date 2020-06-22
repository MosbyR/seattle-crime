library(shiny)
library(dplyr)
library(ggplot2)
library(lubridate)
library(rsconnect)
library(maps)
library(leaflet)
library(stringr)


source("filter_data.R")


sever <- function(input, output) {
  
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
  output$boxplot <- renderPlot({
    boxplotcrime <- filtered_data %>%
      group_by(Offense.Parent.Group,Year.Occurred,Precinct) %>%
      summarise(total_crime =sum(total_crime)) %>%
      filter(Offense.Parent.Group == input$crime) %>%
      filter(Precinct != "UNKNOWN", Precinct!= "") 
    
    
      ggplot(boxplotcrime,aes(Precinct,y=total_crime, fill = Precinct))+
        geom_boxplot()+
        labs(title = paste0(input$crime, " crimes by Precinct")) +
        labs(y = "Total Crime")
  })
  
####################################################################################  
#plot line graph of crime throught years 
  output$linegraph <- renderPlot({
    line_graph_crime <- filtered_data %>%
      filter(Crime.Against.Category %in% input$line) %>%
      group_by(Crime.Against.Category, Year.Occurred) %>%
      summarise(total_crime =sum(total_crime))
    
    ggplot(data = line_graph_crime,aes(x = Year.Occurred, y = total_crime,color =Crime.Against.Category)) +
      geom_line()+
      geom_point()+
      scale_x_continuous(breaks = c(2008,2010,2012,2014,2016,2018),
                         labels = c(2008,2010,2012,2014,2016,2018))+
    
      labs(x = "Year", y ="Total Crime") +
      labs(title = paste0("Top Crime Throughtout the Years")) +
      scale_color_discrete(name =" Crime Category")
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
  output$lineplot <- renderPlot({
    months <- filtered_data %>%
      filter(Year.Occurred == input$year2) %>%
      filter(MCPP == input$neighborhood) %>%
      group_by(Year.Occurred,Month.Occurred) %>%
      summarise(total_crime =sum(total_crime)) %>%
      arrange(Month.Occurred)
    
    ggplot(data = months,aes(x=months$Month.Occurred, y=months$total_crime)) +
      #geom_line()+
      geom_bar(stat = "identity",fill="orange")+
      geom_text(aes(label=total_crime), position=position_dodge(width=0.9), vjust=-0.25)+
      #geom_point()+
      scale_x_discrete(limits = c("Jan","Feb","Mar","April","May","June","July","Aug","Sept","Oct","Nov","Dec"))+
      theme(axis.text.x = element_text(angle = 30, hjust = 1))+
      labs(x = "Months", y="Total Crime")+
      labs(title =paste0("Breakdown of Total Crimes Commited in ",input$neighborhood," Year ", input$year2))
  })
##########################################################################
   
  #plot linear regression for neighborhoods
  output$linear_graph <- renderPlot({
    line_graph_crime <- filtered_data %>%
      filter(Offense.Parent.Group == input$reg) %>%
      group_by(Offense.Parent.Group, Year.Occurred) %>%
      summarise(total_crime =sum(total_crime))
    
    
    ggplot(line_graph_crime, aes(x=line_graph_crime$Year.Occurred,y=line_graph_crime$total_crime))+
      geom_point()+
      geom_smooth(method= "lm",se = FALSE,color = "red")+
      scale_x_continuous(breaks = c(2008,2010,2012,2014,2016,2018),
                         labels = c(2008,2010,2012,2014,2016,2018)) +
      labs(x= "Years", y= "Total Crime") +
      labs(title = paste0(input$reg," Crimes Commited and Regression Plot for Year 2008 - 2019"))
  })
  
}



