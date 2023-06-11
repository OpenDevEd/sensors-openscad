//
// Sensors with cad models:
// - SHT40 (not used, but similar to sht45)
// - AHT20
// - MCP9808 (2 versions)
// Sensors without cad models:
// - Adafruit BH1750
// - LTR-559
// - BH1745 
// - Adafruit AM2301B Wired enclosed shell

use <lib/pin_header.scad>;
use <utilities.scad>;

// minimum angle
$fa = 1;
// minimum size
$fs = 0.4;
// number of fragments 
$fn = 48; 
    
module sensor(type_in="", 
    number=0,
    showsensor=true,
    showcol=false,
    diameter="", diameterfraction="",
    makeheader=true, 
    mountabove=false, 
    centeronheader=true,
    extruder="", extrude="", 
    makelabel=true, labelsize=3,
    showcube=true) {

    // sensorspec = getsensorspec();
 
    spec = select_sensor(type_in, number);
        
    type = spec[0];    
    label = spec[1];
    file = spec[2];
    dim_x = spec[3] * spec[4][0];
    dim_y = spec[3] * spec[4][1];
    coltr_x = spec[3] * spec[5][0];
    coltr_y = spec[3] * spec[5][1];
    mh_x = spec[3] * spec[6][0];
    mh_y = spec[3] * spec[6][1];
    dia = (diameterfraction != "" ? diameterfraction : 1) *
            (diameter != "" ? diameter : spec[3] * spec[7]);
    pin_x = spec[8][0];
    pin_y = spec[8][1];    
    pin_dx = spec[3] * spec[9][0];
    pin_dy = spec[3] * spec[9][1];    

    rx = extrude=="y" ?  90 : 0;
    ry = extrude=="x" ? -90 : 0;
    rz = 0;

    extrudeZ = extrude=="y" ? dim_y : 
                extrude=="x" ? dim_x :
                    extruder;

    translate([centeronheader?-pin_dx:0,centeronheader?-pin_dy:0,0])
        generate_shape();
    
    module generate_shape() {
        if (showsensor) {
            color("lightblue") {
                if (search( ".stl" , file) != []) {
                    makeSensor();
                } else {
                    buildSensor();
                };
            };
        };
    
        if (showcol) {
            makeCylinderSet(dx=coltr_x, dy=coltr_y, ddx=mh_x, ddy=mh_y, d=dia);
        };
        inch=25.4;
        if (makeheader) {
            translate([pin_dx,pin_dy,mountabove? -0.028*inch : 0.089*inch]) rotate([mountabove? 0 : 180,0,0]) pin_header(pin_x, pin_y,center=false  );
        };
    
        if (makelabel) {
            translate([0,(dim_y-labelsize)/2,5]) color("black") text(label, halign="left", size=labelsize);
        };     
     
        if (showcube) {
            color("red") cube([dim_x,dim_y,1]); 
        };
    };

    module makeSensor() {
        if (extruder=="") {
            import(file);
        } else {
            if (extrudeZ >= 0) {
               rotate([-rx,-ry,-rz]) linear_extrude(extrudeZ)  projection() rotate([rx,ry,rz]) import(file);
            } else {
                translate([0,0,extrudeZ]) 
                linear_extrude(-extrudeZ) projection() import(file);
            };
        };
    };
    
    module buildSensor() {
        sensor_garden_generic();
    };
        
    function selector(item="", number=0, dict) = 
        (item != "" ? dict[search([item], dict)[0]] : dict[number]);
    
    function select_sensor(item, number=0) = selector(item, number, getsensorspec() );
    
    module makeCylinderSet(dx=0, dy=0, d=2.5, ddx=0, ddy=0, z=2, offset=10) {
            translate([dx,dy,-offset]) {
                cylinder(z+offset*2, r=d/2); 
                if (ddx != 0)
                    translate([ddx,0,0]) cylinder(z+offset*2, r=d/2); 
                if (ddy != 0)
                    translate([0,ddy,0]) cylinder(z+offset*2, r=d/2); 
                if (ddx != 0 && ddy != 0)
                    translate([ddx,ddy,0]) cylinder(z+offset*2, r=d/2); 
            }
    };
 
    // echo(spec);
    // descr, label, stl file,
    // scale,
    // [sensor_x, sensor_y],
    // [hole1_x, hole1_y],
    // [additional_hole_x_from_hole_1, additional_hole_y_from_hole_1], 
    // mount_hole_diam
    // [pins_x, pins_y]
    function getsensorspec() = [
        [
            "bh1750", 
            "~BH1750~", 
            "models/5027-MCP9808-Stemma.stl", 
                25.4, [1,0.7], [0.1,0.1], [0.8,0.5], 0.1, [1,6], [0.25,0.1] 
        ],[
            "sht40", 
            "SHT40", 
            "models/4485-SHT40.stl", 
                25.4, [1,0.7], [0.1,0.1], [0.8,0.5], 0.1, [1,5], [0.3,0.1] 
        ],[
            "sht45", 
            "SHT45", 
            "models/4485-SHT40.stl", 
                25.4, [1,0.7], [0.1,0.1], [0.8,0.5], 0.1, [1,5], [0.3,0.1] 
        ],[
            "aht20", 
            "AHT20", 
            "models/4566-AHT20-Sensor.stl", 
                25.4, [1,0.7], [0.1,0.1], [0.8,0.5], 0.1, [1,4], [0.35,0.1] 
        ],[
            "mcp9808qwst", 
            "MCP9808 Qw/ST", 
            "models/5027-MCP9808-Stemma.stl",
                25.4, [1,0.7], [0.1,0.1], [0.8,0.5], 0.1, [1,6], [0.25,0.1] 
        ],[
            "mcp9808", 
            "MCP9808", 
            "models/1782-MCP9808.stl",
                25.4, [0.8,0.5], [0.1,0.4], [0.60,0], 0.1, [1,8], [0.05,0.1] 
        ],[
            "pdmjst", 
            "PDM Qw/ST", 
            "models/PDM-Mic-with-JST-SH.stl",
                25.4, [0.55,0.55], [0.1,0.45], [0.35,0], 0.1, [0,0], [0,0] 
        ],[
            "qwsthub", 
            "QW/ST Hub", 
            "models/5625_Stemma_5_Port_Hub.stl",
                25.4, [1.00,0.70], [0.1,0.10], [0.80,0.5], 0.1, [1,4], [0.35,0.1] 
        ],[
            "ltr559", 
            "LTR-559", 
            "garden",
                1, [19.00,19], [2.45,16.55], [14.1,0], 2.30, [1,5], [4.42,0.75] 
        ],[
            "bh1745", 
            "BH1745", 
            "garden",
                1, [19.00,19], [2.45,16.55], [14.1,0], 2.30, [1,5], [4.42,0.75] 
        ]
        // The cutouts should be at half of 19 = 9.5, - 2.54*2
        // 9.5 - 2.54*2 = 4.42               
    ];    

};


