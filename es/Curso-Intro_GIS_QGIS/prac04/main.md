# Servicios interoperables

Se entiende por __servicio interoperable__ un mecanismo de transmisión de información, generalmente a través de Internet, destinado a un fin en concreto y que se basa en un estándar de comunicación bien conocido tanto por la aplicación que solicita los datos (llamada __aplicación cliente__) como por la que los produce (llamada __aplicación servidora__). Dicho estándar de comunicación y transferencia de información encapsula y aisla tanto los procedimientos de generación de la misma en la aplicación servidora como el uso que se hace de la misma en la aplicación cliente. El éxito de un estándar de servicio interoperable se basa en la difusión y transparencia de su diseño y bases de implementación, lo que hace que diversos fabricantes de software puedan adoptarlos y basar sus productos en ellos, tanto propietarios como de software libre, facilitando, de ahí lo de __interoperable__, que el software de diferentes fabricantes pueda intercambiar información.

En el ámbito de la información geográfica, los servicios interoperables más utilizados son los que diseña el organismo internacional __[Open Geospatial Consortium (OGC)][0]__. El __OGC__ es un conglomerado de empresas, agencias gubernamentales, universidades y centros de investigación que diseñan estándares para el intercambio y publicación de información geográfica. Es importante entender que el __OGC__ no hace programas, simplemente indica cómo deberían funcionar para comunicarse entre ellos. Los detalles de la implementación de tales estándares queda al diseño de los diferentes fabricantes de software.

Los estándares del __OGC__ más utilizados son los siguientes:

- __Web Map Service (WMS):__ el WMS sirve para la publicación de mapas, es decir, datos representados semiológicamente. El formato devuelto por el servicio es una imagen;

- __Web Feature Service (WFS):__ el WFS sirve para la publicación de datos vectoriales. El formato devuelto por el servicio es información vectorial en formato GML (por defecto);

- __Web Coverage Service (WCS):__ el WCS sirve para la publicación de datos ráster. El formato devuelto es una matriz numérica;

- __Catalogue Service for the Web (CSW):__ el CSW es un protocolo para buscar y transmitir el contenido de grandes catálogos de información geográfica;

- __Web Map Tile Service (WMTS):__ el WMTS es similar al WMS en concepto, pero sirve los mapas teselados.

Existen muchos programas servidores que implementan estos estándares. En el mundo del software libre:

- __WMS, WFS, WCS, WMTS:__ principalmente, los más utilizados son __GeoServer__ y __MapServer__;

- __CSW:__ la implementación de referencia es el __GeoNetwork__.

Los servicios anteriores suelen organizarse en un conglomerado llamado __Infraestructura de datos espaciales (IDE)__, o __Spatial Data Infrastructure (SDI)__ en inglés. Una __IDE__ típica se compone de un servicio de catálogo y multitud de servicios de datos de los anteriormente citados. El servicio más popular con diferencia es el __WMS__, ya que permite publicar mapas sin exponer los datos originales. El servicio de catálogo a veces no se incluye. Cuando esta infraestructura se combina con un portal de Internet clásico y un geovisor online, se dice que la infraestructura es un __geoportal__.

[0]: http://www.opengeospatial.org/

# Geoportales básicos a nivel europeo, nacional y autonómico

A nivel europeo, la IDE más importante es __[INSPIRE][3]__.

A nivel nacional, es fundamental la IDE de Catastro y el agregador nacional __IDEE__:

