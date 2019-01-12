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

# Pasando la info a texto
textoNoticia <- html_text(contenidoWebNoticia)

# Viendo a priori la info en la variable textoNoticia
print(textoNoticia)


# Eliminando los \n,comillas("),puntos(.) y comas(,) del texto
textoNoticia <- gsub("\n","",textoNoticia)
textoNoticia <- gsub("\"","",textoNoticia)
textoNoticia <- gsub("[.]","",textoNoticia)
textoNoticia <- gsub(",","",textoNoticia)

# Viendo a priori la info en la variable textoNoticia
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

# Extrayendo los elementos que contienen las tablas
tablaProductos <- html_nodes(webpage, ".artefactos")

# Extraccion de el contenido de las tablas usando el tag table
contenedorDeTablas <- html_nodes(tablaProductos, "table")

# Extracción información tabla 
tabla1 <- html_table(contenedorDeTablas)

# Viendo el contenido de la tabla1
print(tabla1[1])


