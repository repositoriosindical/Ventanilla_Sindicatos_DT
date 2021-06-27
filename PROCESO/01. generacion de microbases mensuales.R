


## Cargar paquetes
library(readxl)
library(tidyverse)
library(lubridate)


#### I Con esta función se crea una micro base con un proxy de sindicatos activos para un periodo de referencia ####

base<-read_excel("INPUT/archivo_sindicatos_limpia.xlsx")

ano<-"2016"
mes<-"01"

proxy_2016_01 <- base %>% filter( (glosa=="ACTIVO" & ymd("2016-01-31")>=ymd(FechaConstitucion) )  |
                                    glosa!="ACTIVO" & (ymd("2016-01-01")<=FechaUltimaDirectiva) & 
                            ymd("2016-01-31")>=ymd(FechaConstitucion) )

## El dato oficial de la DT señala que en 2016 habían 11.653 sindicatos activos. En nuestro caso son 11.819 en enero de 2016. 
#No estamos tan alejados. 

## Sindicatos activos en enero de 2016
nrow(proxy_2016_01)


#### II. Funcion para preguntar por sindicatos activos en cada periodo ####

ano<-"1990"
mes<-"12"
dias<-days_in_month(paste0(ano,"-",mes,"-","01")) %>% as.character()

assign(
  paste0("proxy_",ano,"_",mes), 
  base %>% filter( (glosa=="ACTIVO" & ymd(paste0(ano,"-",mes,"-",dias))>=ymd(FechaConstitucion) )  |
       glosa!="ACTIVO" & (ymd(paste0(ano,"-",mes,"-","01"))<=FechaUltimaDirectiva) & 
       ymd(paste0(ano,"-",mes,"-",dias))>=ymd(FechaConstitucion) )
       )


#### III. Funcion para hacer micro bases para todo el periodo ####

fecha<-data.frame(ano=c(rep(1920:2020,each=12),rep(2021,each=3)),
                  mes=c(rep(1:12,(2020-1920+1)),1,2,3))

for(i in 1:nrow(fecha)){

ano<-as.character(fecha[i,1])
mes<-as.character(fecha[i,2])
dias<-days_in_month(paste0(ano,"-",mes,"-","01")) %>% as.character()

assign(
  paste0("proxy_",ano,"_",mes), 
  base %>% filter( (glosa=="ACTIVO" & ymd(paste0(ano,"-",mes,"-",dias))>=ymd(FechaConstitucion) )  |
                     glosa!="ACTIVO" & (ymd(paste0(ano,"-",mes,"-","01"))<=FechaUltimaDirectiva) & 
                     ymd(paste0(ano,"-",mes,"-",dias))>=ymd(FechaConstitucion) )
)

}

remove(base,base2,duplicados,numextract,ano,dias,i,mes)



get(
  fecha[1,] %>% mutate(base=paste0("proxy_",ano,"_",mes)) %>% select(base) %>% as.character()
)


## guardar bases producidas
bases<-ls(pattern = "proxy")
save(list=bases,file="INPUT/basesDT.Rdata")

