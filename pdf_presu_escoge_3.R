## Programa: pdf_presu_escoge_3
## Descripcion: Escoge datos para operar
## Autor: Ing. Osvaldo Larancuent
## Email : osvaldo@olc.do
## Empresa: O. Larancuent Consulting, SRL
## Repositorio Github: https://github.com/0svaldo/cienciadatos
## Licencia : MIT

#Lectura de CSV
misIngresos<-read.csv(miFicheroCSV,sep = ";",col.names = c("Id","Cuenta","Descripcion","Itrim_2016","Est_2016","Itrim_2017","MtoVar_20162017","PorcVar_20162017"))

#Cuentas No requeridas
misCtas_Elimina<-c(8,10,12,13,18,26)

#Convertir en un Table Frame 
miInforme<-tbl_df(misIngresos)

#Elimino datos leidos del CSV
rm("misIngresos")

#Filtro los registros sin datos numericos, pues son encabezados o lineas separadas
#Guardo los resultados en el DataFrame misResultados
misResultados <- miInforme %>%
     filter(!is.na(Itrim_2016)) %>%
     rowwise() %>%
     mutate(Var_20162017=PorcVar_20162017/100)  %>%
     select(-PorcVar_20162017) %>%
     select(Id, Cuenta, Itrim_2016,  Est_2016, Itrim_2017, MtoVar_20162017, Var_20162017) %>%
     filter(!Id %in% misCtas_Elimina) %>%
     print

print("Informe generado... listo")

MR1<- misResultados %>%
     gather(year,count,-Id, -Cuenta) %>%
     separate(year, c("Dato","Ano")) %>%
     filter(Dato=="Itrim") %>%
     print

print("Preparando para graficar... listo")

