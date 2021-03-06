// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// A soap dish.
// Inspired by “Ultramodern Soap Dish”, https://www.thingiverse.com/thing:1394419
//
// © 2017 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0

rx = 60;
ry = 45;
zmin = 6;

w = 3;
g = 3;

//
rs = 3;
rk = 4 * rx;
zmax=30;

$fs = 0.2;

intersection()
{
   union()
   {
      difference()
      {
         union()
         {
            for (roff =[0:w+g:rx])
            {
               // The main dish
               rotate_extrude()
               {
                  translate([roff, 0])
                  {
                     square([w,zmax]);
                  }
               }
            }
            // Two support members holding it together
            rotate([0, 90, 0])
            {
               cylinder(r=rs, h=2*rx, center=true);
            }
            rotate([90, 0, 0])
            {
               cylinder(r=rs, h=2*ry, center=true);
            }
         }
         // The hollow
         translate([0,0,zmin+rk])
         {
            sphere(r=rk);
         }
         // Cut off half of the supports
         translate([0, 0, -zmin])
         {
            cylinder(r=rx, h=zmin);
         }
      }
   }
   // Make it an ellipse
   scale([1, ry/rx, 1.01])
   {
      cylinder(r=rx+w, h=zmax);
   }
}
