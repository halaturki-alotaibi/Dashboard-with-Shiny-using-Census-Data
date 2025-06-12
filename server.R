library(shiny)
library(tidyverse)

adult <- read_csv("adult.csv")


names(adult) <- tolower(names(adult))



shinyServer(function(input, output) {
  
  df_country <- reactive({
    adult %>% filter(native_country == input$NATIVE_COUNTRY)
  })
  
  # TASK 5: 
  output$p1 <- renderPlot({
    if (input$graph_type == "histogram") {
      ggplot(df_country(), aes_string(x = input$continuous_variables)) +
        geom_histogram(binwidth = 5, fill = "skyblue", color = "black") +
        labs(
          x = input$continuous_variables,
          y = "Count",
          title = paste("Histogram of", input$continuous_variables)
        ) +
        facet_wrap(~prediction)  
    } else {
      ggplot(df_country(), aes_string(y = input$continuous_variables)) +
        geom_boxplot(fill = "lightgreen") +
        coord_flip() +
        labs(
          y = input$continuous_variables,
          title = paste("Boxplot of", input$continuous_variables)
        ) +
        facet_wrap(~prediction)
    }
  })
  
  # TASK 6: 
  output$p2 <- renderPlot({
    p <- ggplot(df_country(), aes_string(x = input$categorical_variable)) +
      labs(
        x = input$categorical_variable,
        y = "Count",
        title = paste("Bar Chart of", input$categorical_variable)
      ) +
      theme(
        axis.text.x = element_text(angle = 45, hjust = 1),
        legend.position = "bottom"
      )
    
    if (input$is_stacked) {
      p + geom_bar(aes(fill = prediction), position = "stack")
    } else {
      p + 
        geom_bar(aes_string(fill = input$categorical_variable), position = "dodge") +
        facet_wrap(~prediction)
    }
  })
  
})
