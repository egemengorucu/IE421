library(shiny)
library(datasets)
library(ggplot2)





mpgData <- mtcars
mpgData$am <- factor(mpgData$am, labels = c("Automatic", "Manual"))

shinyApp(ui, server)
# Define UI for miles per gallon app ----
ui <- fluidPage(
  
  
  # App title ----
  titlePanel("IE421HW3-EGEMEN GÖRÜCÜ_115203042 "),
  titlePanel("Miles Per Gallon"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      # Input: Selector for variable to plot against mpg ----
      selectInput("variable", "Variable:",
                  c("Cylinders" = "cyl",
                    "Transmission" = "am",
                    "Gears" = "gear")),
      
      # Input: Checkbox for whether outliers should be included ----
      checkboxInput("outliers", "Show outliers", TRUE)
      
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      
      # Output: Formatted text for caption ----
      h3(textOutput("caption")),
      
      # Output: Plot of the requested variable against mpg ----
      plotOutput("mpgPlot")
      
    )
  )
)

# Define server logic to plot various variables against mpg ----
server <- function(input, output) {
  
  # Compute the formula text ----
  # This is in a reactive expression since it is shared by the
  # output$caption and output$mpgPlot functions
  formulaText <- reactive({
    paste("mpg ~", input$variable)
  })
  
  # Return the formula text for printing as a caption ----
  output$caption <- renderText({
    formulaText()
  })
  
  # Generate a plot of the requested variable against mpg ----
  # and only exclude outliers if requested
  output$mpgPlot <- renderPlot({
    ggplot(mpgData,aes(x=mpg)) + geom_histogram(binwidth=6, fill="pink", colour="green") +
      facet_wrap(input$variable, ncol=1)
  })
  
}

# Create Shiny app ----
shinyApp(ui, server)
