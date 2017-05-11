## Programa: pdf_presu_descarga_1
## Descripcion: Descarga archivo de datos requerido
## Autor: Ing. Osvaldo Larancuent
## Email : osvaldo@olc.do
## Empresa: O. Larancuent Consulting, SRL
## Repositorio Github: https://github.com/0svaldo/cienciadatos
## Licencia : MIT

#Verifica existencia de directorios y archivos
if (!file.exists(miDataDir)) {
     dir.create(miDataDir)
}

print(paste0("Descargando archivo: ",miUrlLectura,".... cargada"))
#Descarga archivo de datos 
download.file(miUrlLectura, destfile=miFicheroPdf, method=miMetodo)
print("Descarga exitosa.... cargada")

#Lista el contenido del directorio
miDirContenido <- list.files("./data")
