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
                       h1("Crime Sorted by Precinct"),
                       p("The interactive boxplot analyzes and displays the distribution of the total crimes reported by 
                         each police precinct in Seattle based on yearly reports. The crimes types chosen are the 15 
                         highest crimes committed in Seattle, WA from 2008-2019. In addition, the interactive boxplot 
                         shows the five-number summary of a set of data( minimum  lower quartile, median, upper 
                         quartile, and maximum). "),
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
                         br(),
                         h1("Background"),
                         p("During my research I wanted to learn about how different crime types affect each precinct. 
                           In addition, I choose to display this information using a boxplot because I wanted to 
                           provide a visual summary of the data, which would enable users to quickly identify mean 
                           values, the dispersion of the data set, and skewness."),
                         h1("Conclusion"),
                         p("Based on my boxplot visualizations, I can determine that there are trends for each precinct 
                           similar to the total crimes committed by neighborhoods yearly. For example, the north police 
                           precinct  has the highest crime rate committed/reported yearly. While, the southwest precinct 
                           has the lowest crime rate committed/reported yearly."),
                         br(),
                         br(),
                         imageOutput("police_precinct"),
              
                         #makes image dynamic
                         tags$head(tags$style(
                           type="text/css",
                           "#police_precinct img {max-width: 100%; width: auto; height: auto}"
                         ))
                       )))
        

page_four <- tabPanel("Seattle Neighborhoods",
                      h1("Crime Sorted by Neighborhoods"),
                      p("The interactive bar plot shows the caparisons between crimes being committed by month. Users 
                        are able to filter by Neighborhood and Year. In addition, there is a heat map below which shows 
                        a graphical representation of total crimes being committed by neighborhood."),
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
                          br(),
                          br(),
                          leafletOutput("crimes"),#, width = "100%", height = "100%")
                          h1("Background"),
                          p("While conducting my research I was interested in learning about how crimes are 
                             committed monthly in neighborhoods. I originally hypothesis that crimes would 
                             spike during the summer because of increased temperatures, which might drive people
                             out of doors and leave windows open in their homes. Also, the increase daylight hours 
                             could raise the amount of time people spend in public. Another factor might be heat-discomfort 
                            which might lead to more aggression."), 
                             p("I decided to create a heatmap visualizing Seattle to better visualize the volume of crimes by location
                             and to better communicate values to the user."), 
                          h1("Conclusion"),
                          p("From the bar plot visualizations,  I don’t see any trends that supports my originally hypothesis
                            of there being more crimes committed during the summer months. I suspect that certain categories 
                            of crimes are committed more depending on the season. In addition, the bar plot generally has a 
                            normal distribution for majority of neighborhoods and selected years."),
                          p("However, the heatmap shows a concertation of crime being committed in the center of Seattle and 
                            North Seattle. Both of these geographic locations reside in the north and west police precincts 
                            jurisdiction. Also throughout the years crime is most prevalent in the same location(Downtown 
                            Commercial). "),
                          br()
                        
                        )
                      ))

page_five <- tabPanel("Crime Rates by Decade",
                      h1("Crime Sorted by Category"),
                      sidebarLayout(
                        sidebarPanel(
                          checkboxGroupInput("line", label = h3("Select Crime Category"), 
                                             choices = c("Society" = "SOCIETY", "Property"= "PROPERTY", "Person"= "PERSON", "Not a Crime" ="NOT_A_CRIME"),
                                             selected = c("PERSON","SOCIETY"))
               
                        ),
                        mainPanel(
                          plotlyOutput("linegraph"),
                          h1("Background"),
                          h1("Conclusion"),
                          br()
                        )
                      )
                      
                      
)

page_six <- tabPanel("Modeling Crime",
                     h1("Linear Regression on Total Crimes Committed Over Time"),
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
                         h1("Background"),
                         h1("Conclusion"),
                         br()
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
