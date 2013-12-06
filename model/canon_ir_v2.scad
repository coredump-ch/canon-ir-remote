/**
 * Canon IR remote case v2.0.
 * Based on the design by Ted Lin (http://www.thingiverse.com/thing:9914).
 *
 * Author: Danilo Bargen (http://www.thingiverse.com/dbrgn)
 * License: CC BY-SA
 */


// VARIABLES

// Inner height of case (cutout).
CASE_H = 6.7;

// Height of ATtiny holder
ATT_H = 1.3;

// Height of button holder
BTN_H = 3.5;

// Increase this to get "rounder" curves.
// This will increase compilation time.
RES = 150;


// MAIN

// Uncomment the parts you want to hide.
part_top();
part_bottom();
part_button();


// PARTS

module part_top() {
	// Main parts
	difference() {
		casing();
		cutouts();
		halving(-1);
	}
	// Small inner ring
	translate([0,0,0.5]) intersection() {
		translate([0,20,2.8])
			cube([100,100,1], center=true);
		difference() {
			scale([0.98,0.98,1]) case_base(CASE_H - 1);
			scale([0.95,0.95,1]) case_base(CASE_H - 1);
		}
	}
}

module part_bottom() {
	difference() {
		casing();
		cutouts();
		halving(1);
	}
	battery_holder_cr1220([0,-3,0]);
	attiny([0,15.5,0]);
	button([0,28,0]);
	slider_support();
}

module part_button() {
	translate([0,28,2.35]) union() {
		cylinder(h=2.35, r=9.8, $fn=RES);
		cylinder(h=1, r=11.3, $fn=RES);
	}
	translate([0,28,0]) cylinder(h=2.7, r=2.4, $fn=RES);
}

// Plane to remove top/bottom half of the model
// Use a "side" value of -1 for the lower half,
// and 1 for the upper half.
module halving(side) {
	translate([0,0,side*10+(CASE_H/2)])
		cube([100,100,20], center=true);
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

// Add rounded edges to the case.
module casing() {
	minkowski() {
		case_base(CASE_H - 1);
		sphere(2);
	}
}

// Cutouts
module cutouts() {
	slider_rot = asin(10/40);
	slider_x = 16.74;
	slider_y = 40 - cos(slider_rot)*25;

	union() {
		// LED Hole
		translate([0,47.5,0]) rotate([90,0,0]) {
			cylinder(h=3, r=1.5, $fn=RES);
		}

		// Inside
		case_base(CASE_H);

		// Top button
		translate([0,28,2]) cylinder(h=3, r=10, $fn=RES);

		// Slider button
		translate([-slider_x,slider_y,0]) rotate([0,-90,-slider_rot])
		union() {
			cube([4.9,8.4,1], center=true);
			translate([-0.35,0,1]) cube([2.2,4.4,2], center=true);
		}
	}
}

// Battery holder for CR2032
module battery_holder_cr2032(transl) {
	height = 5;
	translate(transl)
	translate([0,0,-CASE_H/2+height/2])
	difference() {
		// Outer ring
		cylinder(h=height, r=12.05, center=true, $fn=RES);

		// Inner ring
		cylinder(h=height, r=11.05, center=true, $fn=RES);

		// Room for + connector
		translate([0,-3.85,-height/2]) cube([13.25,7.7,height]);

		// Room for - connector
		translate([-12.05,-1,-height/2]) cube([12.05,2,2]);
	}
}

// Battery holder for CR1220
module battery_holder_cr1220(transl) {
	height = 4.4+1.2;
	translate(transl)
	translate([0,0,-CASE_H/2+height/2])
	difference() {
		// Outer ring
		cylinder(h=height, r=8.5, center=true, $fn=RES);

		// Inner ring
		cylinder(h=height, r=7.5, center=true, $fn=RES);

		// Room for + connector
		translate([0,-2.5,-height/2]) cube([13.25,5,height]);

		// Room for - connector
		translate([-12.05,-1,-height/2]) cube([12.05,2,2]);
	}
}

// ATtiny13A
module attiny(transl) {
	translate(transl)
	translate([0,0,-CASE_H/2+ATT_H/2])
	difference() {
		cube([8,11,ATT_H], center=true);
		hull() {
			cube([5.5,9,ATT_H], center=true);
			translate([0,0,ATT_H/2]) {
				cube([6.5,9.5,0.1], center=true);
			}
		}
	}
}

// Button
module button(transl) {
	translate(transl)
	translate([0,0,-CASE_H/2+BTN_H/2])
	union() {
		// Main sides
		difference() {
			cube([7,9,BTN_H], center=true);
			cube([8,6,BTN_H], center=true);
		}
		// Top bars
		*translate([0,0,BTN_H/2+0.25]) difference() {
			cube([7,7,0.5], center=true);
			cube([7,5.5,0.5], center=true);
		}
	}
}

// Support platform for slider button
module slider_support() {
	slider_rot = asin(10/40);
	rotate([0,0,-slider_rot])
		translate([-18,11.1,-2.96])
			cube([3.7,8.4,1], center=true);
}
