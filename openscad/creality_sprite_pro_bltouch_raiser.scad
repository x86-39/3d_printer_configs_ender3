include <openscad_common/rounded_figures.scad>

bltouch_size = [25, 10, 3];
extruder_size = [25, 15, 3];

screw_hole_radius = 1.5;


extra_height = 3.6;

wall_thickness = 4;
sprite_pro_extruder_thickness = 3.5;
wall_height = bltouch_size[2]*2 + extra_height;

bltouch_mount_thickness = 1.9;

module bltouch_mount(bltouch_size = bltouch_size, screw_hole_radius = screw_hole_radius) {
    difference() {
        rounded_cube(bltouch_size, 3, flat_plus_z=true, flat_minus_z=true, flat_minus_y=true);
        translate([2.5 + screw_hole_radius, bltouch_size[1] / 2, 0]) {
            translate([0, 0, bltouch_size[2]/2]) cylinder(r=1.5, h=bltouch_size[2]*2, center=true, $fn=64);
        }
        translate([bltouch_size[0] - 2.5 - screw_hole_radius, bltouch_size[1] / 2, 0]) {
            translate([0, 0, bltouch_size[2]/2]) cylinder(r=1.5, h=bltouch_size[2]*2, center=true, $fn=64);
        }
    }
}


module extruder_mount(extruder_size = extruder_size, screw_hole_radius = screw_hole_radius) {
    difference() {
        rounded_cube(extruder_size, 3, flat_plus_z=true, flat_minus_z=true, flat_minus_y=true);
        translate([2.5 + screw_hole_radius, extruder_size[1] / 2, 0]) {
            translate([0, 0, extruder_size[2]/2]) cylinder(r=1.5, h=extruder_size[2]*2, center=true, $fn=64);
        }
        translate([extruder_size[0] - 2.5 - screw_hole_radius, extruder_size[1] / 2, 0]) {
            translate([0, 0, extruder_size[2]/2]) cylinder(r=1.5, h=extruder_size[2]*2, center=true, $fn=64);
        }
    }
}


// Extruder Mount

extruder_mount();

translate([0, 0, bltouch_size[2] + sprite_pro_extruder_thickness]) {
    difference() {
        extruder_mount();
        translate([extruder_size[0]/4, 0, 0]) cube([extruder_size[0]/2, extruder_size[1], extruder_size[2]]);
    }
}

// Wall

translate([0, -wall_thickness, 0]) {
    cube([bltouch_size[0], wall_thickness, wall_height]);
}

// BlTouch Mount

translate([0, -(wall_thickness), (bltouch_size[2]*2) + extra_height]) {
    rotate([180, 0, 0]) bltouch_mount();
}

translate([0, -(wall_thickness), (bltouch_size[2]) + extra_height - bltouch_mount_thickness]) {
    rotate([180, 0, 0]) difference() {
        bltouch_mount();
        translate([bltouch_size[0]/4, 0, 0]) cube([bltouch_size[0]/2, bltouch_size[1], bltouch_size[2]]);
    }
}