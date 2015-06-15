# Una base de datos geográfica para el control de la calidad del agua en el litoral andaluz

Se pretende crear una base de datos geográfica para el control de la red de vigilancia de la calidad de aguas en la costa de Andalucía. El programa de red de vigilancia de aguas de Andalucía contempla un área de actuación que se ofrece en el fichero shapefile __zona_implantacion__. Este _área de implantación_ es la zona cuya calidad hay que controlar. Se corresponde con la extensión a una milla naútica bien desde la línea de costa, bien desde las líneas de base recta.

Para controlar la calidad de las aguas, esta zona de implantación se dividirá en subdivisiones más pequeñas llamadas _masas de agua_. A estas masas de agua se les asignará un _nombre_ (basado en la toponimia local) y una _categoría_. Las categorías posibles para una masa de agua pueden ser __marina__ (aguas costeras abiertas) o de __transición__ (aguas estuarinas). Según la categoría se le asigna un _tipo_ determinado, a saber:

* __tipos marinos:__ plumas de estuarios mesomareales, somero arenoso mesomareal, somero rocoso mesomareal;

* __tipos de transición:__ gran estuario mesomareal, estuario micromareal.

Dentro de las masas de agua debe haber, como mínimo, una _estación de vigilancia_. Las estaciones de vigilancia son _puntos_ con coordenadas donde se recogen muestras de agua que después son analizadas en laboratorio. Cada estación de vigilancia tiene un _código_ y un _nombre_. Cada estación está a cargo de un _organismo gubernamental_ (que tienen _nombre_) que se encarga de analizar las muestras y gestionar y guardar los datos de los análisis.

En cada estación se analizan uno o varios _elementos de calidad_. Los elementos de calidad son parámetros físico-químicos y biológicos del agua, como por ejemplo el nivel de clorofila, substancia amarilla, pH, salinidad, fauna bentónica, etc. Se necesita tener un _histórico de análisis de datos_. Una _toma de muestras_ se caracteriza por haber sido tomada en un lugar (es decir, estación), por haberse medido un elemento de calidad determinado, en una _fecha_ concreta y habiendo arrojado el análisis una _medida_ determinada.

Las necesidades de información de este sistema son los siguientes:

* se necesita saber en todo momento las características descritas de las masas de agua (nombre, categoría y tipo pero descritas con palabras, no con códigos);

* se necesita en todo momento saber la lista completa de estaciones y las medidas de elementos de calidad realizadas. Es decir, que se quiere una _vista_ con los siguientes campos: _código de la estación_, _nombre de la estación_, _organismo responsable de los datos_, _elemento de calidad medido_, _fecha_ y _dato del análisis_. Algo similar a esto:

| Código | Nombre de la estación | Organismo responsable datos | Elemento de calidad | Fecha | Dato |
| ------ | --------------------- | --------------------------- | ------------------- | :---: | :--: |
| AT001 | Isla Cristina | CICEM Aguas del Pino | pH | 2009/12/14 | 3 |
| AT001 | Isla Cristina | CICEM Aguas del Pino | Salinidad | 2009/12/14 | 34 |
| MED001 | Fuengirola | Laboratorio Confederación Hidrográfica Sur | pH | 2009/12/14 | 4 |
| MED001 | Fuengirola | Laboratorio Confederación Hidrográfica Sur | Salinidad | 2009/12/14 | 45 |
| AT001 | Isla Cristina | CICEM Aguas del Pino | pH | 2009/12/28 | 5 |
| MED001 | Fuengirola | Laboratorio Confederación Hidrográfica Sur | pH | 2009/12/28 | 40 |
			
* Crear un análisis de las medidas para todos los datos (es decir, todas las fechas) en la que se vea la media de cada elemento de calidad por cada estación:

| Código de la estación | Elemento de calidad | Media histórica |
| --------------------- | ------------------- | :-------------: |
| AT001 | pH | 3.4 | AT001 | Salinidad | 33.6 | MED001 | pH | 4.1 | MED001 | Salinidad | 41.4 |


## Qué hay que hacer y qué hay que entregar

Hay que hacer:

* un modelo __entidad-relación geográfico__ que solucione las necesidades de información y gestión de la información descrita en el problema, acompañado de una __pequeña descripción__ de por qué habéis hecho lo que habéis hecho (tenéis que justificar vuestras decisiones de diseño). No muy extenso, que la teoría ya me la sé. A entregar, ambos elementos, en PDF (¡NADA DE WORD!);
  
* una implementación del modelo que hayáis creado en, o bien una __geodatabase personal ESRI__, o bien una __base de datos PostGIS__. En el caso de hacer una geodatabase personal ESRI, debe llevar todos sus elementos, siempre que sean necesario utilizarlos, claro, o los consideréis conveniente. A saber: _Datasets_, _Feature Classes_, _Tables_, _Dominios_ y _Topología_. Importar también el shape de la zona de implantación. En el caso de la PostGIS, debe llevar el modelo implementado con todas las consultas (explicada su utilidad brevemente) que se consideren necesarias para cumplir con los requisitos de información y para asegurar la calidad topológica de los datos;

* algunos __datos inventados__ que demuestren el buen funcionamiento del modelo. Esto __NO__ es una práctica de digitalización, con dos o tres masas de agua, 5 ó 6 estaciones y un par de medidas para cada una de ellas es suficiente, no hace falta que digitalicéis todo el litoral;

* tres __consultas__ en la Access de la geodatabase (opción ESRI) o en la base de datos PostGIS (opción PostGIS) que satisfagan las necesidades de información pedidas;

* el ejercicio queda abierto a vuestra imaginación. Cualquier añadido o desarrollo del ejercicio más allá de sus mínimos será bien acogido.

Qué hay que entregar:

* modelo ERM geográfico (PDF);

* pequeña (no más de una carilla) explicación del funcionamiento del modelo (PDF);

* geodatabase ESRI;

  ó

* dump de base de datos PostGIS.
