# Public Multifamily Data Visulization 

## Goals and Objectives 

Our goal is to create a suite of visualizations pertaining to predictive analytics for Multifamily Real Estate as well as key variables. To do this our objectives are as follows: 

* Leverage Kepler GL to allow for fast exploration of vast amounts of census data
* Create an R-Shiny Application that maps key multifamily variables: supply (number of properites), current effective rent, YoY effective rent and projected effective rent growth. 
* Provide clear explanition on each variable as well as an overview of methods used in creating prediction


## Background, Motivation

Real Estate Investment Trusts, (REITS), specifically those which focus on Multifamily properties, are one of the few financial institutions yet to widely adopt advances in geocomputation yet they simultaneously stand to benefit from such advances given the inherently spatial process of selecting assets whether they be for development or acquisition. Moreover, given the wide array of different neighborhoods within the United States it is often difficult for smaller firms to adequately understand the makeup of each area for which they may consider investing. Therefore, a better understanding of place via an all inclusive dashboard will help optimize deal flow. Moreover, an understanding of which areas will see the highest rent growth, arguably the most important metric for whether or not an investment is successful, allows for firms to narrow their scope leading to a more effective utilization of capital. 

## Data Sources, Spatial and Temporal Scale

The spatial scale is property level although we aggregate up to a submarket scale. The temporal scale is 2008 to 2021. 
The data sources of interest include 2019 / 2018 Five Year Average ACS data with the following variables: YOY (Year over Year) Population, Population Density, Renters, Owners, Median Household Income, YOYHouseholdIncome, Median Age, PercentWhite, PercentBlack, PercentHispanic, PercentAsian, PercentAmericanIndian, PercentTwoOrMoreRaces, PercentLessThanHighShcool, PercentHighSchool, PercentSomeCollege, PercentBachlores, PercentGraduate, PercentMarried, RetailReviews 


## Methods Used 

The two softwares we will be using to create our maps is Kepler.gl and ShinyApp.
To visualize the public data, we decided to create an animated map for Census data.
To identify point patterns, we decided to create an interactive map displaying submarkets as polygons and properties as points. 


## Results
### Using Kepler.gl

For the census explorer map hosted in Kepler.gl please navigate to this [link](https://kepler.gl/demo/map?mapUrl=https://dl.dropboxusercontent.com/s/2o334e8zxyzbyp0/keplergl_2q1fwt.json)
 
### Using RShiny 
For the submarket effective rent map hosted in RShiny please navigate to this [link](https://ryan-brown.shinyapps.io/OriginViz/?_ga=2.82723859.406696026.1622923111-1591203086.1622923111)


## Discussion of Results/Findings/Main Highlights

## Limitations, Future Work, Conclusion

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details
