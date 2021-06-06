# Public Multifamily Data Visulization 

## Goals and Objectives 

Our goal is to create a suite of visualizations pertaining to predictive analytics for Multifamily Real Estate as well as key variables. To do this our objectives are as follows: 

* Leverage Kepler GL to allow for fast exploration of vast amounts of census data
* Create an R-Shiny Application that maps key multifamily variables: supply (number of properites), current effective rent, YoY effective rent and projected effective rent growth. 
* Provide clear explanition on each variable as well as an overview of methods used in creating prediction


## Background, Motivation

Real Estate Investment Trusts, (REITS), specifically those which focus on Multifamily properties, are one of the few financial institutions yet to widely adopt advances in geocomputation yet they simultaneously stand to benefit from such advances given the inherently spatial process of selecting assets whether they be for development or acquisition. Moreover, given the wide array of different neighborhoods within the United States it is often difficult for smaller firms to adequately understand the makeup of each area for which they may consider investing. Therefore, a better understanding of place via an all inclusive dashboard will help optimize deal flow. Moreover, an understanding of which areas will see the highest rent growth, arguably the most important metric for whether or not an investment is successful, allows for firms to narrow their scope leading to a more effective utilization of capital. 

## Data Sources, Spatial and Temporal Scale

|                      Variable Name                     |                                                               Description                                                              |  Granularity |            Source            |
|:------------------------------------------------------:|:--------------------------------------------------------------------------------------------------------------------------------------:|:------------:|:----------------------------:|
| Tract ID                                               | The Unique Identifier of the Census Tract                                                                                              | Census Tract | 2019 ACS (Five Year Average) |
| County                                                 | The County of the Census Tract                                                                                                         | Census Tract | 2019 ACS (Five Year Average) |
| State                                                  | The State of the Census Tract                                                                                                          | Census Tract | 2019 ACS (Five Year Average) |
| Population                                             | Estimated Total Population                                                                                                             | Census Tract | 2019 ACS (Five Year Average) |
| Population Density                                     | Population divided by census tract area (in kilometers)                                                                                | Census Tract | 2019 ACS (Five Year Average) |
| Median Household Income                                | Median Household Income in the past 12 months                                                                                          | Census Tract | 2019 ACS (Five Year Average) |
| Income Growth Rate                                     | Growth Rate of the difference between 2019 Median Household Income and the 2018 Median Household Income (Both From 5 year average ACS) | Census Tract | 2019 ACS (Five Year Average) |
| Census Rent                                            | Median Gross Rent                                                                                                                      | Census Tract | 2019 ACS (Five Year Average) |
| Rent Affordability Ratio                               | Census rent times twelve divided by Median Household Income                                                                            | Census Tract | 2019 ACS (Five Year Average) |
| Renter Proportion                                      | Renter-occupied housing units / (Renter-occupied housing units + Owner-occupied housing units)                                         | Census Tract | 2019 ACS (Five Year Average) |
| Units Per Capita                                       | Total Renter-occupied housing units / Population                                                                                       | Census Tract | 2019 ACS (Five Year Average) |
| Mean Current Effective Rent                            | Weighted (by total units) Average Effective Rent for properties in a submarket (Point in Polygon) as of February 2021                  | Submarket    | MPF Research Inc             |
| Number of Properties                                   | Number of Multifamily Apartments Within A Submarket (Point in Polygon)                                                                 | Submarket    | MPF Research Inc             |
| Year over Year Effective Rent Growth Rate              | Growth Rate Between Weighted Average Submarket Effective Rent in February 2021 and February 2020                                       | Submarket    | MPF Research Inc             |
| Predicted Five Year Average Effective Rent Growth Rate | Projected Average Annual Effective Rent Growth from February 2021 to February 2026                                                     | Submarket    | MPF Research Inc             |

There are two spatial scales of interest here separated into two different visualizations to allow for more straightforward utilization. The fist spatial scale to consider would be census tracts as defined by the United States Census Bureau and the second are our proprietary submarkets which have been substantially altered for public use in the form they appear here. Data from census tracts is pulled from both the 2019 and 2018 Five Year Average American Community Survey (ACS). 

The ‘submarkets’ used here are a very early iteration of our own proprietary submarkets based on results from a spatially constrained multivariate k-medians clustering algorithm which took in the location of private multifamily properties as well as their attributes (Number of floors, Effective Rent, Occupancy and so fourth). We are not able to supply any form of property specific data here however, if it is of interest this data is provided by MPF Research. 