sensor(
    number=+3,
    showcol=true,
    mountabove=false,
    diameterfraction=1);
/*
// Pimoroni Garden
module sensor_ltr559(punch=false, both=false) {
    sensor_garden_generic("LTR-559", punch=punch, both=both) ;
};

module sensor_bh1745(punch=false, both=false) {
    sensor_garden_generic("BH1745", punch=punch, both=both) ;
};*/

module sensor_garden_generic() {
    // text="Garden";
    punch=false;
    both=false;
    showpins=false;
    // translate([1,9,5]) color("black") text(text,size=3);
    difference() {
        color("lightblue") cube([19,19,4.7]);
        union() {
            tol=0.1;
            // cut out at bottom
            bottomcut=5.5;
            translate([-tol,+0-tol,2]) cube([19+tol,bottomcut+tol,4]);
            // side cutouts:
            translate([-tol,-tol,-1]) cube([2+tol,bottomcut+tol,7]);
            translate([19-2,-tol,-1]) cube([2+tol,bottomcut+tol,7]);
            // cutout at top
            // translate([-1,14,2]) cube([21,10,4]);
            adjust=3;
            translate([-1,14,2]) cube([3+adjust,6,7]);
            translate([17-adjust,14,2]) cube([5+tol,6,7]);              
            sensorMountHoleGarden();
            translate([19/2,0.75,-5.6]) rotate([0,0,90]) pin_header(5,1);
       };
    };

