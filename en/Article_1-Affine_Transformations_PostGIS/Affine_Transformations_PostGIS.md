# Affine Transformations in PostGIS

__TAGS:__ postgis, affine, transformations, matrix, matrices, translations, scaling, rotation

## Motivation

Affine transformations on the plane are the mathematical formal denomination for geometric operations such as rotations, scalations, translations, and other relocation and/or alteration operations that can be performed on a vector or raster dataset. Affine transformations are seldom used in GIS because their very reason of existence is to modify the shape and position of geometric data, and this is a rarely needed or wanted operation to perform on existing geographic data.

However, is nice to have the posibility to perform such operations from a semiology point of view. In this article we will revise the basics of affine transformations, affine transformation composition, and a usage case in PostGIS.

If you want to know more about the formal mathematical definition of affine transformations check this links:

TODO

  - d
  - w

We are about to review the practical implications of this mathematics procedures.

## Use Case

For a certain project, we have been working with territorial grids of different sizes, all of them derived from the European Reference Grid of 1 km (you can check the original data at [1 km EEA Reference Grid][0]). Data is summarized on this grids because of the sensitive nature of some of them, resulting in a structure like this:

![Original data grid](assets/Grid-Use_case-00.png)

However, we wanted to create an effect of deattachment between the cells of the grid. We tried several approaches with Quantum GIS, for example representing rotated square symbols at cell's centroids:

![Tilted square semiology by QGIS](assets/Grid-Use_case-01.png)

or using a broad, white outline on the cells:

![Original grid with broad white stroke](assets/Grid-Use_case-02.png)

But this solutions are only valid inside Quantum, and are not easily translated to other mapping platforms we use like GeoServer, or at least not without redoing all the semiology. Another solution must be find, and it is to redefine in a view the geometries of the cells themselves inside PostGIS. This can be done with affine transformations.

[0]: http://www.eea.europa.eu/data-and-maps/data/eea-reference-grids-2


__TALK ABOUT THE CRS__

## Affine Transformations in PostGIS

Check this polygon:

![Original data](assets/00.png)

It is a rather complex polygon almost centered at 0,0, as can be seen from the axis in the image.

PostGIS includes functions to easily apply basic affine transformations to geometries, both in 2D and 3D. We cover only 2D transformations in this article. For example, to translate a geometry, we can use __st_translate__:

```sql
geometry st_translate(geometry g1, float deltax, float deltay);
```

__st_translate__ takes a geometry _g1_ and two translate factors, _deltax_ and _deltay_, that moves the geometry in x and y components. PostGIS does this just by translating all vertex in the polygon by this magnitude. To move the polygon 1000 meters left and 500 down:

```sql
select st_translate(
  (select geom from affine.data where gid=1),
  -1000,
  -500);
```
	  
The effect of this translation is:

![Translation](assets/01.png)

Rotations are also easy, using functions __st_rotatex__ and __st_rotatey__:

```sql
geometry st_rotatex(geom g1, float radians);
```

This function rotates geometry _g1_ _radians_ radians around the x axis:

```sql
select st_rotatex(
  (select geom from affine.data where gid=1),
  pi()/3);
```

![Rotation along x axis](assets/02.png)

Note that the distortion of the polygon is due to project to a plane a rotation on the x axis \(\pi\)/3 radians. Same to rotate around the y axis:

```sql
select st_rotatey(
  (select geom from affine.data where gid=1),
  pi()/3);
```

![Rotation along y axis](assets/03.png)

And finally a rotation around the z axis, the axis that is perpendicular to the screen plane:

```sql
select st_rotatez(
  (select geom from affine.data where gid=1),
  pi()/3);
```

![Rotation along z axis](assets/04.png)

Another transformation is scaling. Scaling works taking a focus point (the origin of coordinates, __(0,0)__) and scaling each point that makes up the geometry by a factor in a straigh line towards the focus. See this example:

```sql
select st_scale(
  (select geom from affine.data where gid=1),
  1.3, 1.3);
```

This function scales the original polygon by a factor of 0.3, making each point of the geometry go further away from the focus in a radial way by 1.3 times the original distance. The outcome is a copy of the polygon but bigger. Here is the opposite, applying a scaling factor of 0.7:

```sql
select st_scale(
  (select geom from affine.data where gid=1),
  0.7, 0.7);
```

This is the outcome, showing the original polygon and the two scaled ones:

![Scaled polygons by factor 1.3 and 0.7](assets/05.png)

## Transformation Composition

The best thing about transformations is that they can be stacked and composed. Thus, we can translate, rotate, and scale a geometry at the same time. Check this original data:

![Original grid data](assets/Grid_modification-00-Original_data.png)

The goal is to rotate and scale down each of the boxes that makes up the grid.

Both rotations and scalations are made around the __(0,0)__ origin of coordinates. The only point that is not affected by the translation is the origin of coordinates __(0,0)__ itself, so if we try to rotate each box of our grid the result will be pretty much strange:

```sql
select
  gid,
  st_rotatez(geom) as geom
from
  affine.grid;
```
  
![Grid rotated by PI/3](assets/Grid_modification-00-Rotated_Z.png)
  
As can be seen, the __(0,0)__ focus makes each box to rotate around it. The only box rotated correctly is the one at the focus: its centroid stayed at the same point while the box rotate around itself. But the rest of the boxes rotates around the focus, and this is not what we intended. The same goes to scaling:

```sql
select
  gid,
  st_scale(geom, 0.6, 0.6) as geom
from
  affine.grid;
```

![Grid scaled by a 0.6 factor](assets/Grid_modification-00-Scaled_0_6.png)

All boxes but the one at the coordinate origin are out of their original places: they have scaled towards the focus, changing their size but also their position. Again, this is not what we intended. What we want is to scale and rotate each box in place, that is, taking as their own center (the centroid) as the focus for both operations.

The solution lies on the box at the coordinate origin. Because its centroid is coincident with the rotation and scaling focus, this is the only box in the set that is transformed "in place". That means that we need to take each box to the coordinate center and make its centroid coincident with it, apply rotation and scaling transformations and then move the box again to its original position. A composition of four transformations:

__translation of centroid to coordinate origin__ > __rotation__ > __scalation__ > __translation of centroid again to its original position__

The final query to accomplish all of this is:

```



