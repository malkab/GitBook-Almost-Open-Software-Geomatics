/*

  Affine transformations in PostGIS examples.

  Needs a PostGIS 2 database.

  Geographica 2015

*/

begin;

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

create table affine.grid(
  gid bigint,
  geom geometry(POLYGON, 25830));
  
-- Copy data into tables from CSV

\copy affine.data from 'affine_data.csv' with delimiter '|' csv header quote '"' encoding 'utf-8'
\copy affine.axis from 'affine_axis.csv' with delimiter '|' csv header quote '"' encoding 'utf-8'
\copy affine.grid from 'Sevilla-250-Data.csv' with delimiter '|' csv header quote '"' encoding 'utf-8'

-- Transformations with PostGIS 2

-- Translate -1000,-500

insert into affine.data
select 2, 'Translate -1000,-500.',
       st_translate(
         (select geom from affine.data where gid=1),
	 -1000,-500);

-- Rotate PI/3 around the x axis

insert into affine.data
select 3, 'Rotation of PI/3 radians around the x axis.',
       st_rotatex(
         (select geom from affine.data where gid=1),
	 pi()/3);

-- Rotate PI/3 around the y axis

insert into affine.data
select 4, 'Rotation of PI/3 radians around the y axis.',
       st_rotatey(
         (select geom from affine.data where gid=1),
	 pi()/3);

-- Rotate PI/3 around the z axis

insert into affine.data
select 5, 'Rotation of PI/3 radians around the z axis.',
       st_rotatez(
         (select geom from affine.data where gid=1),
	 pi()/3);

-- Scale by a factor of 1.3

insert into affine.data
select 6, 'Scaling by a factor of 1.3.',
       st_scale(
         (select geom from affine.data where gid=1),
	 1.3, 1.3);

-- Scale by a factor of 0.7

insert into affine.data
select 7, 'Scaling by a factor of 0.7.',
       st_scale(
         (select geom from affine.data where gid=1),
	 0.7, 0.7);

-- Final

select
  gid,
  st_translate(
    st_rotate(
      st_scale(
        st_translate(
          geom,
          -st_x(st_centroid(geom)),
          -st_y(st_centroid(geom))),
        0.6,
        0.6),
      -0.2),
    st_x(st_centroid(geom)),
    st_y(st_centroid(geom))) as geom
from
  affine.grid;
	       











commit;
