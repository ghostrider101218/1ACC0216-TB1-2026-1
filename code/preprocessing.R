rm(list=ls(all=TRUE))
graphics.off()
cat("\014")


#CARGAR DATOS =================================================================
install.packages("plotly", dependencies=TRUE)
install.packages("ggplot2", dependencies=TRUE )
install.packages("dplyr", dependencies=TRUE)
library(plotly)
library(dplyr)
library(ggplot2)
setwd("C:/Users/Proyectos/Downloads")
data <- read.csv("hotel_bookings.csv", header = TRUE, stringsAsFactors = FALSE)

#INSPECCIONAR DATOS ===========================================================
str(data) #Resumen de la estructura del dataset
summary(data) #Resumen del tipos de datos utilizados 
head(data) #Visualización de las primeras filas del dataset que permite comprender la organización de este
duplicated(data) #Identificación de datos duplicados 

data <- data[!duplicated(data),]
data[data == ""] <- NA
data[data == "NULL"] <- NA
data[data == "null"] <- NA
data[data == "undefined"] <- NA
data[data == "Undefined"] <- NA
data[data == "none"] <- NA


#TRANSFORMACION DE VARIABLES --------------------------------------------------
#date
data$reservation_status_date <- as.Date(data$reservation_status_date)
# Categorical
data$hotel <- as.factor(data$hotel) # 1
data$is_canceled <- as.factor(data$is_canceled) #2
data$arrival_date_month <- as.factor(data$arrival_date_month) #12
data$meal <- as.factor(data$meal) # 5
data$market_segment <- as.factor(data$market_segment) #8
data$distribution_channel <- as.factor(data$distribution_channel) #5
data$is_repeated_guest <- as.factor(data$is_repeated_guest) #2
data$reserved_room_type <- as.factor(data$reserved_room_type) #10
data$assigned_room_type <- as.factor(data$assigned_room_type) #12
data$deposit_type <- as.factor(data$deposit_type)#3
data$customer_type <- as.factor(data$customer_type) #4
data$reservation_status <- as.factor(data$reservation_status) #3

summary(data)


## En observación, muchas categorías
data$agent <- as.factor(data$agent) #334
data$company <- as.factor(data$company) #353
data$country <- as.factor(data$country) #178

#PRE PROCESAR DATOS ===========================================================
# i. Resumir estadísticas básicas ---------------------------------------------
summary(data)

# ii. Identificar datos faltantes ---------------------------------------------
colSums(is.na(data))

# iii. Tratamiento de datos faltantes -----------------------------------------
tabla_na_children <- data[is.na(data$children), ]  #Filtrar los datos N. A. de la 
fila children
tabla_na_meal <- data[is.na(data$meal), ]  
tabla_na_company <- data[is.na(data$company), ]  
tabla_na_country <- data[is.na(data$country), ]  
tabla_na_agent <- data[is.na(data$agent), ]  
tabla_na_distribution_chanel <- data[is.na(data$distribution_chanel), ]  

tabla_na_children
tabla_na_meal
tabla_na_company
tabla_na_country
tabla_na_agent
tabla_na_distribution_chanel



data$children[is.na(data$children)] <- 0  # convertimos los datos N. A a 0 -> imputación valor constante
tabla_na_children <- data[is.na(data$children), ]   #Verificar los datos que contienen N.A (actualmente 0)
tabla_na_children


# inputación por valor 
data$agent[is.na(data$agent)] <- "None"
data$company[is.na(data$company)] <- "None"
data$country[is.na(data$country)] <- "Unknown"
data$meal[is.na(data$meal)] <- "Undefined"
data$distribution_channel[is.na(data$distribution_channel)] <- "Undefined"


# iv. Detección de outliers ---------------------------------------------------
summary(data$adr) # Para visualizar estadísticas de la variable 'adr'
summary(data$lead_time) # Para visualizar estadísticas de la variable 'lead_time'
boxplot(data$adr, main = "Detección de Outliers en Tarifa Diaria (ADR)", ylab = "ADR", 
        col = "lightblue", 
        outcol = "red")  # Gráfico de caja para identificar OUTLIERS.

boxplot(data$lead_time, main = "Detección de Outliers LEAD TIME", ylab = "lead_time", 
        col = "lightgreen", 
        outcol = "red")  # Gráfico de caja para identificar OUTLIERS.


# v. Tratamiento de outliers ---------------------------------------------------
data <- data[data$adr >= 0, ] # para mantener datos correctos (x<0 no existe)

#winsorizacion de adr
p99_adr <- quantile(data$adr, 0.99, na.rm = TRUE)
data$adr[data$adr > p99_adr] <- p99_adr
data <- data[data$adr >= 0, ]

# winsorizacion de lead_time
p99_lead <- quantile(data$lead_time, 0.99, na.rm = TRUE)
data$lead_time[data$lead_time > p99_lead] <- p99_lead

# visualización
summary(data$adr) # Para visualizar estadísticas de la variable 'adr'
boxplot(data$adr, main = "Detección de Outliers en Tarifa Diaria (ADR)", ylab = "ADR", 
        col = "lightblue", 
        outcol = "red")  # Gráfico de caja para identificar OUTLIERS.

boxplot(data$lead_time, main = "Detección de Outliers LEAD TIME", ylab = "lead_time", 
        col = "lightgreen", 
        outcol = "red")  # Gráfico de caja para identificar OUTLIERS.

#Guardar el dataset preprocesado
write.csv(data, "hotel_bookings_v2.csv", row.names = FALSE, quote = FALSE)