rm(list=ls(all=TRUE))
graphics.off()
cat("\014")
#HOLA 

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


#VISUALIZACIÓN DE DATOS =======================================================

#I. ¿Cuántas reservas se realizan por tipo de hotel considerando solo aquellas no canceladas? ¿Qué tipo de hotel es el más preferido?-----

#Filtro de datos con reservas únicamente confirmadas 
reservas_confirmadas <- data %>%
  filter(is_canceled == 0)
#Tabla Reservas confirmadas Vs Hotel
g1 <- ggplot(data= reservas_confirmadas, mapping= aes(x = hotel, fill = hotel)) +
  geom_bar() + labs(title = "Gráfico Reservas por Hotel", x = "Tipo de hotel", y = "Cantidad de reservas confirmadas") +
  geom_text(stat = 'count', mapping= aes(label = after_stat(count))) +
  theme_minimal()
ggplotly(g1)


#II. ¿Está aumentando la demanda con el tiempo?----------------------------------------------------------------------------
reservas_confirmadas <- data %>%
  filter(is_canceled == 0)
#Ordenamiento de meses de manera cronológica
reservas_confirmadas$arrival_date_month <- factor(reservas_confirmadas$arrival_date_month, 
                                                  levels = month.name)
#Resumen de las reservas confirmadas, agrupadas por año y mes
resumen_anual <- reservas_confirmadas %>%
  group_by(Año = as.factor(arrival_date_year), Mes = arrival_date_month) %>%
  summarise(Total = n())

#Creación de gráfico de líneas agrupadas por cada año
ggplot(resumen_anual, aes(x = Mes, y = Total, group = Año, color = Año)) +
  geom_line(size = 1) + geom_point(size = 2)+
  theme_minimal() +
  labs(
    title = "Evolución Temporal de la Demanda",
    subtitle = "Comparativa mensual de reservas confirmadas por año",
    x = "Mes de llegada",
    y = "Número de Reservas",
    color = "Año"
  ) +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1),
    panel.grid.major.x = element_blank()
  )


#III. ¿Cuáles son las temporadas de reservas (alta, media, baja)?-----------------------------------------------------------
# Orden cronológico de los meses
meses_orden <- c("January", "February", "March", "April", "May", "June",
                 "July", "August", "September", "October", "November", "December")

data$arrival_date_month <- factor(
  data$arrival_date_month,
  levels = meses_orden
)

#Grafico del Resort hotel
resort_data <- data %>%
  filter(hotel == "Resort Hotel") %>%
  group_by(Año = arrival_date_year,
           Mes = arrival_date_month) %>%
  summarise(Total_Reservas = n(), .groups = "drop")

ggplot(resort_data,
       aes(x = Mes,
           y = as.factor(Año),
           fill = Total_Reservas)) +
  
  geom_tile(color = "white", linewidth = 1) +
  
  scale_fill_gradient(low = "#D4EFDF", high = "#145A32") +
  
  labs(
    title = "Temporadas de Reservas - Resort Hotel",
    subtitle = "Cantidad total de reservas por año y mes",
    x = "Mes",
    y = "Año",
    fill = "Reservas"
  ) +
  
  theme_minimal() +
  
  theme(
    plot.title = element_text(face = "bold", size = 14),
    axis.text.x = element_text(angle = 45, hjust = 1),
    panel.grid = element_blank()
  )

#Grafico del city hotel
city_data <- data %>%
  filter(hotel == "City Hotel") %>%
  group_by(Año = arrival_date_year,
           Mes = arrival_date_month) %>%
  summarise(Total_Reservas = n(), .groups = "drop")

ggplot(city_data,
       aes(x = Mes,
           y = as.factor(Año),
           fill = Total_Reservas)) +
  
  geom_tile(color = "white", linewidth = 1) +
  
  scale_fill_gradient(low = "#FCF3CF", high = "#B9770E") +
  
  labs(
    title = "Temporadas de Reservas - City Hotel",
    subtitle = "Cantidad total de reservas por año y mes",
    x = "Mes",
    y = "Año",
    fill = "Reservas"
  ) +
  
  theme_minimal() +
  
  theme(
    plot.title = element_text(face = "bold", size = 14),
    axis.text.x = element_text(angle = 45, hjust = 1),
    panel.grid = element_blank()
  )


