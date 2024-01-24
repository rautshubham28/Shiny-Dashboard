library(shiny)
library(shinydashboard)
library(DT)



barplotUI <- function(id){
  plotOutput(NS(id,"volumeplot"))
}

barplotUI1 <- function(id){
  plotOutput(NS(id,"volumeplot1"))
}

tableUI <- function(id){
  ns <- NS(id)
  dataTableOutput(outputId = ns("Table"))
}


dashboardPage(
  dashboardHeader(title = "Dashboard"),
  dashboardSidebar(
                   sidebarMenu(
                     menuItem("Lead Summary", tabName = "dashboard", icon = icon("dashboard")),
                     menuItem("Category Summary", tabName = "table", icon = icon("th")))),
  dashboardBody(
    tabItems(
      tabItem("dashboard",
              fluidRow(
                box(width = 12, status = "primary", tableUI("table1"))
              ),
              fluidRow(
                box(title = "Rate", width = 6,
                    barplotUI("plot1")
                ),
                box(title = "Leads", width = 6,
                    barplotUI1("plot2")
                )
              )
              ),
      tabItem("table",
              fluidRow(
                box(width = 12, status = "primary", tableUI("table2"))
              )
      )
      
      )
      
    )
)
