
library(shiny)
library(leaflet)
library(dplyr)
library(shinyWidgets)
library(bslib)

census <- rgdal::readOGR("../OriginViz/gis3data.json")
save <- census

# Define UI for application that draws a histogram
ui <- fluidPage(
    theme = bs_theme(version = 4, bootswatch = "minty"),
    # Application title
    titlePanel("Origin Effective Rent Dashboard"),
    sidebarLayout(
        # Sidebar with a slider input for number of bins 
        sidebarPanel(
            helpText("Use this to analyze maps with 
        information on current, historic and projected effective rent."),
            
            selectInput("var", 
                        label = "Choose a variable to display",
                        choices = c("Number of Properties", 
                                    "Mean Current Effective Rent",
                                    "Year over Year Effective Rent Growth Rate", 
                                    "Predicted Five Year Average Effective Rent Growth Rate"),
                        selected = "Mean Current Effective Rent"),
            #Set initial range high to ensure no variables are filtered before initialization
            sliderInput("range", 
                        label = "Range of interest:",
                        min = -10000, max = 10000, value = c(-10000, 10000))
        ),
        
        mainPanel(leafletOutput(outputId =  "map"))
        
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    
    observe({
        v <- switch(input$var, 
                    "Number of Properties" = c(min(census$Number.of.Properties),max(census$Number.of.Properties)),
                    "Mean Current Effective Rent" = c(min(census$Mean.Current.Effective.Rent),max(census$Mean.Current.Effective.Rent)),
                    "Year over Year Effective Rent Growth Rate" = c(min(census$Year.over.Year.Effective.Rent.Growth.Rate, na.rm = TRUE),max(census$Year.over.Year.Effective.Rent.Growth.Rate, na.rm = TRUE)),
                    "Predicted Five Year Average Effective Rent Growth Rate" = c(min(census$Predicted.Five.Year.Average.Effective.Rent.Growth.Rate, na.rm = TRUE),max(census$Predicted.Five.Year.Average.Effective.Rent.Growth.Rate, na.rm = TRUE)))
        updateSliderInput(session =  getDefaultReactiveDomain(), "range", min = v[1], max = v[2], value = v)
    })
    
    
    output$map <- renderLeaflet({
        data <- switch(input$var, 
                       "Number of Properties" = census$Number.of.Properties,
                       "Mean Current Effective Rent" = census$Mean.Current.Effective.Rent,
                       "Year over Year Effective Rent Growth Rate" = census$Year.over.Year.Effective.Rent.Growth.Rate,
                       "Predicted Five Year Average Effective Rent Growth Rate" = census$Predicted.Five.Year.Average.Effective.Rent.Growth.Rate)
        
        legend <- switch(input$var, 
                         "Number of Properties" = "Num Prop",
                         "Mean Current Effective Rent" = "Rent ($)",
                         "Year over Year Effective Rent Growth Rate" = "YOY Rent (%)",
                         "Predicted Five Year Average Effective Rent Growth Rate" = "Pred 5 YoY (%)")
        
        
        census <- save
        
        census <- census[!is.na(data) & data >= as.double(input$range[1]) & data <= as.double(input$range[2]),]
        
        data <- switch(input$var, 
                       "Number of Properties" = census$Number.of.Properties,
                       "Mean Current Effective Rent" = census$Mean.Current.Effective.Rent,
                       "Year over Year Effective Rent Growth Rate" = census$Year.over.Year.Effective.Rent.Growth.Rate,
                       "Predicted Five Year Average Effective Rent Growth Rate" = census$Predicted.Five.Year.Average.Effective.Rent.Growth.Rate)
        factpal <- colorNumeric("PuBuGn", NULL, n = 7)
        leaflet(census,height=550, width=550) %>%
            addTiles() %>%
            #Switch stroke to True to see borders
            addPolygons(stroke = FALSE, smoothFactor = 0.2, fillOpacity = 0.7,color = "black", opacity = 0.1,
                        fillColor = ~factpal(data),
                        label = ~paste0("ID ", census$Submarket.ID, ": ",legend,": ",formatC(data, big.mark = ","))) %>%
            addLegend(title = legend, pal = factpal, values = ~data, opacity = 0.5)
        
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
