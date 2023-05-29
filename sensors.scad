//
// https://github.com/OpenDevEd/case-for-pico-datalogger-rev0.98
//
// module sensor_demo(both=true) {
// 
// Print 'pads' for sensors.
//
// module mount_ada_st_size1_pins4(x, y, z=1, pad=1) {
//  repeats rectangles, showing layout for multiple sensors
// module mount_garden(x, y, z=1, pad=1) {
//  same, but for pimoroni garden size
// module mount_ada_mcp(x, y, z=1, pad=1) {
//  same, but for ada mcp size
// module mount_generic(dx_in, dy_in, z, pad) {
//  utility module

// Specific sensors:
//
// module sensor_ltr559(punch=false, both=false) {
//  print and ltr559 sensor. punch=true prints rods useful for difference. both=true shows both sensor and rods for positioning.
// module sensor_bh1745(punch=false, both=false) {
// module sensor_mcp9808(punch=false, both=false) {
//  as above, but for mcp9808 (non-Qw/ST version)
// module sensor_(punch=false, both=false) {
//  as above, but for sht40
// module sensor_sht45(punch=false, both=false) {
//  as above, but with label sht45 (cad model uses sht40)
// module sensor_mcp9808st(punch=false, both=false) {
//  as above, for Qw/ST version of mcp9808
// module sensor_aht20(punch=false, both=false) {
//  as above for aht20
// module sensor_bh1750(punch=false, both=false) {
//  as above, but with bh1750 label (cad model uses sht40)

//
// Utility functions
//
// module importLabel(file, label="X", size=3) {
// module AdafruitQWST(file, label="X", size=3, punch=false, both=false) {
// module sensorMountHole(diameter = 2.5) {

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

sensor_demo(both=true); 

// minimum angle
$fa = 1;
// minimum size
$fs = 0.4;
// number of fragments 
$fn = 48; 

module sensor_demo(both=true) {
    translate([-120,10,0])   sensor(label="1. Sensor only.");
    translate([-120,-20,0]) sensor(showsensorholes=true, label="2. Sensor holes shown.");
    translate([-160,-20,0]) {
        difference() {
            cube([30,20,2]) ;
            sensor(showsensor=false, showsensorholes=true);    
        };
        translate([0,0,2]) sensor(label="2a");
        // Sensor mounted above base plate, e.g. for use with i2c.
    };
    
    translate([-120,-50,0])  {
        translate([0,0,0]) sensor(showpilotholes=true, label="3. Sensor pilot holes shown.");
        translate([-40,0,0]) {
            difference() {
                cube([30,20,2]) ;
                sensor(showsensor=false, showpilotholes=true);    
            };
            translate([0,0,2]) sensor(label="3a");
            // Sensor mounted above base plate, e.g. for use with i2c.
        };
        /*
         translate([-80,0,0]) {
            difference() {
                cube([30,20,2]) ;
                sensor(showcutout=true, showsensorholes=true);    
            };
            translate([0,0,+2]) sensor(label="3b");
            // Sensor mounted above base plate, e.g. for use with i2c.
        }; */
    };

    translate([-120,-80,0])  {
        translate([0,0,0]) sensor(showcutout=true, label="4. Mount sensor below");
        translate([-40,0,0]) {
            difference() {
                cube([30,20,2]) ;
                sensor(showcutout=true, showpilotholes=true);    
            };
            translate([0,0,-2]) sensor(label="4a");
            // Sensor mounted above base plate, e.g. for use with i2c.
        };
        translate([-80,0,0]) {
            difference() {
                cube([30,20,2]) ;
                sensor(showcutout=true, showsensorholes=true);    
            };
            translate([0,0,-2]) sensor(label="4b");
            // Sensor mounted above base plate, e.g. for use with i2c.
        };
    };
    
    
    
    // translate([-120,-80,0])  sensor(showsensor=true, showpilotholes=true, showcutout=true, label="4. Mount sensor below");
   