- __IDE de Catastro de España:__ [http://www.catastro.meh.es/esp/wms.asp][1];

- __IDE de España (IDEE):__ [http://www.idee.es/][2].

A nivel autonómico, la __IDE de Andalucía (IDEA)__ del Instituto de Cartografía y Estadística de Andalucía y la __Red de información ambiental (REDIAM)__ de la Consejería de Medio Ambiente son las más utilizadas:

- __IDEA:__ [http://www.ideandalucia.es/][4];

- __REDIAM:__ [http://www.juntadeandalucia.es/medioambiente/site/rediam][5].

[1]: http://www.catastro.meh.es/esp/wms.asp
[2]: http://www.idee.es/
[3]: http://inspire-geoportal.ec.europa.eu/
[4]: http://www.ideandalucia.es/
[5]: http://www.juntadeandalucia.es/medioambiente/site/rediam

# Utilización de servicios OGC en Quantum

## WMS

Añadir capas procedentes de un servicio OGC a un proyecto Quantum no es muy diferente a añadir datos de cualquier otra fuente de información. Para añadir un servicio __WMS__, pulsar sobre el primer botón, para un __WFS__, el tercero.

![Botones OGC](https://raw.githubusercontent.com/malkab/GitBook-Curso_ETSAS-Intro_GIS/master/assets/Practica04/00-Botones_OGC.png)

Al pulsar sobre el botón de __Añadir capa WMS/WMTS__ aparecerá un cuadro de diálogo donde Quantum nos mostrará los orígenes de servidores WMS que ya hayamos utilizado anteriormente. Dado que es la primera vez que lo usamos, estará vacío. Pulsamos en __Nuevo__ y nos aparecerá un cuadro de diálogo donde configurar un nuevo origen de datos WMS:

![Nuevo WMS](https://raw.githubusercontent.com/malkab/GitBook-Curso_ETSAS-Intro_GIS/master/assets/Practica04/01-Nuevo_WMS.png)

Le asignamos un nombre al servicio (puramente descriptivo) en el campo __Nombre__ y en __URL__ introducimos la raíz del servicio. Algunos servicios WMS precisan de acreditación usuario / contraseña, que podría ser introducido abajo. El resto de opciones son utilizadas por los creadores de servicios para depurarlos, por los que no deberíamos necesitar utilizarlos en servicios bien conformados según el estándar. La última opción, __Transformación de mapa de píxeles suave__ sí podría ser de interés a la hora de generar cartografía en servicios que no aplican correctamente técnicas de _antialiasing_ a la imagen, aunque esto también es raro. Al activarlo, Quantum le hará un tratamiento de suavizado a la imagen recibida que hará que tenga, en casos extremos, un mejor aspecto. Lo normal es que este tratamiento lo aplique el servidor y sólo estaríamos ralentizando todo el proceso (y posiblemente estropeando una imagen ya correcta) si lo repetimos en el cliente, es decir, en Quantum. Pulsamos __Aceptar__ cuando acabemos.

Volvemos al cuadro anterior y seleccionamos en el desplegable superior el servicio recién configurado. Pulsamos en __Conectar__ y el Quantum irá a la URL del servicio y solicitará su configuración gracias a una petición llamada __GetCapabilities__. QGIS analizará la respuesta del servidor y nos mostrará la estructura de capas del mismo. En este momento, podremos configurar nuestra petición. Podemos solicitar tantas capas como queramos (algunas de ellas están disponibles en varios estilos). Tendremos que seleccionar también el tipo de imagen que queremos recibir (PNG, JPEG, etc.), así como el sistema de referencia de la petición (botón __Cambiar__ para cambiar el seleccionado por defecto). Por último, le daremos un nombre a la capa que vamos a crear a partir de la petición.

Como paso adicional, en caso de haber seleccionado más de una capa, podremos, en la pestaña __Orden de capas__, alterar el orden de dibujado de las mismas.

![Configurión WMS](https://raw.githubusercontent.com/malkab/GitBook-Curso_ETSAS-Intro_GIS/master/assets/Practica04/02-Configuracion_WMS.png)

Si todo va bien (cuidado con las escalas de visualización), Quantum solicitará la imagen al servidor y la incluirá en el mapa:

![Catastro](https://raw.githubusercontent.com/malkab/GitBook-Curso_ETSAS-Intro_GIS/master/assets/Practica04/03-Catastro.png)

## WFS

La carga de __WFS__ es muy similar a la del __WMS__, más sencilla si cabe. De forma análoga, se configura un origen WFS pulsando en __Nuevo__, se conecta a él pulsando en __Conectar__ y se elige la capa a descargar y ya se puede visualizar y utilizar.

Sin embargo, hay que tener una cosa en cuenta: como servicio de descarga que es, Quantum intentará descargar la capa completa de una sola vez. Si es pequeña, no habrá problemas, ya que la capa podrá bajar entera. Pero si es muy grande o compleja, tardará un rato, por lo que puede que Quantum arroje un error de _time out_ en la conexión, es decir, que lleva demasiado tiempo esperando sin resultado.

Para solucionarlo hay dos opciones:

- aumentar el tiempo de espera de conexión en __Configuración > Opciones > Red > Expiró el tiempo para solicitudes de red (ms)__;

- no marcar, al pedir la capa, la casilla de __Cache feature__, con lo que el Quantum no intentará descargarse la capa de una sóla vez, sino que se descargará sólo las geometrías que se encuentran en ese momento en el ámbito de visualización.


