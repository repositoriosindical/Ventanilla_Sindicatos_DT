# Análisis de datos de la "ventanilla transparencia" de la Dirección del Trabajo

Se consigue estimar el número de sindicatos activos y de trabajadores afiliados/as en cada mes entre 1920 y diciembre de 2020. [Acá se observa tabulado](OUTPUT/base mensual afiliados_tipo anidada.xlsx) de trabajadores afiliados por tipo de sindicato.

Se elabora un procedimiento para observar la formación y evolución sindical en empresas o holdings particulares. Por ejemplo, en [Walmart](OUTPUT/Graficos/sindicatos_lider_2000-2020.png) o en [Jumbo](OUTPUT/Graficos/sindicatos_jumbo_1990-2020.png).

Dentro de la carpeta `OUTPUT` se pueden visualizar otros productos relacionados. 

## Presentación del proceso

Se descarga manualmente una bases de datos de organizaciones sindicales de la ["ventanilla de transparencia"](http://tramites.dirtrab.cl/VentanillaTransparencia/Transparencia/RerporteRRLLOrg.aspx) de la Dirección del Trabajo (DT), a la cuál hemos denominado: **"Base de sindicatos"**. Esta base fue descargada por última vez el 20 de enero de 2021. 

La base contiene el registro actualizado de todos los sindicatos interempresa, empresa, establecimiento, independientes y transitorios constituidos en Chile desde 1900 hasta 2021 (38.349 organizaciones). Los sindicatos vienen clasificados según su estado de "activo", "receso", "caducado", "eliminado" o "disuelto". Filtrando por los casos activos, se podría suponer que al 20 de enero de 2021 en Chile existían 12.165 sindicatos activos. Esta cifra parece coherente con los últimos datos oficiales publicados por la Dirección del Trabajo en su [compendio de organizaciones sindicales](https://www.dt.gob.cl/portal/1629/w3-article-119786.html). Según esta, en el año 2019 existían 11.926 sindicatos activos. 

Con el procesamiento detallado a continuación se proponen medidas alternativas de sindicalización a las oficiales publicadas de manera agregada por la Dirección del Trabajo. Considerar esta nueva fuente de información sindical permite obtener el dato actualizado a la fecha de descarga de los sindicatos activos en Chile, logrando un monitoreo actualizado y en tiempo real de las relaciones laborales en el país; permite tener el dato de sindicatos activos para antes del año 1990; y permite vincular cada sindicato con la empresa a la que pertenece, en tanto la base de datos tienen la variable "rut empresa". Con esta variable es posible vincular la base de sindicatos con otras bases de datos públicas con rut de empresa, como las del Servicio de Impuestos Internos (SII), a la vez que permite obtener medidas alternativas, como paralelismo sindical.

A continuación se resume el proceso realizado, el cuál puede reproducirse descargando las bases de la ventanilla de transparencia y ejecutando los códigos al interior de la carpeta `PROCESO`.

## Resumen de los procesos y explicitación de supuestos

### Script 00. limpieza de la base

Se elimina dígito verificador de la variable rut, se eliminan 22 casos duplicados, se crea la variable actividad económica y, las variables fecha de constitución, depósito de estatutos y última directiva se transforman en variables de tiempo con `lubridate`. Se exporta a excel la base `archivo_sindicatos_limpia`.

### Script 01. generacion microbases mensuales

Solo considerar desde el apartado "III. Función para hacer microbases para todo el periodo" (línea 35). Las funciones I y II replican el mismo proceso pero sin *loop* para cada combinación de mes y año. 

Se crea una "microbase" para cada mes dentro del intervalo de tiempo definido: 1920-2020 (1200 bases). Cada microbase tiene como supuesto el considerar solamente a aquellos sindicatos que se encontraban activos en el año-mes (`t`) de cada microbase. Para cada tiempo (`t`) se filtran aquellos sindicatos activos en 2021 que se constituyeron entre el primer día y el último de `t`, y aquellos sindicatos no activos en 2021 pero cuya última fecha de elección de directiva ocurrió después del último día de `t`. 

Posteriormente se calcula para cada tiempo el total de sindicatos activos y de trabajadores afiliados. Los resultados se consolidan en tabulados y se exportan a `OUTPUT`. El dato de trabajadores afiliados no es del todo exacto, ya que el número de afiliados es el registrado por la Dirección del Trabajo en el último trámite realizado por el sindicato. Por tanto, si un sindicato en 2015 tiene 5000 socios, esos 5000 socios corresponden al último periodo registrado por la DT para ese sindicato, probablemente 2017-2020 en ese caso. Para cada periodo o tiempo `t` hay una sub o sobre estimación en el número de afiliados de cada sindicato.


## Script 02. formacion historica sindicatos en empresas

Siguiendo la misma lógica del Script 01, se elabora una función para identificar empresas según cadenas de texto en las variables nombre de sindicato y nombre de empresa. Con esto, poniendo filtros de expresiones regulares, del estilo `LIDER|lider|Lider|WALMART|Walmart|walmart|WAL-MART|EKONO|Ekono|ekono`, se puede obtener el total de sindicatos activos y socios/as de cada empresa consultada. Los datos muestran un extendido y creciente paralelismo sindical en la empresa, que llega a cubrir a un altísimo porcentaje de los trabajadores, tal como hemos observado en un estudio de caso en la empresa [(Ratto, 2021)](https://preprints.scielo.org/index.php/scielo/preprint/view/1386/version/1480). El ejercicio también se realiza para la empresa Jumbo mediante las expresiones `JUMBO|Jumbo|jumbo`. Los/as invitamos a aplicar el proceso a empresas de sus ámbitos de interés y compartir sus hallazgos. 

**Última actualización:** 2021/03/21