    translate([0,60,0]) {
        translate([-10,0,0]) color("black") text("A");
        sensor_aht20(both=both);
        translate([40,0,0]) {
            mount_ada_st_size1_pins4(3,1, col="red");
            sensor_aht20(both=both);
        };
    };
    translate([0,40,0]) {
        translate([-10,0,0]) color("black") text("B");
        sensor_mcp9808st(both=both);
        translate([40,0,0]) {
            mount_ada_st_size1_pins6(3,1, col="yellow");
            sensor_mcp9808st(both=both);
        };
        
    };
    translate([0,20,0]) {
        translate([-10,0,0]) color("black") text("C");
        sensor_sht45(both=both);
        translate([40,0,0]) {
            mount_ada_st_size1_pins5(3,1,col="red");
            sensor_sht45(both=both);
        }   
    };

    translate([0,0,0]) {
        translate([-10,0,0]) color("black") text("D");
            sensor_bh1750(both=both);
        translate([40,0,0]) {
            mount_ada_st_size1_pins6(3,1,col="yellow");
            sensor_bh1750(both=both);
        }   
    };
   
    translate([0,-20,0]) {
        sensor_mcp9808(both=both);
    };
    translate([0,80,0]) {
        sensor_ltr559(both=both);
    };
    translate([0,110,0]) {
        sensor_bh1745(both=both);
    };
   
    translate([-120,80,0]) {
        translate([-31,0,0]) text("D1");
        difference([]) {
            translate([-10,-10,0]) cube([50,110,4]);    
            translate([0,0,0]) mount_garden(schablone=true, showpins=true);
            translate([0,25,0]) mount_ada_mcp(schablone=true);
            translate([0,40,0]) mount_ada_st_size1_pins4(schablone=true);
        };
        translate([0,0,0]) mount_garden(showpins=true, showpinsonly=true); 
        translate([0,25,0]) mount_ada_mcp(showpins=true, showpinsonly=true);
        translate([0,40,0]) mount_ada_st_size1_pins4(showpins=true, showpinsonly=true);
    };
    
    translate([25,-40,0])  {
        mount_ada_mcp(3,1, col="blue");
        translate([0,0,-2]) sensor_mcp9808();
    };
    translate([0,-60,0]) sensor_pdm(both=both) ;
    translate([0,-80,0]) sensor_qwst_hub5(both=both);
    
    translate([0,-110.00,0])  
    {
        difference() {
            translate([-10,-10,0]) cube([40,30,4]);    
            mount_ada_mems_i2s(schablone=true);
        };
        mount_ada_mems_i2s();

    };
};

module sensor(type="bh1750", showsensor=true, mode=0, label="",
    showpilotholes=false, showsensorholes=false, showcutout=false) {
    if (type=="bh1750") {
        // Loop up sensor parameters by type...
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
    };
    // Show a label
    if (label != "") 
        translate([0,20,6]) color("black") text(label, size=5);
    // Show the sensor
    if (showsensor)
        sensor_bh1750();
    // Show the pilot holes for mounting with wood screws
    if (showpilotholes)
        translate([0,0,-15]) mount_ada_st_size1_pins6(mount_pins_above_sensor=true,  mount_pins_adjust=2, colonly=false, showpins=false, showpinsonly=false,schablone=true);
    // Show the sensor holes for mounting with machine screws (e.g., nylon)
    if (showsensorholes)
        mount_ada_st_size1_pins6(mount_pins_above_sensor=true,  mount_pins_adjust=2, colonly=true, showpins=false, showpinsonly=false,schablone=false);
    if (showcutout)
        translate([0,0,0]) mount_ada_st_size1_pins6(mount_pins_above_sensor=true,  mount_pins_adjust=2, colonly=false, showpins=false, showpinsonly=false,schablone=true);


};


// mounts/repeated mounts for 'generic pads' (by sensor mount types):
// Adafruit QwST sensors: 1 x 0.7 inch
// This was mount_ada_st()
module mount_ada_st_size1_pins4(nx=1, ny=1, z=2, pad=2, slicex=0, slicey=8.5, 
    extendx=0, extendy=0, slicepadx=0, slicepady=0, 
    clearpins=true, showpins=true, showpinsonly=false,mount_pins_above_sensor=false, mount_pins_adjust=-4, punch=true, 
    both=false, solid=false, colonly=false, col="yellow",
    schablone=false, schablone_height=10, schablone_diameter=1) {
    inch=25.4;
    dx = inch;
    dy = 0.7 * inch;
    mount_generic(dx, dy, z=z, pad=pad, 
        slicex=(solid ? 0 : slicex), slicey=(solid ? 0 : slicey), 
        extendx=(solid ? 0 : extendx), extendy=(solid ? 0 : extendy), 
        slicepadx=(solid ? 0 : slicepadx), slicepady=(solid ? 0 : slicepady),
        clearpins=(solid ? false : clearpins),
        showpins=showpins, showpinsonly=showpinsonly,
        npins=4,
        mount_pins_above_sensor=mount_pins_above_sensor,
        mount_pins_adjust=mount_pins_adjust,
        punch=punch, both=both, colonly=colonly, punchtype="ada_1.0",
        col=col,
        schablone_height=(!schablone ? "" : schablone_height),
        schablone_diameter=(!schablone ? "" : schablone_diameter)       
    );
};

