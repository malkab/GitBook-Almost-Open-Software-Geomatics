# Representación y semiología cartográfica

Quantum GIS dispone de potentes opciones para la representación de información geográfica destinada a la producción de cartografía temática. En el caso de información vectorial, las opciones de semiología dependen fundamentalmente de dos factores:

- la naturaleza geométrica del vector: punto, línea o polígono;

- la naturaleza discreta o continua del dato alfanumérico sobre el que se va a basar el tratamiento temático.

# Semiología de símbolo único: simbología por capas

Accedemos a la semiología de una capa con click derecho sobre la misma en el TOC y __Propiedades__, o directamente con un doble click.

<!-- ![Sección de semilogía](https://raw.githubusercontent.com/malkab/GitBook-Almost-Open-Software-Geomatics/master/assets/Practica03/00-Semiologia.png) -->

El desplegable que indica "Símbolo único" sirve para indicar el tipo general de representación de la capa, de los que hay siete. Nos centraremos en:

- __Símbolo único:__ semiología que no hace distinciones temáticas, dibujando todas las geometrías con el mismo símbolo;

- __Categorizado:__ se usa para datos discretos. Marca categorías que son dibujadas con símbolos distintos;

- __Graduado:__ se usa para datos continuos. Establece en un rango de valores intervalos que son dibujados con símbolos distintos;

- __Basado en reglas:__ es el método más flexible, permitiendo crear distinciones temáticas en las geometrías gracias a flexibles condiciones lógico-matemáticas (tanto alfanuméricas como espaciales).

Nos centraremos primero en el modo __Símbolo único__ para ver qué filosofía sigue Quantum a la hora de diseñar símbolos. Quantum utiliza simbología por capas, es decir, que los símbolos que utilizamos para representar líneas, puntos o polígonos se construyen gracias a capas jerarquizadas que se dibujan de abajo a arriba.

En la sección central a la izquierda se encuentra la jerarquía de capas de simbología. Podemos añadir nuevas capas con el símbolo __+__, eliminarlos con el símbolo __-__ y alterar su orden con las flechas arriba y abajo.

Cada capa aplica un tipo determinado de procedimiento gráfico. Por ejemplo, en polígonos encontramos:

- __Relleno sencillo:__ un color sólido con un borde;

- __Relleno de centroides:__ lo que se representa es el centroide del polígono con un símbolo puntual;

- __Relleno de gradiente:__ rellena el polígono con un gradiente;

- __Patrón de relleno de línea:__ superposición de un relleno con líneas;

- __Patrón de relleno de puntos:__ relleno del polígono con puntos;

- __Relleno de imagen raster:__ se rellena con una imagen;

- __Relleno SVG:__ se utiliza una imagen SVG vectorial como relleno;

- __Shapeburst fill:__ gradiente interior al contorno del polígono;

- __Línea exterior: Línea de marcador:__ se dibuja el contorno del polígono con un marcador;

- __Línea exterior: Línea sencilla:__ se dibuje el contorno del polígono con una línea sencilla.

Cada tipo de capa tiene sus propias opciones de configuración.

__Ejercicio:__ dibujar las parcelas catastrales rurales de Chucena (__chucena_rustico.shp__) con un fondo azul pálido y un tramado diagonal en gris pálido.

__Ejercicio:__ dibujar las parcelas catastrales rurales de Chucena en blanco sólido, con borde gris oscuro y un ligero degradado interior del gris del borde al blanco interior.

# Semiología categorizada

La semiología categorizada nos permite distinguir objetos en base a sus propiedades temáticas de una forma discreta. Primero hay que seleccionar la columna de la tabla de atributos cuyos valores vamos a utilizar para encontrar las categorías. Una vez hecho, elegimos el símbolo general de referencia en __Símbolo__ y la __Rampa de color__. Pulsamos en __Clasificar__ y Quantum leera todos los valores únicos que existen en dicha columna, asignando una categoría con su propio símbolo a cada una de ellas.

__Ejercicio:__ sobre Chucena rústico, crear una semiología para cartografiar cada una de las masas catastrales del municipio.

__Ejercicio:__ hacer un mapa en el que se muestre el __tipo__ de parcela rústica:

- __U:__ urbana;

- __R:__ rústica;

- __D:__ diseminado;

- __X:__ dominio público y ajustes topográficos.

# Semiología graduada

La semiología graduada es similar en concepto a la __categorizada__, pero se utiliza para cartografiar datos continuos, como por ejemplo el área de un conjunto de polígonos. Sobre el rango completo de valores continuos de la magnitud se crean intervalos, que se representan cada uno con un símbolo diferente.

Al igual que en el caso de la semiología categorizada, lo primero que se ha de seleccionar es una columna que contiene la variables que queremos cartografiar. Se selecciona a continuación un símbolo base a aplicar a todos los intervalos. A continuación, en __Clases__, se selecciona el número de intervalos en los que se quiere dividir el rango de valores de la variable. La __rampa de color__ determina los colores por defecto que se le va a aplicar a los distintos intervalos. El _Formato de leyenda__ sirve para introducir una expresión para formatear la salida de leyenda automática de cada intervalo. La __Precisión__ determina el número de decimales que deben aparecer en los límites de los intervalos.

El apartado más importante es el __Modo__. Determina el algoritmo o metodología para crear los intervalos:

- __Intervalo igual:__ intervalos de igual anchura;

- __Cuantil:__ crea los intervalos en cuanto a cuantiles;

- __Jenks:__ un método estadístico para crear intervalos que estudia la distribución estadística de los valores que se encuentran en la serie;

- __Desviación estándar:__ crea los intervalos a partir de la media de la serie y diversos pasos a partir de la desviación estándar de la misma;

- __Pretty breaks:__ otro método estadístico para crear intervalos basados en la distribución estadística de los valores de la serie.

Pulsando __Clasificar__ Quantum crea los intervalos en función de la variable y el método seleccionado. Se pueden añadir, modificar y quitar clases, así como alterar sus símbolos específicos.

__Ejercicio:__ crear una graduación de las construcciones del urbano de Chucena en función de su área en metros cuadrados.

# Semiología basada en reglas

La semiología basada en reglas es la forma más potente de crear mapas temáticos en Quantum GIS. Permite crear categorías temáticas basadas en reglas lógico-matemáticas complejas.

Para crear una regla, pulsar sobre el símbolo __+__. Aparecerá el diálogo de crear regla. En __Etiqueta__ se introducirá el nombre de la regla, y en __Descripción__ una reseña de la misma. Abajo se puede activar un intervalo de escala de visualización de la regla (lo que permite crear semiología multiescala), y abajo se define el símbolo a utilizar.

El elemento principal de la regla es su filtro, definible en el campo __Filtrar__. Pulsando sobre __...__ se abre el editor de filtro, similar a la calculadora de campos. Con el editor de filtro se puede crear la expresión que debe cumplir cada geometría para calificar dentro de dicho grupo temático.

Cargamos la capa __chucena_construcciones_urbana__. Se crearán distintas clasificaciones temáticas teniendo en cuenta el tipo de construcción urbana según el campo __constru__:

- __ZD:__ Zona deportiva;

- __SUELO:__ suelo vacante sin construir;

- __Números romanos negativos:__ nivel de construcción bajo rasante;

- __Números romanos positivos:__ nivel de construcción sobre rasante;

- __B:__ balcón;

- __TZA:__ terraza;

- __P:__ patio;

- __POR:__ porche;

- __PI:__ piscina;

- __SS:__ semisótano.

__Ejercicios:__ crear las siguientes reglas:

- crear una regla para filtrar las zonas deportivas en azul;

- crear una regla para filtrar los patios en gris claro;

- crear una regla para filtrar las construcciones de tipo desconocido (__?__) en amarillo con un rayado diagonal negro;

- crear una regla para filtrar el suelo vacante de más de una hectárea en rojo claro;

- crear una regla para filtrar el suelo vacante de más de una hectárea de rojo más oscuro que el anterior;

- crear una regla para mostrar en verde claro las edificaciones de una planta;

- crear una regla para mostrar en verde medio las edificaciones de dos plantas;

- crear una regla para mostrar en verde más oscuro las edificaciones de tres plantas;

- crear una regla para mostrar todas las construcciones que están a menos de 100 metros de distancia del punto con coordenadas 730.988, 4.138.149;

- crear una regla para mostrar las construcciones de dos plantas que están dentro de la zona con __COD_ZONA__ igual a 1 de la capa __Zonificacion__ que creamos en la práctica anterior.
