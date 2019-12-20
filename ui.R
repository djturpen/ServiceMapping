#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(DT)
library(shinyWidgets)
library(RCurl)
library(shinyjs)

url <- getURL("https://raw.githubusercontent.com/djturpen/ServiceMapping/master/ServiceMapping-v2.csv")
df <- read.csv(text = url)

df$Application <- as.character(df$Application)
df$Service.Dependency <- as.character(df$Service.Dependency)

# Define UI for application
shinyUI(fluidPage(
    
    

    # Application title
    titlePanel("Service Mapping"),

    # Sidebar options
    sidebarLayout(
        sidebarPanel(
            
            pickerInput("dependencyInput", "Dependency", choices = unique(df$Service.Dependency), options = list('actions-box' = TRUE), multiple = TRUE, selected = ''),
            pickerInput("applicationInput", "Application", choices = unique(df$Application), options = list('actions-box' = TRUE), multiple = TRUE, selected = '')
            
        ),

        # Show data table
        mainPanel((""),
         DTOutput('df'))
                  
                 
        
            
    )
))
