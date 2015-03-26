# Affine Transformations in PostGIS

__TAGS:__ postgis, affine, transformations, matrix, matrices, translations,
scaling, rotation

## Motivation

Affine transformations on the plane are the mathematical formal denomination for
geometric operations such as rotations, scalations, translations, and other
relocation and/or alteration operations that can be performed on a vector or
raster dataset. Affine transformations are seldom used in GIS because their very
reason of existence is to modify the shape and position geometric data, and this
is a rarely needed or wanted operation to perform on existing geographic data.
However, is nice to have the posibility to perform such operations from a
semiology point of view. In this article we will revise the basics of affine
transformations, affine transformation composition, and a usage case in PostGIS.

## The Use Case

Check this polygon:

![Original data](assets/00.png)
