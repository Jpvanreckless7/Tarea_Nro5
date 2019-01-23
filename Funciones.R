### borrado de variables rm(list = ls())

##########################################################
######### Iniciando la extracción de información #########
##########################################################

#install.packages('rvest')

# Usando la librería rvest
library('rvest')

# inicializando la variable archivo con el nombre de mi página
archivo <- 'web.html'

# Leyendo el HTML del archivo
webpage <- read_html(archivo)

##########################################################
############# Extracción del titulo noticia ##############
##########################################################

#Extrayendo contenido titulo noticia
TiuloNoticia <- html_nodes(webpage,'.Titulo')
print(TiuloNoticia)

# Pasando la info a texto
textoTitulo<- html_text(TiuloNoticia)

# Viendo a priori la info en la variable TituloNoticia
print(textoTitulo)

# Eliminando los \n,comillas("),puntos(.) y comas(,) del texto
textoTitulo <- gsub("\n","",textoTitulo)
textoTitulo <- gsub("\"","",textoTitulo)
textoTitulo <- gsub("[.]","",textoTitulo)
textoTitulo <- gsub(",","",textoTitulo)

# Viendo ordenada la info en la variable textoTitulo
print(textoTitulo)

# Separando las palabras por espacio
splitEspacioTitulo <- strsplit(textoTitulo," ")[[1]]

# Pasando todas las palabras a minúsculas
splitEspacioTitulo <- tolower(splitEspacioTitulo)

# Contando palabras
unlistTitulo<-unlist(splitEspacioTitulo)
tablaPalabrasTitulo<-table(unlistTitulo)

# Pasando la información a un data frame
PalabrasTitulo <- as.data.frame(tablaPalabrasTitulo)

# Viendo a priori la info en la variable textoTitulo
print(PalabrasTitulo)

# Almacenando la información en CSV
write.csv(PalabrasTitulo, file="PalabrasTitulo.csv")

# o en un txt
write.table(PalabrasTitulo, file="PalabrasTitulo.txt")

##########################################################
############# Extracción del texto noticia ###############
##########################################################

# Extrayendo contenido en la clase justificado
contenidoWebNoticia <- html_nodes(webpage,'.justificado')
print(contenidoWebNoticia)

# Pasando la info a texto
textoNoticia <- html_text(contenidoWebNoticia)

# Viendo a priori la info en la variable textoNoticia
print(textoNoticia)

# Eliminando los \n,comillas("),puntos(.) y comas(,) del texto
textoNoticia <- gsub("\n","",textoNoticia)
textoNoticia <- gsub("\"","",textoNoticia)
textoNoticia <- gsub("[.]","",textoNoticia)
textoNoticia <- gsub(",","",textoNoticia)

# Viendo ordenada la info en la variable textoNoticia
print(textoNoticia)

# Separando las palabras por espacio
splitEspacioNoticia <- strsplit(textoNoticia," ")[[1]]

# Pasando todas las palabras a minúsculas
splitEspacioNoticia <- tolower(splitEspacioNoticia)

# Contando palabras
unlistNoticias<-unlist(splitEspacioNoticia)
tablaPalabras<-table(unlistNoticias)

# Pasando la información a un data frame
PalabrasNoticia <- as.data.frame(tablaPalabras)

# Viendo a priori la info en la variable textoNoticia
print(PalabrasNoticia)

# Almacenando la información en CSV
write.csv(PalabrasNoticia, file="PalabrasNoticia.csv")

# o en un txt
write.table(PalabrasNoticia, file="PalabrasNoticia.txt")

##########################################################
############ Extraccion información tabla ################
##########################################################

#leyendo tabla
Tabla <- html_nodes(webpage,'table')
print(Tabla)

#pasando la info a tabla
TablaWeb<-html_table(Tabla)[[1]]

print(TablaWeb)

#Pasando informacion a un data frame
DataFrameTabla<-as.data.frame(TablaWeb)

#Almacenando la informacion en CSV
write.csv(DataFrameTabla, file = "TablaNoticia.csv")

#Eliminando los \n, comillas("), puntos(.) y comas(,) del texto
DataFrameTabla<-gsub("\n","",DataFrameTabla)
DataFrameTabla<-gsub("\"","",DataFrameTabla)
DataFrameTabla<-gsub("[.]","",DataFrameTabla)
DataFrameTabla<-gsub(",","",DataFrameTabla)
DataFrameTabla<-gsub(":","",DataFrameTabla)

#tabla despues de limpiar elementos
print(DataFrameTabla)

#Seprando las palabras por espacio
EspacioPalabras<-strsplit(DataFrameTabla," ")[[1]]

#Todas las palabras a minusculas
MinusculaPalabras<-tolower(EspacioPalabras)

#Contar palabras
ContarPalabras<-unlist(MinusculaPalabras)
TablaPalabras<-table(ContarPalabras)

#Pasando la informacion a un data frame
DataFramePalabras<-as.data.frame(TablaPalabras)

#Grafico con los datos

#Limpiar tabla
TablaWeb$`Precios` <- gsub("\\$","",TablaWeb$`Precios`)
TablaWeb$`Precios` <- gsub("[.]","",TablaWeb$`Precios`)
TablaWeb$`Precios` <- as.numeric(gsub(",",".",TablaWeb$`Precios`))

#Graficando los precios de los productos

#install.packages('ggplot2')

#usando ggplot2
library('ggplot2')

# Respecto al precio
TablaWeb %>%
  ggplot() +
  aes(x = Artefacto, y = Precios) +
  geom_bar(stat="identity")

# Gráfico boxplot 
TablaWeb %>%
  ggplot() +
  geom_boxplot(aes(x = Artefacto, y = `Precios`)) +
  theme_bw()

