## Programa: pdf_presu_grafica_4
## Descripcion: Preparacion de datos para grafico de barras.  El valor recaudado en las ordenadas (eje vertical); 
##              el tipo de recaudo en las absisas(eje horizontal), discriminando el Año
##              organizado de izquierda a derecha de forma descendente
## Autor: Ing. Osvaldo Larancuent
## Email : osvaldo@olc.do
## Empresa: O. Larancuent Consulting, SRL
## Repositorio Github: https://github.com/0svaldo/cienciadatos
## Licencia : MIT

g1<- filter(MRI,Cuenta %in% c("1.1.1.4")) %>%
     group_by(Dato,Ano,add=T) %>%
     summarise(sum(count)) %>%
     mutate(xLab="Imp. sobre los bienes y servicios")
colnames(g1) <- c("Dato", "Ano","Total","Cuenta")

g2<- filter(MRI,Cuenta %in% c("1.1.1.1")) %>%
     group_by(Dato,Ano,add=T) %>%
     summarise(sum(count)) %>%
     mutate(xLab="Imp. Sobre Los Ingresos")
colnames(g2) <- c("Dato", "Ano","Total","Cuenta")

g3<- filter(MRI,Cuenta %in% c("1.1.1.5")) %>%
     group_by(Dato,Ano,add=T) %>%
     summarise(sum(count)) %>%
     mutate(xLab="Imp.sobre El Comercio Exterior ")
colnames(g3) <- c("Dato", "Ano","Total","Cuenta")

g4<- filter(MRI,Cuenta %in% c("1.1.1.3")) %>%
     group_by(Dato,Ano,add=T) %>%
     summarise(sum(count)) %>%
     mutate(xLab="Impuestos Sobre La Propiedad")
colnames(g4) <- c("Dato", "Ano","Total","Cuenta")

g5<- filter(MRI,Cuenta %in% c("1.1.2","1.1.3","1.1.4","1.1.6","1.1.7","1.1.9","1.2","1.2.1")) %>%
     group_by(Dato,Ano,add=T) %>%
     summarise(sum(count)) %>%
     mutate(xLab="Otros ingresos corrientes")
colnames(g5) <- c("Dato", "Ano","Total","Cuenta")

g6<- filter(MRI,Cuenta %in% c("1.1.1.6","1.1.1.9")) %>%
     group_by(Dato,Ano,add=T) %>%
     summarise(sum(count)) %>%
     mutate(xLab="Otros impuestos")
colnames(g6) <- c("Dato", "Ano","Total","Cuenta")

g7<- filter(MRI,Cuenta %in% c("1.2.5")) %>%
     group_by(Dato,Ano,add=T) %>%
     summarise(sum(count)) %>%
     mutate(xLab="Recuperacin de inv fin con fines de pol.")
colnames(g7) <- c("Dato", "Ano","Total","Cuenta")

#Agrupemos el conjunto de cuentas
miGr<-rbind(g1,g2,g3,g4,g5,g6,g7)

#Si quisieramos hacerlo exclusivo 2017 
#miRpt<- miGr %>%
     #filter(Ano==2017)

#Ordenemos el eje de las ordenadas en funcion del Total Ingresos
miGr$Cuenta<-factor(miGr$Cuenta,levels = miGr$Cuenta[order(desc(miGr$Total))])

#Grafiquemos los 
Itrim2017<-ggplot(data=miGr, 
                  aes(x=Cuenta, y=Total, fill = Ano)) +
     geom_bar(colour="black", stat="identity", position=position_dodge()) +
     xlab("Cuenta de Ingresos") + 
     ylab("Millones RD$") + 
     ggtitle("Comparación de Resultados I Trimestre 2017 vs 2016") + 
     scale_x_discrete(labels = function(x) str_wrap(x, width = 10)) +
     geom_text(aes(label=Total), position=position_dodge(width=0.9),angle=85, vjust=0.55, size=2.5) +
     theme_bw()