const std = @import("std");
const print  = std.debug.print;

fn max(a: anytype, b: anytype) @TypeOf(a, b){
    if (a > b) {
        return a;
    }
    return b;
}

// generic function with expliccit type parameter
fn swap(comptime T: type, a: *T, b: *T) void {
    const temp = a.*;
    a.* = b.*;
    b.* = temp;
}

pub fn main() !void {
    // works with different types
    std.debug.print("max(5, 10) = {}\n", .{max(5, 10)});
    std.debug.print("max(3.14, 2.71) = {d:.2}\n", .{max(3.14, 2.71)});

    var x: i32  = 1;
    var y: i32 = 2;
    print("before: x = {}, y = {}\n", .{x, y});
    swap(i32, &x, &y);
    print("after: x = {}, y = {}\n", .{x, y});

} 
