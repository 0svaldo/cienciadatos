## Programa: pdf_presu_inicia_0
## Descripcion: Crear ambiente informatico de librerias a utilizar; variables globales; enlaces; contexto.
## Autor: Ing. Osvaldo Larancuent
## Email : osvaldo@olc.do
## Empresa: O. Larancuent Consulting, SRL
## Licencia : MIT

#1. Libreria y de Paquetes 
#install.packages("pdftools")
library("pdftools",logical.return = TRUE)
print("Libreria pdftools .... cargada")

#install.packages("stringr")
library("stringr",logical.return = TRUE)
print("Libreria stringr .... cargada")

#2. Definicion de Variables 
miUrlLectura <- "http://www.digepres.gob.do/wp-content/uploads/2017/04/Informe-primer-trimestre.pdf"
miFicheroPdf<-"./data/presu-01-2017.pdf"
miFicheroCSV<-"./data/presu-01-2017.csv"
print("Nombres de archivos cargados .... cargada")

miDataDir <- "data"
miFechaDescarga <- date()
miDirContenido <- ""
miMetodo="curl"
miPathActual <- getwd()
miNuevoPath <- "~/Documents/Programacion/r programming/Scrap HTML/CienciaDatos"

#3. Directorio y Working Space
setwd(miNuevoPath)
print("Directorio definido .... Listo")
