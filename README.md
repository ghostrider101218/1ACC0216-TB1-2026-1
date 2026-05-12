# Análisis de Datos: Hotel Booking Demand

## Objetivo del Trabajo
Realizar un análisis exploratorio (EDA) del dataset "Hotel Booking Demand"  para encontrar patrones de comportamiento, generando visualizaciones, preparando los datos y extrayendo conclusiones iniciales utilizando R/RStudio como herramienta de software.

## Alumnos Participantes
* **Vanessa Jazmin Barrientos Villalta** - [U202413287]
* **Matias Javier Del Castillo Mendoza** - [U202411305]
* **Sergio Sebastián Iglesias Pérez** - [U202316118]
* **Vivianne Fátima Rios Hasegawa** -[U202410135]

## Descripción del Dataset
El proyecto utiliza el dataset **Hotel Booking Demand**, el cual contiene información de 119,390 registros de reservas entre julio de 2015 y agosto de 2017 para dos tipos de hoteles: **City Hotel** (hotel urbano) y **Resort Hotel**.

> 📄 **Documentación Técnica:** Para un análisis detallado de cada una de las 32 variables, consulta el [PDF del Dataset](./documentacion_dataset.pdf).
## Conclusiones

### Análisis de la Demanda y Comportamiento
* **Preferencia por Hoteles Urbanos:** El **City Hotel** es el establecimiento con mayor volumen de reservas, superando al Resort Hotel por una diferencia de **11,388 registros**. Esto indica que los huéspedes priorizan la accesibilidad y la cercanía a centros urbanos.
* **Patrones de Estacionalidad:** 
    * En los **Resort Hotel**, la temporada alta es breve, concentrándose en julio y agosto (verano europeo).
    * En los **City Hotel**, la demanda es más estable y prolongada, extendiéndose desde mayo hasta octubre.
    * Ambos tipos de hoteles experimentan su temporada baja entre noviembre y febrero.
* **Perfil del Consumidor:** El cliente promedio es un adulto que realiza estancias cortas (3 a 4 noches) y tiene una baja demanda de servicios adicionales como estacionamiento (solo el 11.5% lo utiliza).

### Fidelización de Clientes
* **Baja Tasa de Retorno:** Se identificó que entre el **95% y 97%** de las reservas provienen de clientes nuevos. Esto sugiere que la lealtad a la marca es baja y que las decisiones de compra están motivadas principalmente por el precio y la ubicación, lo que abre una oportunidad para implementar estrategias de marketing y programas de lealtad.

## Recomendaciones
* **Segmentación en Visualizaciones:** Es fundamental analizar los datos de forma separada por tipo de hotel en futuros estudios, ya que mezclar ambos segmentos puede ocultar comportamientos específicos y tendencias críticas.
* **Optimización Basada en Datos:** Se recomienda utilizar los hallazgos (como el bajo uso de estacionamientos) para reasignar recursos operativos y mejorar la rentabilidad.
* **Documentación del Pre-procesamiento:** Para garantizar la integridad de los informes, se debe estandarizar el tratamiento de valores nulos (`N.A.`) y la limpieza de valores atípicos (*outliers*), asegurando que los análisis posteriores sean consistentes y comparables.

## Licencia
Este proyecto se distribuye bajo la licencia **MIT**. Para más detalles, consulte el archivo `LICENSE` en este repositorio.