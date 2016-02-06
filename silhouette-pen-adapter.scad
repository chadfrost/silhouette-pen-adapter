// Silhouette plotter/cutter pen holder
// 
// Chad Frost
// https://github.com/chadfrost/silhouette-pen-adapter
// Based on http://www.thingiverse.com/thing:303835

pen_barrel_diam = 9.36;
pen_tip_diam = 3.00;
pen_tip_length = 5.00;

adapter_od = 13.84+0.1;
adapter_height = 47.0;

flange_height = 27.10+3.23; // from face of flange, to tip
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

nut_holder_wall = 2.0;
nut_holder_offset = 1.0; // x-offset from barrel, to accommodate larger pen od

// setscrew location (from base end of adapter)
screw_position = nut_width / 2 + nut_clearance + nut_holder_wall;


difference(){
// build up solid:
    union(){
        // adapter barrel
        cylinder(d=adapter_od, h=adapter_height);

        // nut holder
        translate([adapter_od/2,0,screw_position]){
            cube([nut_thickness+nut_clearance+adapter_od/2, nut_width+nut_clearance+nut_holder_wall*2, nut_width+nut_clearance+nut_holder_wall*2], center=true);
            //+nut_holder_wall+nut_holder_offset
        }
        
        // flange
         translate([0,0,flange_height]){
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
    translate([0,0,-1]) cylinder(d=pen_barrel_diam, h=adapter_height+2);

    // nut holder interior
    translate([adapter_od/2+nut_holder_offset,0,screw_position]){
        #translate([0,0,-nut_holder_wall]) 
            cube([nut_thickness+nut_clearance, nut_width+nut_clearance, nut_width+nut_clearance+nut_holder_wall+1], center=true);
        
        #rotate([0,90,0]) 
            cylinder(d=screw_thread_diam+screw_clearance, h=nut_thickness+nut_holder_wall*2+nut_clearance+5, center=true);
    }
}
