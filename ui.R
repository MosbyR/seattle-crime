library(shiny)
library(shinythemes)
library(plotly)
library(leaflet)


page_one <- tabPanel("Introduction",
                       sidebarLayout(
                         sidebarPanel(
                           helpText(
                             h3("Data Resources"),
                             p("The dataset I utilized was published by the Seattle Police Department an consisted of crime data reported over a variety of categories. 
                               I decided to filter the data based on the years 2008 - 2019. "),
                             (tags$a(href="https://www.seattle.gov/police/information-and-data/public-data-sets","Seattle Crime Data 2008-Present")),
                             br(),
                             br(),
                             br(),
                             
                             p("This dataset includes the shapefile used to create the interactive map of Seattle."),
                             (tags$a(href="http://data-seattlecitygis.opendata.arcgis.com/datasets/micro-community-policing-plans","Seattle Shapefile")))
                             
                         ),
                         mainPanel(
                           h1("Introduction"),
                           p("The goal of this web application is to raise awareness, increase transparency, 
                             and  facilitate safe decision making in regards to crime trends in Seattle, 
                             Washington. According to FBI statistics 1 in 147 of Seattle’s residents was 
                             the victim of a crime in 2018. As a result, this means that Seattle ranks as 
                             the 5th highest city in Washington State for crime probability. This report 
                             examines the following: how total crimes committed differs between police 
                             precincts, the correlation between years and crime rates by neighborhoods,
                             crimes types commit in relationship to the month, and total crimes committed 
                             throughout the years."),
                           h1("Limitations"),
                           p("Some of the limitations of this web application is the data itself. 
                             Police might be careless or manipulative when they categorize an incident,
                             or that its limited to departments/ precincts that report crimes. In addition,
                             there is a chance of the data being skewed in order to look better in the
                             eyes of the public or allocate resources.")
                           )
                         ),
                     #outputs the image
                     imageOutput("seattle_sky"),
                     #makes image dynamic
                     tags$head(tags$style(
                       type="text/css",
                       "#seattle_sky img {max-width: 100%; width: 100%; height: 80%}"
                     )),
                     )
                    


                    
                  

# page_two <- tabPanel("Top 10 Highest Occurring Crime",
#                      sidebarLayout(
#                        sidebarPanel(
#                          selectInput("year",label = h3("Select Year"),
#                                      choices = c("2008","2009","2010", "2011", "2012", "2013", "2014", "2015", "2016",
#                                                   "2017", "2018","2019") ,
#                                      selected = "2016")
#                          
#                        ),
#                      mainPanel(
#                        plotOutput("crime"),
#                        h1("Research Question"),
#                        h1("Background"),
#                        h1("Results")
#                        
#                      )))


page_three <- tabPanel("Crime Type vs Precinct",
                       sidebarLayout(
                         sidebarPanel(
                           selectInput("crime",label = h3("Select Crime"),
                                       choices = c("Larceny Theft" = "LARCENY-THEFT", "Assault Offenses"= "ASSAULT OFFENSES", "Burglary/Breaking&Entering"= "BURGLARY/BREAKING&ENTERING", "Destruction/Damage/Vandalism of Property" ="DESTRUCTION/DAMAGE/VANDALISM OF PROPERTY",
                                                   "Motor Vehicle Theft" = "MOTOR VEHICLE THEFT", "Fraud Offenses" = "FRAUD OFFENSES", "Trespass of Real Property" = "TRESPASS OF REAL PROPERTY", "Drug/Narcotic Offenses" = "DRUG/NARCOTIC OFFENSES",
                                                   "Robbery" = "ROBBERY", "Dui" = "DRIVING UNDER THE INFLUENCE","Family Offenses NonViolent" = "FAMILY OFFENSES, NONVIOLENT","Weapon Violations"="WEAPON LAW VIOLATIONS","Bad Checks"="BAD CHECKS",
                                                   "Sex Offenses"="SEX OFFENSES","Prostitution Offenses"="PROSTITUTION OFFENSES") ,
                                       selected = "ROBBERY")
                         ),
                       mainPanel(
                         plotlyOutput("boxplot"),
                         h1("Research Question"),
                         h1("Background"),
                         h1("Results")
                         
                       )))
        

page_four <- tabPanel("Seattle Neighborhoods",
                      sidebarLayout(
                        sidebarPanel(
                          selectInput("year2",label = h3("Select Year"),
                                      choices = c("2008","2009","2010", "2011", "2012", "2013", "2014", "2015", "2016",
                                                  "2017", "2018","2019") ,
                                      selected = "2016"),
                          uiOutput("neighborhood")
                        ),
                        mainPanel(
                          plotlyOutput("lineplot"),
                          #leafletOutput("crimes"),#, width = "100%", height = "100%")  #### new stuf
                          h1("Research Question"),
                          h1("Background"),
                          h1("Results"),
                          leafletOutput("crimes")#, width = "100%", height = "100%")  #### new stuf 
                        
                        )
                      ))

page_five <- tabPanel("Crime Rates by Decade",
                      sidebarLayout(
                        sidebarPanel(
                          checkboxGroupInput("line", label = h3("Crime Type"), 
                                             choices = c("Society" = "SOCIETY", "Property"= "PROPERTY", "Person"= "PERSON", "Not a Crime" ="NOT_A_CRIME"),
                                             selected = "PERSON")
               
                        ),
                        mainPanel(
                          plotlyOutput("linegraph"),
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
                                     choices = c("Larceny Theft" = "LARCENY-THEFT", "Assault Offenses"= "ASSAULT OFFENSES", "Burglary/Breaking&Entering"= "BURGLARY/BREAKING&ENTERING", "Destruction/Damage/Vandalism of Property" ="DESTRUCTION/DAMAGE/VANDALISM OF PROPERTY",
                                                 "Motor Vehicle Theft" = "MOTOR VEHICLE THEFT", "Fraud Offenses" = "FRAUD OFFENSES", "Trespass of Real Property" = "TRESPASS OF REAL PROPERTY", "Drug/Narcotic Offenses" = "DRUG/NARCOTIC OFFENSES",
                                                 "Robbery" = "ROBBERY", "Dui" = "DRIVING UNDER THE INFLUENCE","Family Offenses,NonViolent" ="FAMILY OFFENSES, NONVIOLENT","Weapon Violations"="WEAPON LAW VIOLATIONS","Bad Checks"="BAD CHECKS",
                                                 "Sex Offenses"="SEX OFFENSES","Prostitution Offenses"="PROSTITUTION OFFENSES") ,
                                     selected = "ROBBERY")
                       ),
                       mainPanel(
                         plotlyOutput("linear_graph"),
                         h1("Research Question"),
                         h1("Background"),
                         h1("Results")
                       )
                     ))
                      
                      
                      
                
                    

ui <- navbarPage(theme = shinytheme("sandstone"),
                 "Seattle Crime Analysis",
                 page_one,
                 #page_two,
                 page_three,
                 page_four,
                 page_five,
                 page_six
                 )
