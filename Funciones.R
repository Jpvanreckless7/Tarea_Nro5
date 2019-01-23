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

#Juntamos los parrafos a TextoCompleto
Textolisto<-""
for(i in 1:length(DataFrameTabla))
  Textolisto<-paste(Textolisto," ",DataFrameTabla[i])
#Volvemos a realizar los pasos para contar (data frame)

Textolisto<-gsub("\n","",Textolisto)
Textolisto<-gsub("\"","",Textolisto)
Textolisto<-gsub("[.]","",Textolisto)
Textolisto<-gsub(",","",Textolisto)
Textolisto<-gsub(":","",Textolisto)

print(Textolisto)

EspacioPalabras<-strsplit(Textolisto," ")[[1]]
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

#Graficando los precios de los productos

#install.packages('ggplot2')

#usando ggplot2
library('ggplot2')

# respecto al precio
TablaWeb %>%
  ggplot() +
  aes(x = Productos, y = Precios) +
  geom_bar(stat="identity")

# Gráfico boxplot diferenciado por producto
TablaWeb %>%
  ggplot() +
  geom_boxplot(aes(x = Artefacto, y = `Precios`)) +
  theme_bw()

