/*
I broke my Sprite Pro hot end cooling fan, so I made a model so it fits a 40mm fan instead of a 30mm fan. I don't use this anymore since I have a new 30mm fan and board now, but it worked well for a while. Here's the model if anyone else needs it
*/
// github.com/diademiemi/openscad_common
include <openscad_common/rounded_figures.scad>

union() {

    // MAIN BODY

    difference() {
        union() {
            // Main body
            rounded_cube([54, 50.5, 2.8], 2, flat_minus_z = true, flat_plus_z = true);

            // Side screw plate
            difference() {
                // Plate
                translate([54, 31, 0]) {
                    rounded_cube([2.5, 7.1, 13], 4, flat_minus_z = true, flat_minus_x = true, flat_plus_x = true);
                }

                // Hole
                translate([54, 34.55, 9.5]) rotate([0,90,0]) {
                    cylinder(r = 1.8, h = 3, $fn=24);
                    
                }

            }

            // Top notch
            translate([0, 45.5, 2.8]) {
                rounded_cube([54, 5, 1.3], 2, flat_minus_z = true, flat_plus_z = true, flat_minus_y = true);
            }
        }

        // Top notch heat inserts, TOO FAR TO THE CENTER
        translate([0, 48, 0]) {
            translate([3.5, 0, 0]) {
                cylinder(r = 1.9, h = 5, $fn=24);
            }
            translate([51, 0, 0]) {
                cylinder(r = 1.9, h = 5, $fn=24);
            }
        }

        translate([11.25, 40 , 0]) {
            rounded_cube([30, 9.5, 1.8], 2);
        }

        // Square cutout
        translate([25, 0, 0]) {
            rounded_cube([12, 8, 3], 3, flat_minus_z = true, flat_plus_z = true, flat_minus_y = true);
        }

        // Screw
        translate([17.2, 5.6, 0]) {
            cylinder(r = 1.8, h = 3, $fn=24);
        }

        // Screw passthrough
        translate([48.5, 5.5, 0]) {
            cylinder(r = 3.5, h = 3, $fn=24);
        }

        // Cutout for heater pins
        translate([44, 10, 0]) {
            rounded_cube([10, 5, 2], 3, flat_minus_z = true, flat_plus_z = true, flat_plus_x = true);
        }
    }

    // FAN DUCT
    
    cube([3,3,2.8]); // Make corner flat
    // Don't cross into next part
    intersection() {
        translate([-10,0,0]) cube([22,42,45.6]);
        union() {
            translate([-9.5, 2, 2.8]) rotate([0,0,-27]) {
                difference() {
                    // Fan mount
                    translate([0,-5,0]) cube([4, 55, 40]);  // Actual size is not 50, but I use 55 so it fills in the corners of the intersection
                    // Fan hole
                    translate([0, 7.5, 7.5]) cube([4, 25, 25]);


                    // Screw holes
                    rotate([0,-90,0]) translate([3.4,3.4,-4]) cylinder(r=1.8, h=5, $fn=24);
                    rotate([0,-90,0]) translate([36.6,3.4,-4]) cylinder(r=1.8, h=5, $fn=24);
                    rotate([0,-90,0]) translate([3.4,36.6,-4]) cylinder(r=1.8, h=5, $fn=24);
                    rotate([0,-90,0]) translate([36.6,36.6,-4]) cylinder(r=1.8, h=5, $fn=24);

                }

            }
            // Bottom plate
            hull() {
                translate([-10, 0, 0]) cube([22, 1, 2.8]);
                translate([11, 0, 0]) rotate([0, 0, 0]) rounded_cube([2, 42, 2.8], 2, flat_minus_y = true, flat_plus_y = true);
            }
            // Top plate
            hull() {
                translate([-10, 0, 42.8]) cube([22, 1, 2.8]);
                translate([11, 0, 42.8]) rotate([0, 0, 0]) rounded_cube([2, 42, 2.8], 2, flat_minus_y = true, flat_plus_y = true);
            }
            // Front plate
            translate([-10, 0, 0]) cube([22, 1, 42.8]);

            // Closing plate
            translate([11, 0, 0]) difference() {
                cube([1, 40, 42.8]);
                // Vent hole
                translate([0, 0, 2.8]) cube([1, 15, 20]);
            }

        }

    }

    // BLTouch mount
    translate([-5, 18, 45.6]) difference(){
    
        cube([15, 6, 27]);

        translate([7.5,6,5]) rotate([90,0,0]) cylinder(r=1.9, h=6, $fn=24);
        translate([7.5,6,22.5]) rotate([90,0,0]) cylinder(r=1.9, h=6, $fn=24);


    }
    translate([-5,14,44.6]) cube([10,10,1]);

    translate([9.5, 30, 45.6]) difference() {
            // Side screw plate
            // Plate
            rounded_cube([2.5, 7.1, 8], 4, flat_minus_z = true, flat_minus_x = true, flat_plus_x = true);

            // Hole
            translate([0, 3.5, 4.25]) rotate([0,90,0]) {
                cylinder(r = 1.8, h = 3, $fn=24);
            }

        }

    /*
    The fan duct should close at the bottom. Have a panel at the side facing the extruder.
    It should only open at the panel at the bottom left for the size of the betal block.
    This is where the air exists. The duct can be moved 1cm to the right
    */


}

