# Diccionario de Datos: Hotel Booking Demand

Este documento describe las variables del dataset utilizado para el análisis de reservas hoteleras.

| Variable | Tipo | Descripción |
| :--- | :--- | :--- |
| **hotel** | Categórico | Tipo de hotel en el que se agendó la reserva. |
| **adr** | Numérico | Tarifa diaria promedio (Suma de transacciones de alojamiento / Total de noches). |
| **adults** | Entero | Número de adultos en la reserva. |
| **agent** | Categórico | ID de la agencia de viajes que realizó la reserva. |
| **arrival_date_day_of_month** | Entero | Día del mes de la fecha de llegada. |
| **arrival_date_month** | Categórico | Mes de llegada (Enero a Diciembre). |
| **arrival_date_week_number** | Entero | Número de semana del año de la fecha de llegada. |
| **arrival_date_year** | Entero | Año de la fecha de llegada. |
| **assigned_room_type** | Categórico | Código del tipo de habitación asignado (puede variar del reservado por razones operativas). |
| **babies** | Entero | Número de bebés en la reserva. |
| **booking_changes** | Entero | Número de cambios realizados a la reserva hasta el check-in o cancelación. |
| **children** | Entero | Número de niños (incluye niños con y sin cargo). |
| **company** | Categórico | ID de la compañía/entidad responsable de la reserva o el pago. |
| **country** | Categórico | País de origen en formato ISO 3155–3:2013. |
| **customer_type** | Categórico | Categoría de reserva: Contract, Group, Transient (individual) o Transient-party. |
| **days_in_waiting_list** | Entero | Días que la reserva estuvo en lista de espera antes de ser confirmada. |
| **deposit_type** | Categórico | Garantía de depósito: No Deposit, Non Refund (pago total) o Refundable (pago parcial). |
| **distribution_channel** | Categórico | Canal de distribución (ej. TA: Agentes de Viajes, TO: Operadores Turísticos). |
| **is_canceled** | Categórico | Indica si la reserva fue cancelada (1) o no (0). |
| **is_repeated_guest** | Categórico | Indica si es un huésped recurrente (1) o no (0). |
| **lead_time** | Entero | Días transcurridos entre la fecha de reserva y la fecha de llegada. |
| **market_segment** | Categórico | Segmento de mercado (ej. TA: Agentes de Viajes, TO: Operadores Turísticos). |
| **meal** | Categórico | Paquete de comidas: Undefined/SC (sin comida), BB (desayuno), HB (media pensión), FB (pensión completa). |
| **previous_bookings_not_canceled** | Entero | Número de reservas previas no canceladas por el cliente. |
| **previous_cancellations** | Entero | Número de reservas previas canceladas por el cliente. |
| **required_card_parking_spaces** | Entero | Número de espacios de estacionamiento requeridos. |
| **reservation_status** | Categórico | Estado final: Canceled, Check-Out o No-Show. |
| **reservation_status_date** | Fecha | Fecha en la que se registró el último estado de la reserva. |
| **reserved_room_type** | Categórico | Código del tipo de habitación reservada originalmente. |
| **stays_in_weekend_nights** | Entero | Número de noches de fin de semana (Sábado o Domingo). |
| **stays_in_week_nights** | Entero | Número de noches de entre semana (Lunes a Viernes). |
| **total_of_special_requests** | Entero | Número de solicitudes especiales realizadas (ej. cama matrimonial o piso alto). |