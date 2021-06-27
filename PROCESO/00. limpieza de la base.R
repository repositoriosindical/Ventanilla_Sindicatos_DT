
##############################################################
# Procesamiento bases de la ventanilla sindical DT #
##############################################################


## Cargar paquetes
library(readxl)
library(tidyverse)
library(lubridate)

## cargar bases.
base<-read_excel("INPUT/archivo_sindicatos_20210410.xlsx")

## Función para extraer solo números (ignorando dígito verificador)
library(stringr)
numextract <- function(string){ 
  str_extract(string, "\\-*\\d+\\.*\\d*")
} 

## Se crea variable RUT empresa
base$Empresa[1:5]
numextract(base$Empresa[1:5])
base$Rut<-numextract(base$Empresa)
## 22238 casos de 38279 tienen asociado rut de empresa
base %>% filter(!is.na(Rut)&Rut>0) %>% tally()

## 19827 casos de 25732 sindicatos de empresa, establecimiento o transitorio tienen asociado rut de empresa
base %>% filter(!is.na(Rut)&Rut>0) %>% 
  filter(!glosa1%in%c("SINDICATO INTER EMPRESA","SINDICATO INDEPENDIENTE"))%>% tally()
base %>% filter(!glosa1%in%c("SINDICATO INTER EMPRESA","SINDICATO INDEPENDIENTE"))%>% tally()

table(base$glosa1,useNA = "ifany")

## ¿Existen Casos duplicados? -> solo 22, se deja el caso que tenga rut de empresa
duplicados<-base$rsu_raf[duplicated(base$rsu_raf)]
duplicados<-base %>% filter(rsu_raf%in%duplicados)

base<-base %>% arrange(Rut)
base<-base[!duplicated(base$rsu_raf), ]

## Se crea variable actividad económica -> Códigos de Actividad Económica -> http://www.cmfchile.cl/institucional/seil/certificacion_cir1835_act_eco.php

base$Column1[1:5]
numextract(base$Column1[1:5])
base$CAE<-numextract(base$Column1)
## Solamente 4130 casos de 38279 tienen actividad económica
base %>% filter(!is.na(CAE)&CAE>0) %>% tally()

table(base$CAE)

base %>% filter(glosa=="ACTIVO") %>% count()

## Formato fecha

base<-base %>% mutate(FechaConstitucion=ymd(FechaConstitucion),
                      FechaDepositoEstatutos=ymd(FechaDepositoEstatutos),
                      FechaUltimaDirectiva=ymd_hms(FechaUltimaDirectiva))


#### Exportar limpia

library(openxlsx)
wb <- createWorkbook()
addWorksheet(wb, sheetName = "pestaña1", gridLines = TRUE)
writeData(wb = wb, sheet = "pestaña1", x = base)
saveWorkbook(wb = wb, file = "INPUT/archivo_sindicatos_limpia.xlsx", 
             overwrite = TRUE)

