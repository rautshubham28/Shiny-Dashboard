library(shiny)
library(ggplot2)
library(DT)
library("readxl")
library(tidyr)

#Data set ----------------------------------------------------------
territory_distribution <- as.data.frame(read_excel("Weekly.xlsx", 1))
Quaterly_leads <- as.data.frame(read_excel("Weekly.xlsx", 2))
Categorywise_leads <- as.data.frame(read_excel("Weekly.xlsx", 3))



plot_server <- function(id, data){
  moduleServer(id, function(input, output, session){
    output$volumeplot <- renderPlot({
      ggplot(data, aes(x=QUARTAR, y=value, fill=Rates)) +
        geom_bar(stat='identity', position='dodge')
    })
  })
}

plot_server1 <- function(id, data){
  moduleServer(id, function(input, output, session){
    output$volumeplot1 <- renderPlot({
      ggplot(data, aes(x=QUARTAR, y=value, fill=Leads)) +
        geom_bar(stat='identity', position='dodge')
    })
  })
}


table_server <- function(id, data) {
  moduleServer(id, function(input, output, session){
    output$Table <- renderDataTable({
      data
    })
  })
}


shinyServer(
  function(input, output){
    
    #Dashboard ---------------------------------------------------------
    table_server("table1", data = territory_distribution )
    
    df <- pivot_longer(Quaterly_leads[c(2,5:6)], cols=c('Visit Rate', 'Call Rate'), names_to='Rates', values_to="value")
    plot_server("plot1", data = df)
    
    df1 <- pivot_longer(Quaterly_leads[2:4], cols=c('# Total Leads', '# Distinct Leads'), names_to='Leads', values_to="value")
    plot_server1("plot2", data = df1)
    
    #Table -------------------------------------------------------------
    
    table_server("table2", data = Categorywise_leads)
    
    
  }
)