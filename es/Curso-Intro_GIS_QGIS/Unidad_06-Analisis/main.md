# Vectorial

Clip a todas las capas (hacer uno de ejemplo y dejar el resto ya hecho).

Hacerle un Multipart to singleparts a usos del suelo.

Seleccionar usos del suelo de tipo: 121. Volcarlo a shape "Zona industrial"

Seleccionar carreteras: RIGE, INT. Volcarlo a shape "Carreteras aptas"

Crear sobre las carreteras una capa raster a 250 metros

Tomar puntos sobre ella que representen a los puertos.

Utilizar r.cost.full para calcular el coste.






# Análisis

Seleccionar caja de herramientas > Vista avanzada.

Limpieza topológica:
bpol > comprobar áreas
rmarea con 0.1
Corrección manual con snapping y demás
bpol > 0.1

Procesamiento en memoria de frentes de fachada:
Dissolve sin condición de todas las parcelas
Manzanas y parcelas a line
Clip de las parcelas con las manzanas line




Existe un polígono pequeñito pequeñito.




xmin(centroid(geometry(getFeature('chucena_urbano', 'gid', 4201614))))

distance(geomFromWKT('POINT(x y)'),$geometry)<100





Cargar rl07_mdt, aplicar estilo

Crear una shape para la ZOI

Usar raster > Extracción > Clipper para recortar

Crear una shape con el punto de inicio y otra con el final

Calcular slope con r.slope



Usar después y walk drain.




Catastro: reclasificación en función de tipo
Núcleos urbanos (buffer)
Masas de agua
Carreteras (buffer)
Zonas de especial protección
Pendiente
Usos del suelo
Edafología

Ver tamaño del pixel de del dem con Information de GDAL (100x100).

"A*(if(isnull(B), 1, null())"

C=A*(if(isnull(B),1,null())


Cargar dem y cambiar semiología

Cargar el catastro, crear un campo coste en función de tipo y rasterizar dicho campo sobre una copia de DEM.

D > 50
R > 1
U > 100
X > 5

Con CASE

Cargar lámina de agua, recortarla con ZOI, crearle un campo exists y darle el valor 1.
