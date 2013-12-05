/**
 * Canon IR remote case v2.0.
 * Based on the design by Ted Lin (http://www.thingiverse.com/thing:9914).
 *
 * Author: Danilo Bargen (http://www.thingiverse.com/dbrgn)
 * License: CC BY-SA
 */

// VARIABLES

// Inner height of case (cutout).
CASE_H = 8.8;

// Heigh of the battery holder.
BAT_H = 4;

// Height of ATtiny holder
ATT_H = 1.2;

// Increase this to get "rounder" curves.
// This will increase compilation time.
RES = 20;


// MAIN

union() {
	bottom_casing();
	battery_holder([0,-3,0]);
	attiny([0,17,0]);
}


// MODULES

// The basic shape of the remote.
module case_base(h)
{
	linear_extrude(height=h, center=true) hull()
	{
		translate([0,40]) scale([1,0.5]) circle(10, $fn=RES);
		scale([1,0.8]) circle(20, $fn=RES);
	}
}

// Plane to remove top/bottom half of the model
// Use a "side" value of -1 for the lower half,
// and 1 for the upper half.
module halving(side) {
	translate([0,0,side*10])
		cube([100,100,20], center=true);
}

// Add rounded edges to the case.
module casing() {
	minkowski() {
		case_base(CASE_H - 1);
		sphere(2);
	}
}

// Top part of the case + cutouts
module top_casing() {
	difference() {
		casing();
		cutouts();
		halving(-1);
	}
}

// Bottom part of the case + cutouts
module bottom_casing() {
	difference() {
		casing();
		cutouts();
		halving(1);
	}
}

// Cutouts
module cutouts() {
	slider_rot = asin(10/40);
	slider_x = sin(slider_rot)*25 + 9.1;
	slider_y = 40 - cos(slider_rot)*25;

	union() {
		// LED Hole
		translate([0,47.5,0]) rotate([90,0,0]) {
			cylinder(h=3, r=2.5, $fn=RES);
		}

		// Inside
		case_base(CASE_H);

		// Top button
		translate([0,28,2]) cylinder(h=3, r=10, $fn=RES);

		// Slider button
		translate([-slider_x,slider_y,0]) rotate([0,0,-slider_rot]) union() {
			rotate([0,-90,0])
				cube([3.7,8.7,4], center=true);
			linear_extrude(height=3.7)
				polygon(points=[
					[-3.7/2,+8.7/2-1],[-3.7/2,-8.7/2+1],
					[-3.7/2-1.5,-8.7/2],[-3.7/2-1.5,+8.7/2]
				], paths=[0:3]);
		}
	}
}

// Battery holder for CR2032
module battery_holder(transl) {
	translate(transl)
	difference() {
		// Outer ring
		cylinder(h=BAT_H, r=12.05, center=true, $fn=50);

		// Inner ring
		cylinder(h=BAT_H, r=11.05, center=true, $fn=50);

		// Room for + connector
		translate([0,-3.85,-BAT_H/2]) cube([13.25,7.7,BAT_H]);

		// Room for - connector
		translate([-12.05,-1,-BAT_H/2]) cube([12.05,2,2]);
	}
}

// ATtiny13A
module attiny(transl) {
	translate(transl)
	difference() {
		cube([7,10,ATT_H], center=true);
		hull() {
			cube([5,8.5,ATT_H], center=true);
			translate([0,0,ATT_H/2]) {
				cube([6,9,0.1], center=true);
			}
		}
	}
}