// This fits the ada mcp9808 in the non-qw/st version
module mount_ada_mcp(nx=1, ny=1, z=2, pad=2, 
    slicex=0, slicey=+3.5, extendx=2, extendy=3, 
    slicepadx=0, slicepady=+1, 
    clearpins=true,showpins=true, showpinsonly=false,
    mount_pins_above_sensor=false,
    mount_pins_adjust=-4, 
    punch=true, both=false,colonly=false, solid=false, col="yellow",
    schablone=false, schablone_height=10, schablone_diameter=1) {
    
    inch=25.4;
    dx = 0.8 * inch;
    dy = 0.5 * inch;
    
    mount_generic(dx, dy, z=z, pad=pad,
        slicex=(solid ? 0 : slicex), slicey=(solid ? 0 : slicey), 
        extendx=(solid ? 0 : extendx), extendy=(solid ? 0 : extendy), 
        slicepadx=(solid ? 0 : slicepadx), slicepady=(solid ? 0 : slicepady),
        clearpins=(solid ? false : clearpins),
        clearpin_cutoutx=22.32, clearpin_cutouty=+5, 
        showpins=showpins, showpinsonly=showpinsonly,
        npins=8,
        mount_pins_above_sensor=mount_pins_above_sensor,
        mount_pins_adjust=mount_pins_adjust,
        punch=punch, both=both,colonly=colonly, punchtype="ada_0.8", col=col,
        schablone_height=(!schablone ? "" : schablone_height),
        schablone_diameter=(!schablone ? "" : schablone_diameter)  
        );
};

// This fits the ada mems i2s (non-qw/st version)
// https://learn.adafruit.com/assets/39634
module mount_ada_mems_i2s(nx=1, ny=1, z=2, pad=2, 
    slicex=0, slicey=+3.5, extendx=2, extendy=3, 
    slicepadx=0, slicepady=0, 
    clearpins=true,showpins=true, showpinsonly=false,
    mount_pins_above_sensor=false,
    mount_pins_adjust=-4, 
    punch=true, both=false,colonly=false, solid=false, col="yellow",
    schablone=false, schablone_height=10, schablone_diameter=1) {
    
    inch=25.4;
    dx = 0.65 * inch;
    dy = 0.5 * inch;
    
    mount_generic(dx, dy, z=z, pad=pad,
        slicex=(solid ? 0 : slicex), slicey=(solid ? 0 : slicey), 
        extendx=(solid ? 0 : extendx), extendy=(solid ? 0 : extendy), 
        slicepadx=(solid ? 0 : slicepadx), slicepady=(solid ? 0 : slicepady),
        clearpins=(solid ? false : clearpins),
        clearpin_cutoutx=16, clearpin_cutouty=+5, 
        showpins=showpins, showpinsonly=showpinsonly,
        npins=6,
        mount_pins_above_sensor=mount_pins_above_sensor,
        mount_pins_adjust=mount_pins_adjust,
        punch=punch, both=both, colonly=colonly, punchtype="ada_0.65", col=col,
        schablone_height=(!schablone ? "" : schablone_height),
        schablone_diameter=(!schablone ? "" : schablone_diameter)  
        );
};

