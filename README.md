# Análisis de datos de la "ventanilla transparencia" de la Dirección del Trabajo

Se desarrolla un código para procesar y analizar el microdato de organizaciones sindicales de la [Ventanilla sindical de la Dirección del Trabajo](tramites.dirtrab.cl/VentanillaTransparencia/Transparencia/RerporteRRLLOrg.aspx). Así, se obtiene información depurada de cada sindicato constituido en el país desde 1920 hasta 2020, como número de socias y socios, fecha de constitución del sindicato, estado, fecha de último registro, tipo de sindicato, rut de la empresa a la que pertenece el sindicato, entre otras cuestiones.

El código de procesamiento se encuentra en `PROCESO/00. limpieza de la base.R` y en `PROCESO/01. generacion de microbases mensuales.R`. El código de análisis de los datos se encuentra en `ANALISIS/03. Series historicas a partir de micridato.rmd` y en la Minuta 1 se explican en simple estos procesos y se interpretan los datos más recientes.

Este repositorio es parte del proyecto [Repositorio de Estadísticas Sindicales (RES)](https://repositoriosindical.netlify.app/)

## Minuta 1. 

Se analizan los datos de la ventanilla de transparencia de la Dirección del Trabajo, con los cuales se construyen series históricas sobre la trayectoria de sindicatos y afiliados/as desde 2018 a 2021. Con esto se observa el efecto del estallido social y la pandemia del Covid-19 sobre la formación sindical. [Disponible para descagar](https://github.com/nicolasrattor/Ventanilla_Sindicatos_DT/raw/main/Minuta1/Minuta1.pdf). 

## En desarrollo

Con estos mismos datos se están elaborando otras minutas del Repositorio de Estadísticas Sindicales (RES). Una que calcula el número de sindicatos y afiliados en Chile para el periodo 1920-2010 (Minuta N°3) y otra sobre paralelismo sindical en las empresas.