#IV. ¿Cuál es la duración promedio de las estancias por tipo de hotel?------------------------------------------------------



#V. ¿Cuántas reservas incluyen niños y/o bebés?-----------------------------------------------------------------------------





#VI. ¿Es importante contar con espacios de estacionamiento?-----------------------------------------------------------------
#Filtro de reservas confirmadas 
reservas_confirmadas <- data%>%
  filter(data$is_canceled == 0)
#Agrupación de datos si se requirió de estacionamiento (Sí, No)
#Agregación de atributo porcentaje de acuerdo a las reservas totales 
resumen_parking <- reservas_confirmadas %>%
  count(Necesita_Parking = ifelse(required_car_parking_spaces > 0, "Sí", "No")) %>%
  mutate(Porcentaje = round(n / sum(n) * 100, 1))

#Creación de gráfico circular con el porcentaje presentado
ggplot(resumen_parking, aes(x = "", y = n, fill = Necesita_Parking)) +
  geom_col(width = 1) +
  coord_polar("y") +
  theme_void() +
  scale_fill_manual(values = c("Sí" = "lightgreen", "No" = "darkred")) +
  labs(title = "Gráfico Uso del Estacionamiento en las reservas",
       fill = "¿Se ha solicitado estacionamiento?") +
  geom_text(aes(label = paste0(Porcentaje, "%")), 
            position = position_stack(vjust = 0.5), 
            size = 6)


#VII. ¿En qué meses del año se producen más cancelaciones de reservas?------------------------------------------------------
# 1. Se filtran solo las reservas que fueron canceladas (is_canceled == 1) y contar por mes
cancelaciones_por_mes <- data %>%
  filter(is_canceled == 1) %>%
  count(arrival_date_month, name = "total_cancelaciones")

# 2. Se ordenan los meses de forma cronológica (¡Clave para que el gráfico tenga sentido!)
meses_orden <- c("January", "February", "March", "April", "May", "June", 
                 "July", "August", "September", "October", "November", "December")

cancelaciones_por_mes$arrival_date_month <- factor(cancelaciones_por_mes$arrival_date_month, 
                                                   levels = meses_orden)

# 3. Se crean el Gráfico de Barras con ggplot2
ggplot(cancelaciones_por_mes, aes(x = arrival_date_month, y = total_cancelaciones, fill = total_cancelaciones)) +
  geom_bar(stat = "identity", color = "black") +
  scale_fill_gradient(low = "lightblue", high = "red") + # Colores para resaltar los picos
  theme_minimal() +
  labs(title = "Cantidad de Reservas Canceladas por Mes",
       x = "Mes de Llegada",
       y = "Número Total de Cancelaciones",
       fill = "Cancelaciones") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) 


#VIII. ¿Cómo ha evolucionado el porcentaje de huéspedes nuevos cada año?---------------------------------------------------
# Calcular porcentaje de huéspedes nuevos
huespedes_nuevos <- hotel %>%
  group_by(arrival_date_year) %>%
  summarise(
    total = n(),
    nuevos = sum(is_repeated_guest == 0)
  ) %>%
  mutate(
    porcentaje = round((nuevos / total) * 100, 1)
  )

# Gráfico
ggplot(huespedes_nuevos,
       aes(x = factor(arrival_date_year),
           y = porcentaje,
           fill = factor(arrival_date_year))) +
  
  geom_col(width = 0.6) +
  
  geom_text(aes(label = paste0(porcentaje, "%")),
            vjust = -0.5,
            size = 5) +
  
  labs(
    title = "Porcentaje de huéspedes nuevos por año",
    subtitle = "Evolución anual de clientes no recurrentes",
    x = "Año",
    y = "Porcentaje de huéspedes nuevos"
  ) +
  
  ylim(0, 110) +
  
  theme_minimal() +
  
  theme(
    legend.position = "none",
    plot.title = element_text(size = 16, face = "bold"),
    plot.subtitle = element_text(size = 11),
    axis.text = element_text(size = 11),
    axis.title = element_text(size = 12)
  )