// This fits the ada mcp9808 in the qw/st version
module mount_ada_st_size1_pins6(nx=1, ny=1, z=2, pad=2, 
    slicex=0, slicey=+8.5, extendx=1, extendy=1, 
    slicepadx=0, slicepady=+1, 
    clearpins=true,showpins=true, showpinsonly=false,
    mount_pins_above_sensor=false,
    mount_pins_adjust=-4, 
    punch=true, both=false,colonly=false, solid=false, col="yellow",
    schablone=false, schablone_height=10, schablone_diameter=1) {
    
    inch=25.4;
    dx = inch;
    dy = 0.7 * inch;
    
    mount_generic(dx, dy, z=z, pad=pad,
        slicex=(solid ? 0 : slicex), slicey=(solid ? 0 : slicey), 
        extendx=(solid ? 0 : extendx), extendy=(solid ? 0 : extendy), 
        slicepadx=(solid ? 0 : slicepadx), slicepady=(solid ? 0 : slicepady),
        clearpins=(solid ? false : clearpins),
        clearpin_cutoutx=16.32, clearpin_cutouty=+5, 
        showpins=showpins, showpinsonly=showpinsonly,
        npins=6,
        mount_pins_above_sensor=mount_pins_above_sensor,
        mount_pins_adjust=mount_pins_adjust,
        punch=punch, both=both,colonly=colonly, punchtype="ada_1.0", col=col,
        schablone_height=(!schablone ? "" : schablone_height),
        schablone_diameter=(!schablone ? "" : schablone_diameter)  
        );
   
};


// This fits the ada mcp9808 in the qw/st version
module mount_ada_st_size1_pins5(nx=1, ny=1, z=2, pad=2, 
    slicex=0, slicey=+8.5, extendx=0, extendy=0, 
    slicepadx=0, slicepady=+1, 
    clearpins=true,showpins=true, showpinsonly=false,
    mount_pins_above_sensor=false,
    mount_pins_adjust=-4, 
    punch=true, both=false,colonly=false, solid=false, col="yellow",
    schablone=false, schablone_height=10, schablone_diameter=1) {
    
    inch=25.4;
    dx = inch;
    dy = 0.7 * inch;
    
    mount_generic(dx, dy, z=z, pad=pad,
        slicex=(solid ? 0 : slicex), slicey=(solid ? 0 : slicey), 
        extendx=(solid ? 0 : extendx), extendy=(solid ? 0 : extendy), 
        slicepadx=(solid ? 0 : slicepadx), slicepady=(solid ? 0 : slicepady),
        clearpins=(solid ? false : clearpins),
        clearpin_cutoutx=16.32, clearpin_cutouty=+5, 
        showpins=showpins, showpinsonly=showpinsonly,
        npins=5,
        mount_pins_above_sensor=mount_pins_above_sensor,
        mount_pins_adjust=mount_pins_adjust,
        punch=punch, both=both,colonly=colonly, punchtype="ada_1.0", col=col,
        schablone_height=(!schablone ? "" : schablone_height),
        schablone_diameter=(!schablone ? "" : schablone_diameter)  
        );
   
};

// Pimoroni Garden sensors
module mount_garden(nx=1, ny=1, z=2, pad=2, 
    extendx=0, 
    extendy=0,
    clearpins=true,
    showpins=true, showpinsonly=false, mount_pins_above_sensor=false, mount_pins_adjust=-4, punch=true, both=false, colonly=false, solid=false, col="yellow", 
    schablone=false, schablone_height=10, schablone_diameter=1) {
        
    dx = 19;
    dy = 19;
    slicex=8; 
    slicey=10;
    slicepadx=0;
    slicepady=0;
    clearpin_cutoutoffset_y=-1;    
        
    mount_generic(dx, dy, z=z, pad=pad,
      slicex=(solid ? 0 : slicex), slicey=(solid ? 0 : slicey), 
        extendx=(solid ? 0 : extendx), extendy=(solid ? 0 : extendy), 
        slicepadx=(solid ? 0 : slicepadx), slicepady=(solid ? 0 : slicepady),
        clearpins=(solid ? false : clearpins),
        clearpin_cutoutx=14.5, clearpin_cutouty=6, 
        clearpin_cutoutoffset_y=clearpin_cutoutoffset_y,
        showpins=showpins, showpinsonly=showpinsonly,
        npins=5,
        mount_pins_above_sensor=mount_pins_above_sensor,
        mount_pins_adjust=mount_pins_adjust,
        punch=punch, both=both, colonly=colonly, punchtype="garden" , col=col,
        schablone_height=(!schablone ? "" : schablone_height),
        schablone_diameter=(!schablone ? "" : schablone_diameter)
    );
};


