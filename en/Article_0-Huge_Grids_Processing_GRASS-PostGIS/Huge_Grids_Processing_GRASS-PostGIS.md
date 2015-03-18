# Huge Grids Processing with GRASS 7 and PostGIS 2

__TAGS:__ grids, grass, postgis, concurrency

## Motivation

This workflow was motivated by the need to compute a regular territorial grid
over the full territory of Andalusia, the southern-most spanish region.
Andalusia has an area of 87,268 km<sup>2</sup>, and different sized grids were
to be generated. The starting blocks for building the grids is
[1 km EEA Reference Grid][0], based on the recomendations of the 1st European
Workshop on Reference Grids (2003), later adopted also by INSPIRE.

[0]: http://www.eea.europa.eu/data-and-maps/data/eea-reference-grids-2
