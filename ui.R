library(shiny)
library(shinythemes)
library(plotly)



page_one <- tabPanel("Introduction",
                       sidebarLayout(
                         sidebarPanel(
                           helpText(
                             h3("Insert into here"))
                         ),
                         mainPanel(
                           h1("Introduction"),
                           h1("Limitations")
                           )
                         ))
                    


                    
                  

page_two <- tabPanel("Top 10 Highest Occurring Crime",
                     sidebarLayout(
                       sidebarPanel(
                         selectInput("year",label = h3("Select Year"),
                                     choices = c("2008","2009","2010", "2011", "2012", "2013", "2014", "2015", "2016",
                                                  "2017", "2018") ,
                                     selected = "2016")
                         
                       ),
                     mainPanel(
                       plotOutput("crime"),
                       h1("Research Question"),
                       h1("Background"),
                       h1("Results")
                       
                     )))


page_three <- tabPanel("Crime Type vs Precinct",
                       sidebarLayout(
                         sidebarPanel(
                           selectInput("crime",label = h3("Select Crime"),
                                       choices = c("Car Prowl" = "CAR PROWL", "Burglary"= "BURGLARY", "Shoplifting"= "SHOPLIFTING", "Motor Vehicle Theft" ="MOTOR VEHICLE THEFT",
                                                   "Trespass" = "TRESPASS", "Aggravated Assault" = "AGGRAVATED ASSAULT", "Robbery" = "ROBBERY", "Narcotic" = "NARCOTIC",
                                                   "Bicycle Theft" = "BICYCLE THEFT", "Dui" = "DUI") ,
                                       selected = "DUI")
                         ),
                       mainPanel(
                         plotOutput("boxplot"),
                         h1("Research Question"),
                         h1("Background"),
                         h1("Results")
                         
                       )))
        

page_four <- tabPanel("Seattle Neighborhoods",
                      sidebarLayout(
                        sidebarPanel(
                          selectInput("year2",label = h3("Select Year"),
                                      choices = c("2008","2009","2010", "2011", "2012", "2013", "2014", "2015", "2016",
                                                  "2017", "2018") ,
                                      selected = "2016"),
                          uiOutput("neighborhood")
                        ),
                        mainPanel(
                          plotOutput("lineplot"),
                          h1("Research Question"),
                          h1("Background"),
                          h1("Results")
                        )
                      ))

page_five <- tabPanel("Crime Rates by Decade",
                      sidebarLayout(
                        sidebarPanel(
                          checkboxGroupInput("line", label = h3("Crime Type"), 
                                             choices = list("Car Prowl" = "CAR PROWL", "Burglary" = "BURGLARY", "Shoplifting" = "SHOPLIFTING","Motor Vehicle Theft" = "MOTOR VEHICLE THEFT", "Trespass" = "TRESPASS",
                                                            "Aggravated Assault" = "AGGRAVATED ASSAULT", "Robbery"= "ROBBERY", "Narcotic" = "NARCOTIC",
                                                            "Bicycle Theft" = "BICYCLE THEFT", "Dui" = "DUI"),
                                             selected = c("SHOPLIFTING","BURGLARY","MOTOR VEHICLE THEFT"))
               
                        ),
                        mainPanel(
                          plotOutput("linegraph"),
                          h1("Research Question"),
                          h1("Background"),
                          h1("Results")
                        )
                      )
                      
                      
)

page_six <- tabPanel("Modeling Crime",
                     sidebarLayout(
                       sidebarPanel(
                         selectInput("reg",label = h3("Select Crime"),
                                     choices = c("Car Prowl" = "CAR PROWL", "Burglary"= "BURGLARY", "Shoplifting"= "SHOPLIFTING", "Motor Vehicle Theft" ="MOTOR VEHICLE THEFT",
                                                 "Trespass" = "TRESPASS", "Aggravated Assault" = "AGGRAVATED ASSAULT", "Robbery" = "ROBBERY", "Narcotic" = "NARCOTIC",
                                                 "Bicycle Theft" = "BICYCLE THEFT", "Dui" = "DUI") ,
                                     selected = "DUI")
                       ),
                       mainPanel(
                         plotOutput("linear_graph"),
                         h1("Research Question"),
                         h1("Background"),
                         h1("Results")
                       )
                     ))
                      
                      
                      
                
                    


ui <- navbarPage(theme = shinytheme("flatly"),
                 "Seattle Crime",
                 page_one,
                 page_two,
                 page_three,
                 page_four,
                 page_five,
                 page_six
                 )