module mount_generic(
        dx_in, dy_in, z, pad, 
        slicex=0, slicey=0, 
        extendx=0, extendy=0,
        slicepadx=1, slicepady=1,
        clearpins=false,
        clearpin_cutoutx=12.5, clearpin_cutouty=5, 
        clearpin_cutoutoffset_y=0,
        showpins=false, showpinsonly=false,
        npins=4,
        mount_pins_above_sensor=false,
        mount_pins_adjust=0,
        punch=false, both=false, colonly=false, punchtype="ada_1.0", col="yellow",schablone_height="",
        schablone_diameter="" ) {
            
    dx = ceil(dx_in + pad);
    dy = ceil(dy_in + pad);   
            
    elements(dx_in=dx_in, dy_in=dy_in, z=z, 
        slicex=slicex, slicey=slicey, 
        extendx=extendx, extendy=extendy,
        slicepadx=slicepadx, slicepady=slicepady, 
        clearpins=clearpins,
        clearpin_cutoutx=clearpin_cutoutx, clearpin_cutouty=clearpin_cutouty,   
       clearpin_cutoutoffset_y=clearpin_cutoutoffset_y, 
        showpins=showpins, showpinsonly=showpinsonly,
        npins=npins,
        mount_pins_above_sensor=mount_pins_above_sensor,
        mount_pins_adjust=mount_pins_adjust,
        punch=punch, both=both, colonly=colonly, punchtype=punchtype, col=col,
        schablone_height=schablone_height,
        schablone_diameter=schablone_diameter   );
    };
    
    module elements(dx_in=40, dy_in=40, z=2, 
        slicex=2, slicey=2, 
        extendx=0, extendy=0,
        slicepadx=0, slicepady=0, 
        clearpins=false,
        clearpin_cutoutx=0, clearpin_cutouty=0,  
        clearpin_cutoutoffset_y=0,
        showpins=false,
        showpinsonly=false,
        npins=4,
        mount_pins_above_sensor=false,        
        mount_pins_adjust=0,
        punch=false, 
        both=false,
        colonly=false,
        punchtype="ada_1.0",
        schablone_height="",
        schablone_diameter="",    
        col="yellow") {
        
    inch = 25.4;
    if (!colonly && schablone_height=="" && !showpinsonly)  difference() {
        generateBoard();
        generateCutout();
    };      
    if (schablone_height!="") {
        generateCutout();
    };
    if (!colonly && (showpins || showpinsonly)) {
        if (punchtype=="garden") {
                translate([19/2,1.75,0.2]) rotate([0,0,90]) pin_header(5,1);
        } else {
            ypos= (
                punchtype=="ada_1.0" ? 2.5 : (
                punchtype=="ada_0.8" ? 2.3 : (
                punchtype=="ada_0.65" ? 2.3 : 2.5
            )));
            translate([dx_in/2, ypos,
                (mount_pins_above_sensor ? inch/10+z-2*2.54 : inch/6+z-2) + mount_pins_adjust
                    ]) rotate([
                        mount_pins_above_sensor ? 0 : 180,
                            0,90]) pin_header(npins,1);            
            };
    };
    if (colonly || both) 
        punchSelector(height=z,punchtype=punchtype);
    
    module generateBoard() {
        color(col) translate([-extendx,-extendy,0]) cube([dx_in+2*extendx, dy_in+2*extendy, z]);
    };
    module generateCutout() {
        ZZ = (schablone_height=="" ? z : schablone_height);
        DD = (schablone_diameter=="" ? "" : schablone_diameter);
        if (clearpins) {   
            translate([dx_in/2-clearpin_cutoutx/2,clearpin_cutoutoffset_y,-1]) 
                    cube([clearpin_cutoutx, clearpin_cutouty, ZZ+2]);                                                       
        };
        if (slicex>0) {
            translate([(dx_in-slicex)/2,-slicepadx,-1]) cube([slicex, dy_in+2*slicepadx, ZZ+2]);  
        };
        if (slicey>0) {
            translate([-slicepady,(dy_in-slicey)/2,-1]) cube([dx_in+2*slicepady, slicey, ZZ+2]);  
        };
        if (punch && !both) 
            punchSelector(height=ZZ, punchtype=punchtype, diameter=DD);
    };
    
    module punchSelector(height=10, punchtype="ada_1.0", diameter="") {
        DD = (diameter=="" ? 2.5 : diameter);
        if (punchtype == "ada_1.0") 
           sensorMountHoleAdaQwST(height=height, diameter=DD);
        else if (punchtype == "ada_0.8")
            sensorMountHolemcp(height=height, diameter=DD);
        else if (punchtype == "ada_0.65")
            sensorMountHole_mems_i2s(height=height, diameter=DD);
        else if (punchtype == "garden")
            sensorMountHoleGarden(height=height, diameter=DD);
        else echo("ERROR - punchtype in punchSelector not recognised.");
    };
    
    module sensorMountHoleAdaQwST(diameter="", height=0) {
        inch = 25.4;
        holesize = (diameter==""? 2.5 : diameter);
            color("green") translate([inch/10,inch/10,-height-10]) linear_extrude(20+2*height) {
            translate([0,0,0]) circle(d=holesize);
            translate([0,inch/2,0]) circle(d=holesize);
            translate([0.8*inch,0,0]) circle(d=holesize);
            translate([0.8*inch,inch/2,0]) circle(d=holesize);
        }
    }
    
    module sensorMountHolemcp(diameter="", height=0) {
        inch = 25.4;
        holesize = (diameter==""? 2.5 : diameter);
        color("green") translate([inch/10,4*inch/10,-10-height]) linear_extrude(20+2*height) {
            translate([0,0,0]) circle(d=holesize);
            translate([0.6*inch,0,0]) circle(d=holesize);          
        }
    }

    module sensorMountHole_mems_i2s(diameter="", height=0) {
        inch = 25.4;
        holesize = (diameter==""? 2.5 : diameter);
        // This sensor has a hole pattern left to right of: 0.1" + 0.45" + 0.1"
        // The hole is mounted at a height of 0.4".
        holefromside = inch/10;
        holefrombottom = 4*inch/10;        
        holedistance = 0.45*inch;
        color("green") translate([holefromside, holefrombottom,-10-height]) linear_extrude(20+2*height) {
            translate([0,0,0]) circle(d=holesize);
            translate([holedistance,0,0]) circle(d=holesize);          
        }
    }
    
    module sensorMountHoleGarden(diameter="", height=0) {
        clearance = 1.3;    
        holesize = 2.3;
        cutoutsize = (diameter==""? holesize : diameter);
        xx = 19 - (1.3 + 2.3/2 + 2.3/2 + 1.3);    
        translate([1.3+holesize/2,19-clearance-holesize/2,-1+height/2]) color("green") cylinderSet(xx, +4, z=height+10, d=cutoutsize, n=2);
    }

};


