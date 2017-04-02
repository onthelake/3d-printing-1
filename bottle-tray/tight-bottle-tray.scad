// -*- mode: SCAD ; c-file-style: "ellemtel" ; coding: utf-8 -*-
//
// Parametric hex-grid bottle tray
//
// © 2017 Roland Sieker <ospalh@gmail.com>
// Licence: CC-BY-SA 4.0
// Loosely based on thingiverse thing  1345795,
// https://www.thingiverse.com/thing:1345795
// by Ian Pegg, https://www.thingiverse.com/deckingman/about
// CC-BY, Feb 2016
// And using an idea (the holes) by Tomas Ebringer
// https://www.thingiverse.com/Shii/about
// https://www.thingiverse.com/thing:1751410
// CC-BY, Sep 2016


// ***************************************************
// Change these to your needs:
bottle_diameter = 50;  // In mm.
x_count = 4;  // Number of bottles in a long row
y_count = 7;  // Number of rows
// You will get (x_count * y_count) - (y_count/2) bottle positions. Even y_counts >= 4 look a bit odd.


// ***************************************************
// Change these if you have to
bottom_height = 1.8;  // How thick (mm) the bottom will be
// Will end up as a multiple of your layer height after slicing

wall_width = 2;  // how thick the walls will be (mm).
// Pick a multiple of your nozzle size and enough perimeters that you
// don't get infill.
min_wall_width = 0.4;

clearance = 1; // Space added to the bottle diameter.
// Increase for looser fit and for shrinking prints.

height = 0.8 * bottle_diameter;  // Adjust to taste
hole_diameter = 0.5 * bottle_diameter;   // Adjust to taste. 0 for no hole

$fs = 0.1;

// ***************************************************
// Change below only if you know what you are doing.

r_i = bottle_diameter/2 + clearance;
r_h = hole_diameter/2;
r_o = r_i + wall_width;

x_step = 2*r_i+min_wall_width;
thf = sqrt(3)/2;  // (equilateral) triangle height factor
y_step = x_step*thf;

ms = 0.02; // Muggeseggele. To make the quick renderer work a little better.

difference()
{
   full_shape();
   holes();
}


module full_shape()
{
   for (y_c = [0:y_count-1])
   {
      if (y_c%2==0)
      {
         // Even, long row
         for (x_c = [0:x_count-1])
         {
            one_cylinder(x_c*x_step, y_c*y_step);
         }
      }
      else
      {
         // Odd, short row
         for (x_c = [0:x_count-2])
         {
            one_cylinder((x_c+0.5)*x_step, y_c*y_step);
         }
      }
   }
}


module holes()
{
   for (y_c = [0:y_count-1])
   {
      if (y_c%2==0)
      {
         // Even, long row
         for (x_c = [0:x_count-1])
         {
            one_hole(x_c*x_step, y_c*y_step);
         }
      }
      else
      {
         // Odd, short row
         for (x_c = [0:x_count-2])
         {
            one_hole((x_c+0.5)*x_step, y_c*y_step);
         }
      }
   }
}



module one_hole(x_pos, y_pos)
{
   translate([x_pos, y_pos, 0])
   {
      translate([0, 0, bottom_height])
      {
         cylinder(r=r_i, h=height);
      }
      if (hole_diameter)
      {
         translate([0,0, -ms])
         {
            cylinder(r=r_h, h=bottom_height+2*ms);
         }
      }
   }
}

module one_cylinder(x_pos, y_pos)
{
   translate([x_pos, y_pos, 0])
   {
      rotate(30)
      cylinder(r=r_o, h=height);
   }
}
