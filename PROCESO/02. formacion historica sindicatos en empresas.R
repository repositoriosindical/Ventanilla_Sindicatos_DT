

#### EJEMPLOS CON EMPRESAS PARTICULARES ####

## Selección tiempo
fecha<-data.frame(ano=c(rep(1990:2020,each=12)),
                  mes=c(rep(1:12,(2020-1990+1))))

#### LIDER ####
sindicatos_lider<-data.frame(1:nrow(fecha),1:nrow(fecha),1:nrow(fecha))


for(i in 1:nrow(sindicatos_lider)){
  
  sindicatos_lider[i,] <- get(
    fecha[i,] %>% mutate(base=paste0("proxy_",ano,"_",mes)) %>% select(base) %>% as.character()
  ) %>% filter(str_detect(nombre,"LIDER|lider|Lider|WALMART|Walmart|walmart|WAL-MART|EKONO|Ekono|ekono")|
                 str_detect(Empresa,"LIDER|lider|Lider|WALMART|Walmart|walmart|WAL-MART|EKONO|Ekono|ekono")) %>% 
    mutate(afiliados=Socios+Socias) %>% select(Socios, Socias ,afiliados) %>% apply(2,sum)
  
}

sindicatos_lider<-sindicatos_lider %>% mutate(sindicatos=NA)

for(i in 1:nrow(sindicatos_lider)){
  
  sindicatos_lider[i,4] <- get(
    fecha[i,] %>% mutate(base=paste0("proxy_",ano,"_",mes)) %>% select(base) %>% as.character()
  ) %>% filter(str_detect(nombre,"LIDER|lider|Lider|WALMART|Walmart|walmart|WAL-MART|EKONO|Ekono|ekono")|
                 str_detect(Empresa,"LIDER|lider|Lider|WALMART|Walmart|walmart|WAL-MART|EKONO|Ekono|ekono")) %>% nrow()
  
}

sindicatos_lider<-sindicatos_lider %>% cbind(fecha) %>% mutate(fecha=ymd(paste0(ano,"-",mes,"-01")))

names(sindicatos_lider)<-c("Socios","Socias","Socios_as","Sindicatos","ano","mes","fecha")

sindicatos_lider %>% filter(fecha>=ymd("2000-01-01")) %>% ggplot(aes(x=fecha,y=Sindicatos))+geom_line()+theme_bw()+
  scale_x_date(date_labels = "%Y",date_breaks = "3 year",limits = as.Date(c("2000-01-01","2020-12-01")))

sindicatos_lider %>% filter(fecha>=ymd("2000-01-01")) %>% ggplot(aes(x=fecha,y=Socios_as))+geom_line()+theme_bw()+
  scale_x_date(date_labels = "%Y",date_breaks = "3 year",limits = as.Date(c("2000-01-01","2020-12-01"))) + 
  scale_y_continuous(labels=function(x) format(x, big.mark = ".", scientific = FALSE), limits = c(0,40000))

sindicatos_lider %>% filter(fecha>=ymd("2000-01-01")) %>% 
  pivot_longer(c(Socios,Socias)) %>% 
  ggplot(aes(x=fecha,y=value,color=name))+geom_line()+theme_bw()+
  scale_x_date(date_labels = "%Y",date_breaks = "3 year",limits = as.Date(c("2000-01-01","2020-12-01"))) + 
  scale_y_continuous(labels=function(x) format(x, big.mark = ".", scientific = FALSE), limits = c(0,25000))

sindicatos_lider %>% filter(fecha>=ymd("2000-01-01")) %>% ggplot(aes(x=fecha,y=Sindicatos))+geom_line()+theme_bw()+
  scale_x_date(date_labels = "%Y",date_breaks = "3 year",limits = as.Date(c("2000-01-01","2020-12-01"))) +
  labs(title="Sindicatos activos en Walmart Chile. 2000-2020.",caption = "Elaborado por Nicolás Ratto para https://repositoriosindical.netlify.app/")

library(openxlsx)
wb <- createWorkbook()
addWorksheet(wb, sheetName = "base mensual sindicatos_lider", gridLines = TRUE)
writeData(wb = wb, sheet = "base mensual sindicatos_lider", x = sindicatos_lider)
firma<-c("Elaborado por Nicolás Ratto para Repositorio de Estadísticas Sindicales (RES): https://repositoriosindical.netlify.app/",
         "En base a datos de la ventanilla sindical de la Dirección del Trabajo: http://tramites.dirtrab.cl/VentanillaTransparencia/Transparencia/RerporteRRLLOrg.aspx") %>% as.data.frame()
writeData(wb = wb, sheet = "base mensual sindicatos_lider", x = firma,startCol = 7, startRow = 2)
saveWorkbook(wb = wb, file = "../OUTPUT/base mensual sindicatos_lider anidada.xlsx", 
             overwrite = TRUE)


ggsave(
  plot = last_plot(),
  filename = "../OUTPUT/Graficos/sindicatos_lider_2000-2020.png",
  device = "png",
  dpi = "retina",
  units = "cm",
  width = 33,
  height = 17
)



#### JUMBO ####

sindicatos_jumbo<-data.frame(1:nrow(fecha),1:nrow(fecha),1:nrow(fecha))


for(i in 1:nrow(sindicatos_jumbo)){
  
  sindicatos_jumbo[i,] <- get(
    fecha[i,] %>% mutate(base=paste0("proxy_",ano,"_",mes)) %>% select(base) %>% as.character()
  ) %>% filter(str_detect(nombre,"JUMBO|Jumbo|jumbo")|
                 str_detect(Empresa,"JUMBO|Jumbo|jumbo")) %>% 
    mutate(afiliados=Socios+Socias) %>% select(Socios, Socias ,afiliados) %>% apply(2,sum)
  
}

sindicatos_jumbo<-sindicatos_jumbo %>% mutate(sindicatos=NA)

for(i in 1:nrow(sindicatos_jumbo)){
  
  sindicatos_jumbo[i,4] <- get(
    fecha[i,] %>% mutate(base=paste0("proxy_",ano,"_",mes)) %>% select(base) %>% as.character()
  ) %>% filter(str_detect(nombre,"JUMBO|Jumbo|jumbo")|
                 str_detect(Empresa,"JUMBO|Jumbo|jumbo")) %>% nrow()
  
}

sindicatos_jumbo<-sindicatos_jumbo %>% cbind(fecha) %>% mutate(fecha=ymd(paste0(ano,"-",mes,"-01")))

names(sindicatos_jumbo)<-c("Socios","Socias","Socios_as","Sindicatos","ano","mes","fecha")

sindicatos_jumbo %>% ggplot(aes(x=fecha,y=Socios_as))+geom_line()+theme_bw()+
  scale_x_date(date_labels = "%Y",date_breaks = "3 year",limits = as.Date(c("1990-01-01","2020-12-01"))) + 
  scale_y_continuous(labels=function(x) format(x, big.mark = ".", scientific = FALSE), limits = c(0,20000))

sindicatos_jumbo %>% filter(fecha>=ymd("1990-01-01")) %>% ggplot(aes(x=fecha,y=Sindicatos))+geom_line()+theme_bw() +
  labs(title="Sindicatos activos en Jumbo Chile. 1990-2020.",caption = "Elaborado por Nicolás Ratto para https://repositoriosindical.netlify.app/")

ggsave(
  plot = last_plot(),
  filename = "../OUTPUT/Graficos/sindicatos_jumbo_1990-2020.png",
  device = "png",
  dpi = "retina",
  units = "cm",
  width = 33,
  height = 17
)