// Pimoroni Garden
module sensor_ltr559(punch=false, both=false) {
    sensor_garden_generic("LTR-559", punch=punch, both=both) ;
};

module sensor_bh1745(punch=false, both=false) {
    sensor_garden_generic("BH1745", punch=punch, both=both) ;
};

module sensor_garden_generic(text="Garden", punch=false, both=false, showpins=false) {
    translate([1,9,5]) color("black") text(text,size=3);
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
        translate([19/2,0.75,-0.2]) rotate([0,0,90]) pin_header(5,1);
    };
    module sensorMountHoleGarden() {
        clearance = 1.3;    
        holesize = 2.3;
        xx = 19 - (1.3 + 2.3/2 + 2.3/2 + 1.3);    
        translate([1.3+holesize/2,19-clearance-holesize/2,0]) color("green") 
            cylinderSet(xx, +4, z=10, d=holesize, n=2);
    }
};

// Adafruit non-QW/ST
module sensor_mcp9808(punch=false, both=false) {
    file = "models/1782-MCP9808.stl";
    label = "MCP9808";
    if (!punch) 
        importLabel(file, label, size=3);
    if (punch || both) 
        sensorMountHolemcp(diameter=2.5);
    
    module sensorMountHolemcp(diameter = 2.5) {
        inch = 25.4;
        color("green") translate([inch/10,4*inch/10,-10]) linear_extrude(20) {
            translate([0,0,0]) circle(d=diameter);
            translate([0.6*inch,0,0]) circle(d=diameter);          
        }
    }

};

