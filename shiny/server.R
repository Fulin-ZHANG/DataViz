library(shiny)
library(shinydashboard)
library(dplyr)
library(ggplot2)
library(readr)
library(tidyverse)
server <- function(input, output) {
  survey_origin <- read_csv("../data/survey.csv")

  # Question 1
  survey_country_state_wi <- survey_origin %>%
    drop_na(work_interfere) %>%
    select(Country, state, work_interfere)

  survey_country_state_wi_nonna <- survey_country_state_wi %>%
    drop_na(state) %>%
    filter(Country == "United States")

  # Question 2
  survey_age_gender_wi <- survey_origin %>%
    drop_na(work_interfere, Age, Gender) %>%
    select(Age, Gender, work_interfere) %>%
    filter(Age > 10, Age < 100) %>%
    mutate(
      Gender_new = case_when(
        Gender == "Male" ~ "Male",
        Gender == "male" ~ "Male",
        Gender == "M" ~ "Male",
        Gender == "m" ~ "Male",
        Gender == "Man" ~ "Male",
        Gender == "man" ~ "Male",
        Gender == "Mail" ~ "Male",
        Gender == "maile" ~ "Male",
        Gender == "Make" ~ "Male",
        Gender == "Mal" ~ "Male",
        Gender == "Malr" ~ "Male",
        Gender == "msle" ~ "Male",
        Gender == "Female" ~ "Female",
        Gender == "female" ~ "Female",
        Gender == "F" ~ "Female",
        Gender == "f" ~ "Female",
        Gender == "Femake" ~ "Female",
        Gender == "femail" ~ "Female",
        Gender == "Women" ~ "Female",
        Gender == "women" ~ "Female",
      )
    ) %>%
    select(Age, Gender_new, work_interfere)
  survey_age_gender_wi[is.na(survey_age_gender_wi) == TRUE] <- "Other"

  ####  OutPut

  output$individus <- renderValueBox({
    valueBox(
      nrow(survey_origin), "Individus",
      icon = icon("list"),
      color = "red"
    )
  })

  output$dimensions <- renderValueBox({
    valueBox(
      ncol(survey_origin), "Dimensions",
      icon = icon("signal"),
      color = "yellow"
    )
  })

  output$plotSchema1 <- renderPlot(
    {
      if (input$selectRegion == "state") {
        plotQue1 <- ggplot(
          data = survey_country_state_wi_nonna,
          mapping = aes(
            x = state,
            fill = work_interfere,
            y = ..count..
          )
        ) +
          geom_bar(position = "fill") +
          coord_flip() +
          labs(
            x = "State",
            y = "Ratio",
            title = "Schema of state-work_interfere",
            subtitle = "--",
            caption = "Source: Survey"
          ) +
          theme(
            legend.position = "bottom",
            plot.background = element_rect(colour = "black", size = 3, linetype = 4, fill = "lightblue"),
            plot.title = element_text(colour = "black", face = "bold", size = 30, vjust = 1),
            plot.margin = unit(c(0.2, 0.2, 0.2, 0.2), "inches")
          )
      } else if (input$selectRegion == "Country") {
        plotQue1 <- ggplot(
          data = survey_country_state_wi,
          mapping = aes(
            x = Country,
            fill = work_interfere,
            y = ..count..
          )
        ) +
          geom_bar(position = "fill") +
          coord_flip() +
          labs(
            x = "Country",
            y = "Ratio",
            title = "Schema of Country-work_interfere",
            subtitle = "--",
            caption = "Source: Survey"
          ) +
          theme(
            legend.position = "bottom",
            plot.background = element_rect(colour = "black", size = 3, linetype = 4, fill = "lightblue"),
            plot.title = element_text(colour = "black", face = "bold", size = 30, vjust = 1),
            plot.margin = unit(c(0.2, 0.2, 0.2, 0.2), "inches")
          )
      }
      print(plotQue1)
    },
    width = "auto",
    height = 700
  )

  output$plotSchema2 <- renderPlot({
    if (input$selectAttribute == "age") {
      plotQue2 <- ggplot(data = survey_age_gender_wi, mapping = aes(
        x = work_interfere, y = Age, fill = work_interfere
      )) +
        geom_violin() +
        labs(
          title = "ViolinPlot of Age Distribution", x = "work_interfere",
          y = "Age"
        )
    } else if (input$selectAttribute == "gender") {
      plotQue2 <- ggplot(survey_age_gender_wi, aes(x = work_interfere, y = Age, color = Gender_new)) +
        geom_boxplot(outlier.colour = "orange", outlier.shape = 19, outlier.size = 1.5) +
        scale_color_manual(values = c("#999999", "#E69F00", "#56B4E9"))

      plotQue2 + theme(
        legend.position = "bottom", panel.background = element_rect(fill = "white"),
        plot.background = element_rect(fill = "skyblue")
      ) +
        labs(title = "BoxPlot of Age and Gender Distribution", x = "Work Interfere", y = "Age")
    }
    print(plotQue2)
  }, )


  survey <- read_csv("../data/survey.csv")
  # pre
  survey <- survey %>% filter(Age > 0) %>% filter(Age < 200) %>%mutate(
    Gender_new = case_when(
      Gender == "Male" ~ "Male",
      Gender == "male" ~ "Male",
      Gender == "M" ~ "Male",
      Gender == "m" ~ "Male",
      Gender == "Man" ~ "Male",
      Gender == "man" ~ "Male",
      Gender == "Mail" ~ "Male",
      Gender == "maile" ~ "Male",
      Gender == "Make" ~ "Male",
      Gender == "Mal" ~ "Male",
      Gender == "Malr" ~ "Male",
      Gender == "msle" ~ "Male",
      Gender == "Female" ~ "Female",
      Gender == "female" ~ "Female",
      Gender == "F" ~ "Female",
      Gender == "f" ~ "Female",
      Gender == "Femake" ~ "Female",
      Gender == "femail" ~ "Female",
      Gender == "Women" ~ "Female",
      Gender == "women" ~ "Female",
    )
  )
  
  survey_distribute_time <- survey %>%
    mutate(date = as.Date(survey$Timestamp)) %>%
    group_by(date) %>%
    summarise(n = n())
  survey_distribute_age_gender <- survey %>% select(Age, Gender_new)
  ageLables <- cut(survey_distribute_age_gender$Age, breaks = c(0, 10, 20, 30, 40, 50, 60, 70), labels = c(1, 2, 3, 4, 5, 6, 7))
  survey_distribute_age_gender <- cbind(survey_distribute_age_gender, ageLables)
  head(survey_distribute_age_gender)
  survey_distribute_age_gender_summrize <- survey_distribute_age_gender %>%
    group_by(ageLables, Gender_new) %>%
    summarise(n = n()) %>%
    filter(!is.na(Gender_new), !is.na(ageLables))
  survey_distribute_age_gender_summrize
  # plot_age_distribute for home page
  output$plot_age_distribute <- renderPlot({
    ggplot(survey_distribute_age_gender_summrize, aes(x = ageLables, y = ifelse(Gender_new == "Male", n, -n), fill = Gender_new)) +
      geom_bar(stat = "identity") +
      scale_y_continuous(labels = abs, limits = c(-450, 450)) +
      xlab("age Range") +
      ylab("population") +
      coord_flip()
  })
  # Characteristics for hme page
  output$lines <- renderText({
    dim(survey)[1]
  })
  output$columns <- renderText({
    dim(survey)[2]
  })
  output$countries <- renderText({
    distinct(survey, Country) %>% lengths()
  })
  output$plot_distribute_time <- renderPlot({
    survey_distribute_time <- survey %>%
      mutate(date = as.Date(survey$Timestamp))
    survey_distribute_time %>% ggplot(aes(x = date, y = Age, colour = Gender_new)) + geom_point()
  })
  # Q7
  survey_mental_health_interview_obs_consequence <- survey %>% select(mental_health_interview, obs_consequence)

  output$plotQuestion7 <- renderPlot({
    ggplot(survey_mental_health_interview_obs_consequence, aes(x = obs_consequence, fill = mental_health_interview)) +
      geom_bar(position = input$select, colour = "black") +
      scale_fill_brewer(palette = "Pastel1")
  })
  # Q8
  survey_treatment_remote_work <- survey %>% select(remote_work, treatment)
  output$plotQuestion8 <- renderPlot({
    ggplot(survey_treatment_remote_work, aes(x = remote_work, fill = treatment)) +
      geom_bar(position = "fill",colour = "black") +
      scale_fill_brewer(palette = "Pastel1")
  })
  # Q9_1
  survey_collegues_employeurs <- survey %>%
    select(coworkers, supervisor) %>%
    mutate(
      val_co = case_when(
        coworkers == "No" ~ 0,
        coworkers == "Some of them" ~ 1,
        coworkers == "Yes" ~ 2,
      ),
      val_sup = case_when(
        supervisor == "No" ~ 0,
        supervisor == "Some of them" ~ 1,
        supervisor == "Yes" ~ 2,
      )
    ) %>%
    mutate(
      tendances = case_when(
        val_co > val_sup ~ "collegue",
        val_co == val_sup ~ "indifferent",
        val_co < val_sup ~ "superieur",
      )
    ) %>%
    group_by(tendances) %>%
    summarise(n = n())
  

  output$plotQ9_1 <- renderPlot({
    # pie(survey_collegues_employeurs$n, survey_collegues_employeurs$tendances)
    pie(survey_collegues_employeurs$n,main = "Collegues ou employeurs? ",survey_collegues_employeurs$tendances,col = rainbow(length(survey_collegues_employeurs$n)))
    legend("topright", c("Collegue","Indifferent","Superieur"), cex = 0.8,
           fill = rainbow(length(survey_collegues_employeurs$n)))
  })
  # only for coworkerss
  output$plotQ9_2 <- renderPlot({
    ggplot(survey, aes(x = coworkers)) +
      geom_bar()
  })
  # only for supervisor
  output$plotQ9_3 <- renderPlot({
    ggplot(survey, aes(x = supervisor)) +
      geom_bar()
  })
  output$plotQ9 <- renderPlot(input$selectQ9)
}
