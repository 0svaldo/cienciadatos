## Programa: pdf_presu_transforma_2
## Descripcion: Transforma datos PDF a Texto
## Autor: Ing. Osvaldo Larancuent
## Email : osvaldo@olc.do
## Empresa: O. Larancuent Consulting, SRL
## Repositorio Github: https://github.com/0svaldo/cienciadatos
## Licencia : MIT

#Lee Fichero PDF
miTexto <- pdf_text(miFicheroPdf)
print("Leyendo documento PDF .... Listo")

#Funcion para detectar cadenas largas
instr <- function(str1,str2,startpos=1,n=1){
     aa=unlist(strsplit(substring(str1,startpos),str2))
     if(length(aa) < n+1 ) return(0);
     return(sum(nchar(aa[1:n])) + startpos+(n-1)*nchar(str2) )
}

#Definir pagina a leer
miPaginaDatos<-5
miEncPag<-9
miPiePag<-30
print(paste0("Accediendo a pagina numero ",miPaginaDatos," .... Listo"))

#Extraer datos de la pagina
misDatos<-miTexto[miPaginaDatos]
misNum<-"[0-9,.]{1,}"
miTxt<-"[A-Za-z ]{2,}"
miIdx<-"([0-9.]{1,} )"

#Dividir pagina en lineas, separadas por retorno 
misLineasDatos <-unlist(strsplit(misDatos, split="\n"))
cantidadRegistros<-length(misLineasDatos)
print(paste0("Cantidad de registros ",cantidadRegistros," .... Listo"))
tamLista<-35
miLineaCSV<-list()
#
numero.indice <- 0
miFichero<-file(miFicheroCSV)
while (numero.indice < tamLista) {
     numero.indice <- numero.indice + 1
     #Encabezados
     if (numero.indice<miEncPag) {
          miLineaCSV[numero.indice]<-str_c(c(numero.indice," ",str_trim(misLineasDatos[numero.indice]),"0","0","0","0","0"),collapse = ";")
          next()
     }
     #Pie de Pagina
     if (numero.indice >= miPiePag) {
          Cuenta<-" "
          Cta_Descripcion<-substr(misLineasDatos[numero.indice],1,instr(misLineasDatos[numero.indice],'  ',4))
          Cantidades<-str_trim(substr(misLineasDatos[numero.indice],instr(misLineasDatos[numero.indice],'  ',4),str_length(misLineasDatos[numero.indice])))
          Valores<-as.numeric(sub("[\\,\\$,\\%]","",scan(text = Cantidades, what = "")))
          miLineaCSV[numero.indice]<-str_c(c(numero.indice,Cuenta,Cta_Descripcion,Valores),collapse = ";")
          next()
     }
     #Extrae el campo de descripcion
     criterioCTA="[1]\\.[1]\\."
     Cta_Descripcion<-substr(misLineasDatos[numero.indice],1,instr(misLineasDatos[numero.indice],'  ',4))
     Cuenta<-" "
     Descripcion<-str_trim(Cta_Descripcion)
     tieneCta<-grep(criterioCTA,Descripcion,value = TRUE)
     if (!is.null(tieneCta)) {
          Cuenta<- str_trim(substring(Descripcion,1,instr(Descripcion,' ')))
          Descripcion<-str_trim(substr(Descripcion,instr(Descripcion,' ',1),str_length(Descripcion)))
     }
     Cantidades<-str_trim(substr(misLineasDatos[numero.indice],instr(misLineasDatos[numero.indice],'  ',4),str_length(misLineasDatos[numero.indice])))
     #Convertir en lista los datos
     Valores<-as.numeric(sub("[\\,\\$,\\%]","",scan(text = Cantidades, what = "")))
     #Separarlos campos por ";"
     miLineaCSV[numero.indice]<-str_c(c(numero.indice,Cuenta,Descripcion,Valores),collapse = ";")
     #Aumenta
} 

#Crea Fichero de salida
miData<-paste0(miLineaCSV,collapse = "\n")
writeLines(miData,miFichero,sep = "")
close(miFichero)
print("Datos convertidos a texto .... Listo")