module sensor_pdm(punch=false, both=false) {
    file = "models/PDM-Mic-with-JST-SH.stl";
    label = "PDM/ST";
    if (!punch) 
        importLabel(file, label, size=3);
    if (punch || both) 
        sensorMountHole(diameter=2.5);
    
    module sensorMountHole(diameter = 2.5) {
        inch = 25.4;
        color("green") translate([inch/10,4.5*inch/10,-10]) linear_extrude(20) {
            translate([0,0,0]) circle(d=diameter);
            translate([0.35*inch,0,0]) circle(d=diameter);          
        }
    }
};

/*
module sensor_pdm_i2s(punch=false, both=false) {
    file = "PDM-Mic-with-JST-SH.stl";
    label = "PDM/ST";
    if (!punch) 
        importLabel(file, label, size=3);
    if (punch || both) 
        sensorMountHole(diameter=2.5);
    
    module sensorMountHole(diameter = 2.5) {
        inch = 25.4;
        color("green") translate([inch/10,4.5*inch/10,-10]) linear_extrude(20) {
            translate([0,0,0]) circle(d=diameter);
            translate([0.35*inch,0,0]) circle(d=diameter);          
        }
    }
};
*/

module sensor_qwst_hub5(punch=false, both=false) {
    file = "models/5625_Stemma_5_Port_Hub.stl";
    label = "QW/ST Hub";
    if (!punch) 
        importLabel(file, label, size=3);
    if (punch || both) {
        inch=25.4;
        //cylinderSet(1*inch, 7*inch/10, dx=inch/10, dy=inch/10, z=10, d=2.5);
        // or
        // translate([inch/10,inch/10,0]) cylinderSet(0.8*inch, 5*inch/10, d=2.5);
        // or
        // cylinderSet(0.8*inch, 5*inch/10, d=2.5, ddx=inch/10, ddy=inch/10);
        // cylinderSet( 8, inch=true, 5, d=2.5, ddx=1, ddy=1);
        // cylinderSet( 8, inch=true, 5, d=2.5, ddx=1);
        cylinderSet(10, inch=true, 7, dx=1, z=10, d=2.5);
    };
    //    color("green") translate([inch/10,4.5*inch/10,-10]) linear_extrude(20) {
    //        translate([0,0,0]) circle(d=diameter);
    //        translate([0.35*inch,0,0]) circle(d=diameter);          
};

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

module sensor_sht40(punch=false, both=false) {
    AdafruitQWST("models/4485-SHT40.stl","SHT40", punch=punch, both=both);
};

module sensor_sht45(punch=false, both=false) {
    // Using the stl for SHT40. Prob very similar to SHT45.
    // Adding ~ to the name as a reminder.
    AdafruitQWST("models/4485-SHT40.stl","~SHT45~", punch=punch, both=both);
};

module sensor_bh1750(punch=false, both=false) {
    // Using the stl for SHT40. Will be different, but better than nothing.
    // Adding ~ to the name as a reminder.
    AdafruitQWST("models/5027-MCP9808-Stemma.stl","~BH1750~", punch=punch, both=both);
};


module sensor_mcp9808st(punch=false, both=false) {
    AdafruitQWST("models/5027-MCP9808-Stemma.stl","MCP9808 Qw/ST", punch=punch, both=both);
};

module sensor_aht20(punch=false, both=false) {
    AdafruitQWST("models/4566-AHT20-Sensor.stl","AHT20", punch=punch, both=both);
};

module importLabel(file, label="X", size=3) {
    translate([1,5,5]) color("black") text(label, halign="left", size=size);
    color("lightblue") import(file);
};
    
module AdafruitQWST(file, label="X", size=3, punch=false, both=false) {
    if (!punch) 
        importLabel(file, label, size);
    if (punch || both) 
        sensorMountHole(diameter=2.5);
    
    module sensorMountHole(diameter = 2.5) {
        inch = 25.4;
        color("green") translate([inch/10,inch/10,-10]) linear_extrude(20) {
            translate([0,0,0]) circle(d=diameter);
            translate([0,inch/2,0]) circle(d=diameter);
            translate([0.8*inch,0,0]) circle(d=diameter);
            translate([0.8*inch,inch/2,0]) circle(d=diameter);
        }
    }
};

