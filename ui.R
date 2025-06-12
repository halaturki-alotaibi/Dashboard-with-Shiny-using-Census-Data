library(shiny)

shinyUI(fluidPage(
  
 
  titlePanel("Trends in Demographics and Income"),
  
  p("Explore the difference between people who earn less than 50K and more than 50K. You can filter the data by country, then explore various demographic information."),
  
  
  fluidRow(
    column(12, 
           wellPanel(
             selectInput("NATIVE_COUNTRY", "Country:", 
                         choices = c("United-States", "Canada", "Mexico", "Germany", "Philippines"),
                         selected = "United-States"),
             tableOutput("data")  
           )
    )
  ),
  
  
  fluidRow(
    column(3, 
           wellPanel(
             p("Select a continuous variable and graph type (histogram or boxplot) to view on the right."),
             radioButtons("continuous_variables", "Continuous Variable:",
                          choices = c("age", "hours_per_week"),
                          selected = "age"),
             radioButtons("graph_type", "Graph Type:",
                          choices = c("histogram", "boxplot"),
                          selected = "histogram")
           )
    ),
    column(9,
           plotOutput("p1")
    )
  ),
  
  )
  fluidRow(
    column(3, 
           wellPanel(
             p("Select a categorical variable to view bar chart on the right. Use the check box to view a stacked bar chart combining the income levels."),
             radioButtons("categorical_variable", "Categorical Variable:",
                          choices = c("workclass", "education", "sex"),
                          selected = "workclass"),
             checkboxInput("is_stacked", "Stacked Bar Chart", FALSE),
             verbatimTextOutput("value")  
           )
    ),
    column(9,
           plotOutput("p2")
    )
  )
))
