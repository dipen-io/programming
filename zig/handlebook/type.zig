// memories are just a glorified lists of bits, often group as  chunks of bytes 

//  Integer: i8, i16, i32, i64, i128 : hold entire range of positive and negative number possible
//  to represent in bytes
//
//  positive number then use u8, u16, ...

// FLoating Poinst number: f8, f16, f32, f64, f128

// Boolean: just one bit : true or false


// Custom bit size 


pub fn main() u8 {
    const std = @import("std"); // valid 
    var x: u8 = 255;
    std.debug.print("x value: {}\n", .{x});

    std.debug.print("x type: {}\n", .{@TypeOf(x)});
    std.debug.print("x size: {}\n", .{@sizeOf(u8)}); // is it one type

    x +%= 1; // overflow aware add operator now x is = 0

    std.debug.print("x value: {}\n", .{x});

    var y : i16 = 255;
    std.log.debug("y value: {} ",.{y});
    std.log.debug("y type: {}",.{@TypeOf(y)});
    std.log.debug("y size: {}",.{@sizeOf(i16)});
    y += 1;
    std.debug.print("y value: {}\n", .{y});

    var z: u3 = 0;
    std.log.debug("z value : {}", .{z});
    std.log.debug("z type : {}", .{@TypeOf(z)});
    std.log.debug("z size : {}", .{@sizeOf(u3)});

    z += 1;
    std.log.debug("z value: {}", .{z});

    z += 2;
    std.log.debug("z value: {}", .{z});
    z += 4;
    std.log.debug("z value: {}", .{z});
    z += 6;
    std.log.debug("z value: {}", .{z}); // surprise ? why 
    return x;
}
