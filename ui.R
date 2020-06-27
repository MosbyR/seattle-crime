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
                             (tags$a(href="http://data-seattlecitygis.opendata.arcgis.com/datasets/micro-community-policing-plans","Seattle Shapefile")),
                             br(),
                             br(),
                             br(),
                             p("Created By:"),
                             (tags$a(href="https://www.linkedin.com/in/roymosby/","Roy Mosby")))
                           
                             
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
                    



page_two <- tabPanel("Crime Type vs Precinct",
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
        

page_three <- tabPanel("Seattle Neighborhoods",
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

page_four <- tabPanel("Crime Rates by Decade",
                      h1("Crime Sorted by Category"),
                      p("The interactive line graph compares the categories of crimes from 2008 – 2019. Users are able to 
                        select which categories they want to compare. There are 3 main categories of crime which consist 
                        of the following: society, property, and person. Examples of society crime would be DUI’s and
                        Drug/Narcotic offenses. Several examples of property crime would be shoplifting, larceny theft 
                        and robbery. Finally, person crimes would consist of kidnapping/abduction and sex offenses. 
                        "),
                      sidebarLayout(
                        sidebarPanel(
                          checkboxGroupInput("line", label = h3("Select Crime Category"), 
                                             choices = c("Society" = "SOCIETY", "Property"= "PROPERTY", "Person"= "PERSON", "Not a Crime" ="NOT_A_CRIME"),
                                             selected = c("PERSON","SOCIETY"))
               
                        ),
                        mainPanel(
                          plotlyOutput("linegraph"),
                          h1("Background"),
                          p("During my research I was curious about how crimes are categorized. I was interested in 
                             learning about which category of crime was most prevalent in Seattle through the years. 
                             As a result, I create an interactive line plot that gives the user the choice of 
                             selecting which categories of crimes they want to compare."),
                          h1("Conclusion"),
                          p("Based on my line graph visualization I can determine that the most prevalent crime
                             category in Seattle is society crime. This makes sense because 9 out of the 15 top 
                             crimes committed in Seattle are classified as society crimes. In addition, the lowest
                            crime category was society."),
                          br()
                 
                        )
                      )
                      
                      
)

page_five <- tabPanel("Modeling Crime",
                     h1("Linear Regression on Total Crimes Committed Over Time"),
                     p("The interactive scatterplot analyzes the correlation between the years and total crimes 
                       committed for the selected type of crime. The crimes that are chosen are the top 15 crimes 
                       in Seattle from the year 2008-2019. In addition, the black dots represent the number of 
                       crimes occurrences per year. The red line represents a linear regression of the same 
                       data."),
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
                         p("While conducting research I was interested in how to potentially anticipate an increase
                           or decrease in crimes for the following year. Creating a linear regression model can be
                           beneficial in determining how police should utilize their resources. In addition, 
                           learning about predictive analysis can become a tool to help decrease future crimes."),
                         h1("Conclusion"),
                         p("Based on the results from the interactive linear regression model, I can determine 
                            that majority of the top 15 crime occurrence have a positive correlation. This means 
                            that we can expect an increase of crimes committed for that particular crime selected. 
                            I also thought it was interesting how the crime type “bad checks” have a strong negative 
                            correlation. I believe this is because society has adapted new forms of payment such as 
                            online banking."),
                         br()
                       )
                     ))
                      
                      
                      
                
                    

ui <- navbarPage(theme = shinytheme("sandstone"),
                 "Seattle Crime Analysis",
                 page_one,
                 page_two,
                 page_three,
                 page_four,
                 page_five
                 )
