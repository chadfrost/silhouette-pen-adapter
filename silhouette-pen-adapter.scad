// Silhouette plotter/cutter pen holder
// 
// Chad Frost
// https://github.com/chadfrost/silhouette-pen-adapter
// Based on http://www.thingiverse.com/thing:303835

$fn = 200; // finer detail on cylinders

//pen_barrel_diam = 10.5+0.2;  // starting value from Thingiverse jscad adapter
pen_barrel_diam = 12.0; // larger version for sharpie
pen_tip_diam = 3.00; // not used
pen_tip_length = 5.00; // not used

// adapter_od = 13.84+0.1; // starting value from Thingiverse jscad adapter; this was a bit too large on our printrbot

adapter_od = 13.80;

// adapter_height = 47.0; // overall length; starting value from Thingiverse jscad adapter
adapter_height = 40.0; // with tip nub/hole/stop removed from design, leaving a little extra distance so flange will still work as repeatable stop

flange_height = 30.0-7.0; // from face of flange, to end of adapter
flange_edge_thickness = 1.0;
flange_od = adapter_od+4.0;

tip_od = 9.83;
tip_length = 3.23;

// captive nut dims (as measured)
nut_thickness = 3.80;
nut_width = 8.50;
nut_clearance = 0.2;

// setscrew dims (as measured)
screw_head_diam = 6.40;
screw_head_height = 4.00;
screw_thread_diam = 5.60;
screw_clearance = 0.2;

nut_holder_wall = 1.5;
nut_holder_offset = 2.5; // x-offset from barrel, to accommodate larger pen od

// setscrew location (from base end of adapter)
screw_position = nut_width / 2 + nut_clearance + nut_holder_wall;


difference(){
// build up solid:
    union(){
        // adapter barrel
        cylinder(d=adapter_od, h=adapter_height);

        // nut holder
        translate([0,-(nut_width+nut_clearance+nut_holder_wall*2)/2,0]){
            cube([nut_thickness+nut_clearance+nut_holder_wall+adapter_od/2+nut_holder_offset/2, nut_width+nut_clearance+nut_holder_wall*2, screw_position+(nut_width/1.732)+nut_clearance+nut_holder_wall]);
        }
        
        // flange
         translate([0,0,adapter_height-flange_height]){
            rotate_extrude(angle = 360, convexity = 2) {
                // flange
                //translate([adapter_od/2, 0, 0]){
                    polygon( points=[[adapter_od/2,0],[flange_od/2,0],[flange_od/2,-flange_edge_thickness],[adapter_od/2,-(flange_od-adapter_od+flange_edge_thickness)]]);
                //}
            }
        }
    }

// remove material:
    // adapter interior, to (approx) match pen
    translate([0,0,-1]) cylinder(d=pen_barrel_diam, h=adapter_height+2); // extra height to ensure penetration of upper + lower adapter surfaces

    // nut holder interior
    translate([adapter_od/2+nut_holder_offset,0,screw_position]){
        translate([0,0,-nut_holder_wall]) 
            #cube([nut_thickness+nut_clearance, nut_width+nut_clearance, nut_width+nut_clearance+nut_holder_wall*2+1], center=true);
        
        #rotate([0,90,0]) 
            cylinder(d=screw_thread_diam+screw_clearance, h=nut_thickness+nut_holder_wall*2+nut_clearance+5, center=true);
    }
}