To generate the "Number of Properties’” variable for each submarket we used a point in polygon operation to count the number of total properties within each submarket. To protect private data we then added a random number to this result which functions to mask the actual result while keeping the results reasonable. To generate the “Mean Current Effective Rent” variable we used a points in polygon operation to calculate the average effective rent of each property in a submarket. Each property is weighted by its total number of units during this calculation and this is based of rental data from February 2021. Note that the “Year over Year Effective Rent Growth Rate” is based on the growth rate of the Mean Effective Rent (weighted as described before) from February 2021 to February 2020. Each of these variables are randomized by the addition of a random number once again in order to protect private data. The “Predicted Five Year Average Effective Rent Growth Rate” is the result of a proprietary time sires prediction algorithm which cannot be discussed in detail here. However, predictions are largely based on the historic weighted effective rent of each submarket. To protect these private predictions we reassigned predictions randomly between different polygons in a given market and then added a small random number. The value itself is the average predicted annual rent growth from February 2021 to February 2026.

## Methods Used 

Our methodology revolved around the two visualizations we wanted to create, one in Kepler.gl and one in ShinyApp. 

1. we needed to collect the data and clean the data for the visualizations. Predicitons were randomized given that they are based on a proprietary model. Not too much information can be said about this method. 

2. Then, we created the visualization for the Census data in Kepler.gl. A lot of processing was done initially. This included using a Census API and cleaning the data at the census tract level. Unfortunately, this resulted in a huge amount of data that would not load fast enog. Moreover, we felt that the functionality of Kepler.gl could give users the abitlity to really explore the data they chose. We included only data relevant to the discussion of properties. 
 - Change the basemap
 - Style the census tract polygons 
 - Modify the tool tip to include the following pieces of information: population, population density, median household income, income growth rate, population growth rate, census rent, rent affordability ratio, renter proportion, and units per capita. 


3. Finally, we created the visualization for the Rent Prediction date in a Shiny app. 
 - To do this, we first created an account on Shinyapps.io which would allow us to store and run our final app on webpage. Using 'rsconnect' we were able to set the account information within RStudio. 
 - Instead of using an Rmarkdown we created an Shiny Web App. 
 - Define UI for application. 
   + We started with setting the theme of the UI using one of the custom Bootstrap Sass themes. 
   + Then, we set the application title. 
   + Created a sidebar panel with a dropdown menu and slider. The dropdown menu allows the user to choose from the following choices: Number of Properties, Mean Current Effective Rent, Year over Year Effective Rent Growth Rate, and Predicted Five Year Average Effective Rent Growth Rate. 
   + Within the UI, how a plot of the generated distribution
 - Define server logic required to draw the map. 
   + Modify the data displayed using the input choice 
   + Modify the legend using the input choice 
   + Create the desired map  



## Results
#### Using Kepler.gl
For the census explorer map hosted in Kepler.gl please navigate to this [link](https://kepler.gl/demo/map?mapUrl=https://dl.dropboxusercontent.com/s/2o334e8zxyzbyp0/keplergl_2q1fwt.json)
To add a filter:
 - Select Filters from the left navigation bar. 
 - The Filters panel displays the list of existing filters, color-coded by dataset. To create a new filter, Click Add Filter.
 - Choose a dataset, and then a field on which to filter your data. Filter values are defined by field data type (number, string, timestamp, etc.). 
 - Your filter is applied to your map as soon as you specify the field and value.
 - Delete a filter anytime by clicking the trashcan to the right of the filter you wish to delete.
To change the Base map:
 - Select BaseMap from the right navigation bar. 
 - Open the base map style drop down menu to change map color scheme and imagery. Options include:
    + Dark: dark base map with light-colored text.
    + Light: light base map with dark-colored text.
To modify the tooltip (the displayed metrics when hovering over a data point):
-Choose which fields are displayed from the tooltip config menu.

#### Using RShiny 
For the submarket effective rent map hosted in RShiny please navigate to this [link](https://ryan-brown.shinyapps.io/OriginViz/?_ga=2.82723859.406696026.1622923111-1591203086.1622923111)
To choose a variable to display:
- Use the dropdown menu to select
To modify the range:
- Use the two buttons of the slider 



## Discussion of Results/Findings/Main Highlights

## Limitations, Future Work, Conclusion

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details
