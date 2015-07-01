# Vectorial

Buscar los puertos de Sevilla, Huelva, Cádiz y Algeciras, comerciales, aislarlos en una capa llamada puertos_objetivo y hacer área de influencia utilizando Geoalgoritmos de QGIS > Vector geometry tools > Fixed distance Buffer 50 KM a partir de cada uno de ellos, ese es el área de busqueda, la llamamos zona_interes.

Seleccionar carreteras: RIGE, INT. Volcarlo a shape "Carreteras aptas". Clip con zona_interes > carreteras_aptas_clip

Seleccionar sobre us01_usos el tipo 121 y volcarlo a la shape zona_industrial. Hacerle un clip a us01_usos con buffer > zona_industrial_clip. Hacerle un Multipart to singleparts a zona_industrial_clip > zona_industrial.

Meter un campo nuevo en carreteras_aptas_clip llamado friccion, con un 1 para red RIGE y un 3 para INT.

Crear sobre las carreteras_aptas_clip una capa raster a 400 metros con v.to.rast.attribute con el campo friccion > cost_carreteras.


Crear una capa de puntos llamada puntos_puertos para simbolizar el enganche de los puertos con la red de carreteras.

Utilizar r.cost.full para calcular el coste sobre 400 metros con la geometría del buffer para cada uno de los puertos.

Utilizar r.mapcalculator para calcular el coste total.


Probar poniendo más impedancia al paso por Sevilla y por el peaje de la carretera de Cádiz.

Asignar un Excel de costes de implantación a cada zona industrial y estudiar el apaño más provechoso.



























<!-- # Análisis -->

<!-- Seleccionar caja de herramientas > Vista avanzada. -->

<!-- Limpieza topológica: -->
<!-- bpol > comprobar áreas -->
<!-- rmarea con 0.1 -->
<!-- Corrección manual con snapping y demás -->
<!-- bpol > 0.1 -->

<!-- Procesamiento en memoria de frentes de fachada: -->
<!-- Dissolve sin condición de todas las parcelas -->
<!-- Manzanas y parcelas a line -->
<!-- Clip de las parcelas con las manzanas line -->




<!-- Existe un polígono pequeñito pequeñito. -->




<!-- xmin(centroid(geometry(getFeature('chucena_urbano', 'gid', 4201614)))) -->

<!-- distance(geomFromWKT('POINT(x y)'),$geometry)<100 -->





<!-- Cargar rl07_mdt, aplicar estilo -->

<!-- Crear una shape para la ZOI -->

<!-- Usar raster > Extracción > Clipper para recortar -->

<!-- Crear una shape con el punto de inicio y otra con el final -->

<!-- Calcular slope con r.slope -->



<!-- Usar después y walk drain. -->




<!-- Catastro: reclasificación en función de tipo -->
<!-- Núcleos urbanos (buffer) -->
<!-- Masas de agua -->
<!-- Carreteras (buffer) -->
<!-- Zonas de especial protección -->
<!-- Pendiente -->
<!-- Usos del suelo -->
<!-- Edafología -->

<!-- Ver tamaño del pixel de del dem con Information de GDAL (100x100). -->

<!-- "A*(if(isnull(B), 1, null())" -->

<!-- C=A*(if(isnull(B),1,null()) -->


<!-- Cargar dem y cambiar semiología -->

<!-- Cargar el catastro, crear un campo coste en función de tipo y rasterizar dicho campo sobre una copia de DEM. -->

<!-- D > 50 -->
<!-- R > 1 -->
<!-- U > 100 -->
<!-- X > 5 -->

<!-- Con CASE -->

<!-- Cargar lámina de agua, recortarla con ZOI, crearle un campo exists y darle el valor 1. -->
