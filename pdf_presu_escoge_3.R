## Programa: pdf_presu_escoge_3
## Descripcion: Escoge las paginas de interes.  Ejemplo pagina 5 - Recaudacion de ingresos por clasificacion
## Autor: Ing. Osvaldo Larancuent
## Email : osvaldo@olc.do
## Empresa: O. Larancuent Consulting, SRL
## Licencia : MIT

#Funcion para detectar cadenas largas
instr <- function(str1,str2,startpos=1,n=1){
     aa=unlist(strsplit(substring(str1,startpos),str2))
     if(length(aa) < n+1 ) return(0);
     return(sum(nchar(aa[1:n])) + startpos+(n-1)*nchar(str2) )
}

#Definir pagina a leer
miPaginaDatos<-5
miEncPag<-9
miPiePag<-35

#Extraer datos de la pagina
misDatos<-miTexto[miPaginaDatos]
misNum<-"[0-9,.]{1,}"
miTxt<-"[A-Za-z ]{2,}"
miIdx<-"([0-9.]{1,} )"

#Dividir pagina en lineas, separadas por retorno 
misLineasDatos <-unlist(strsplit(misDatos, split="\n"))
#tamLista<-length(misLineasDatos)
tamLista<-miPiePag
miLineaCSV<-list()
#
numero.indice <-  0
miFichero<-file(miFicheroCSV)
while (numero.indice < tamLista) {
     numero.indice <- numero.indice + 1
     #Encabezados
     if (numero.indice<miEncPag) {
          miLineaCSV[numero.indice]<-str_trim(misLineasDatos[numero.indice])
          next()
     }
     #Pie de Pagina
     if (numero.indice == miPiePag) {
          miLineaCSV[numero.indice]<-str_trim(misLineasDatos[numero.indice])
          next()
     }
     
     #Extrae el campo de descripcion
     Descripcion<-str_trim(substr(misLineasDatos[numero.indice],1,instr(misLineasDatos[numero.indice],'  ',4)))
     Cantidades<-str_trim(substr(misLineasDatos[numero.indice],instr(misLineasDatos[numero.indice],'  ',4),str_length(misLineasDatos[numero.indice])))
     #Convertir en lista los datos
     Valores<-scan(text = Cantidades, what = "")
     #Separarlos campos por ";"
     miLineaCSV[numero.indice]<-str_c(c(Descripcion,Valores),collapse = ";")
     #Aumenta
} 

#Crea Fichero de salida
miData<-paste0(miLineaCSV,collapse = "\n")
writeLines(miData,miFichero,sep = "")
close(miFichero)
#

