/*

  Affine transformations in PostGIS examples.

  Needs a PostGIS 2 database.

  Geographica 2015

*/

-- Create the schema 'affine'

create schema affine;

-- Data table

create table affine.data(
  gid integer,
  description text,
  geom geometry(MULTIPOLYGON, 25830));

create table affine.axis(
  gid integer,
  geom geometry(LINESTRING, 25830));

-- Copy data into tables from CSV

\copy affine.data from 'affine_data.csv' with delimiter '|' csv header quote '"' encoding 'utf-8'
\copy affine.axis from 'affine_axis.csv' with delimiter '|' csv header quote '"' encoding 'utf-8'
