#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
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

#Read in data from Github
url <- getURL("https://raw.githubusercontent.com/djturpen/ServiceMapping/master/ServiceMapping-v2.csv")
df <- read.csv(text = url)

#Converts the two input fields we need from factors to characters
df$Application <- as.character(df$Application)
df$Service.Dependency <- as.character(df$Service.Dependency)


# Define server logic
shinyServer(function(input, output, session) {

# Remove input of category when other category has an input
   observeEvent(input$dependencyInput, {
      updatePickerInput(session, 'applicationInput', selected = ' ' )
   })
   
   observeEvent(input$applicationInput, {
      updatePickerInput(session, 'dependencyInput', selected = ' ' )
   })
   
   
   updatePickerInput(session, 'applicationInput', choices = c(unique(df$Application)))
   updatePickerInput(session, 'dependencyInput', choices = c(unique(df$Service.Dependency)))

# Subset data based on chosen input
   df_subset <- shiny::reactive({
       a <- subset(df, df$Application %in% input$applicationInput)
       return(a)
   })
   
   df_subset2 <- shiny::reactive({
      a <- subset(df, df$Service.Dependency %in% input$dependencyInput)
      return(a)
   })
   
# Render DataTable based on chosen input
   output$df <- DT::renderDT({
      if(!is.null(input$applicationInput)){
         df_subset()
      }
      else if(!is.null(input$dependencyInput)){
         df_subset2()
      }
      }, options = list(pageLength = 20))
         
   })
