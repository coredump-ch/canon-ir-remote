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

casing();
*battery_holder();
*attiny();
cutouts();


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

// Add rounded edges to the case.
module casing() {
	minkowski() {
		case_base(CASE_H - 1);
		sphere(2);
	}
}

// Cutouts
module cutouts() {

	// LED Hole
	translate([0,47.5,0]) rotate([90,0,0]) {
		cylinder(h=3, r=2.5, $fn=RES);
	}

	// Inside
	case_base(CASE_H);
}

// Battery holder for CR2032
module battery_holder() {
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
module attiny() {
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