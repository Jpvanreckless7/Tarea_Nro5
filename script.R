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
dfPalabrasNoticia <- as.data.frame(tablaPalabras)

# Viendo a priori la info en la variable textoNoticia
print(dfPalabrasNoticia)

# Almacenando la información en CSV
write.csv(dfPalabrasNoticia, file="PalabrasNoticia.csv")

# o en un txt
write.table(dfPalabrasNoticia, file="PalabrasNoticia.txt")

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

#tabla despues de impiar elementos
print(DataFrameTabla)

#Sepraando las palabras por espacio
EspacioPalabras<-strsplit(DataFrameTabla," ")[[1]]

#Todas las palabras a minusculas
MinusculaPalabras<-tolower(EspacioPalabras)

#Contar palabras
ContarPalabras<-unlist(MinusculaPalabras)
TablaPalabras<-table(ContarPalabras)

#Pasando la informacion a un data frame
DataFramePalabras<-as.data.frame(TablaPalabras)

#Juntamos los parrafos a TextoCompleto
TextoCompleto<-""
for(i in 1:length(DataFrameTabla))
  TextoCompleto<-paste(TextoCompleto," ",DataFrameTabla[i])

#Volvemos a realizar los pasos para contar (data frame)

TextoCompleto<-gsub("\n","",TextoCompleto)
TextoCompleto<-gsub("\"","",TextoCompleto)
TextoCompleto<-gsub("[.]","",TextoCompleto)
TextoCompleto<-gsub(",","",TextoCompleto)
TextoCompleto<-gsub(":","",TextoCompleto)

print(TextoCompleto)

EspacioPalabras<-strsplit(TextoCompleto," ")[[1]]
MinusculaPalabras<-tolower(EspacioPalabras)
ContarPalabras<-unlist(MinusculaPalabras)
TablaPalabras<-table(ContarPalabras)
DataFramePalabras<-as.data.frame(TablaPalabras)
write.csv(DataFramePalabras, file = "PalabrasNoticia.csv")


#Grafico con los datos

#Limpiar tabla
TablaWeb$`Precios` <- gsub("\\$","",TablaWeb$`Precios`)
TablaWeb$`Precios` <- gsub("[.]","",TablaWeb$`Precios`)
TablaWeb$`Precios` <- as.numeric(gsub(",",".",TablaWeb$`Precios`))

#Graficando los precios de acciones
library('ggplot2')

# respecto al precio
TablaWeb %>%
  ggplot() +
  aes(x = Artefacto, y = `Precios`) +
  geom_bar(stat="identity")

# Gráfico boxplot diferenciado por producto
TablaWeb %>%
  ggplot() +
  geom_boxplot(aes(x = Artefacto, y = `Precios``)) +
  theme_bw()