    showguides=false;
    // holes have 1.3 mm clearance, prob 1/2 inch?
    if (showguides) {
        clearance = 1.3;    
        holesize = 2.3;
        color("red") translate([0,19-2*clearance-holesize,+1]) //cube([25,clearance,+1]);  
        frame(19,
            clearance*2+holesize,cornerspace=0,
            thickness=1.2, cornerarch=false, cornerinsidearch=false);
    };
    if (showpins) {
        if (showguides) translate([3.15,0,0]) cube([5*2.54,0.70,5]);
        translate([19/2,0.75,-5.6]) rotate([0,0,90]) pin_header(5,1);
    };
    module sensorMountHoleGarden() {
        clearance = 1.3;    
        holesize = 2.3;
        xx = 19 - (1.3 + 2.3/2 + 2.3/2 + 1.3);    
        translate([1.3+holesize/2,19-clearance-holesize/2,0]) color("green") 
            cylinderSet(xx, +4, z=10, d=holesize, n=2);
    }

    module cylinderSet(x, y, z=10, d=2.5, dx=0, dy=0, n=4, ddx=0, ddy=0, inch=false) {
    /*
        x,y: size of board (specify hole offset with dx, dy)
             or: size of rectangle of holes (dx=dy=0)
                 specifiy offset with ddx, ddy.
        n:   number of cylinders to make
        inch: values for x,y,dx,dy,ddx,ddy are specified in tenth of inch.
        d:   diameter of cylinders (always in mm)
        z:   height of cylinder (always in mm)
    */    
        if (inch) {
            inch=25.4/10;
            makeCylinderSet(x*inch, y*inch, 
                z=z, d=d, 
                dx=dx*inch, 
                dy=(dy>0 ? dy*inch : dx*inch),
                n=n, 
                ddx=ddx*inch, 
                ddy=(ddy>0 ? ddy*inch : ddx*inch)
            );
        } else {
            makeCylinderSet(x, y, z=z, d=d, 
            dx=dx, 
            dy=(dy>0 ? dy : dx),
            n=n, 
            ddx=ddx, 
            ddy=(ddy>0 ? ddy : ddx)
            );
        };
    };
    
    module makeCylinderSet(x, y, z=10, d=2.5, dx=0, dy=0, n=4, ddx=0, ddy=0) {
        translate([ddx,ddy,-z/2]) {
            translate([0+dx,0+dy,0]) cylinder(z, r=d/2); 
            if (n>1)
                translate([x-dx,0+dy,0]) cylinder(z, r=d/2); 
            if (n>2)
                translate([0+dx,y-dy,0]) cylinder(z, r=d/2); 
            if (n>3)
                translate([x-dx,y-dy,0]) cylinder(z, r=d/2); 
        }
    };



};
 



// Adafruit QW/ST
// - outer 1.00 by 0.70
// - outer(mm) 25.4 by 17.78
// - hole spacing 0.8 by 0.5
// - hole: 0.1
// mcp9808 non-QW/ST
// - outer: 0.8 by 0.5
// - outer(mm): 20.32 by 12.7
// - hole spacing: 0.6
// - hole: 0.1
// https://learn.adafruit.com/adafruit-mcp9808-precision-i2c-temperature-sensor-guide/downloads

/*
Characteristics:
(1) Dimensions (length by width)
(2) Mounting holes?
        (2a) How many mounting holes? Typically 2 or 4.
        (2b) Location? Typically there's an offset (dx, dy) from the corners, which determines where the holes are, e.g., dx=dy=2.54mm
        (2c) Mounting hole diameter (e.g., 2.3mm).
(3) Header pins
        (3a) Number of header pin row (typically 4,5,6,8)
        (3b) Location of header pin row
(4) Flat area
        The sensors have components mounted in the center, but towards the edge have an area without components. 
                
*/
  
