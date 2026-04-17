const std = @import("std");

pub fn main() !void {
    var x: u32 = undefined;
    var y: u32 = undefined;
    var z: u32 = undefined;

    const tuple = .{ 1, 2, 3 };
    x, y, z = tuple;
    std.debug.print("tuple: x = {}, y = {}, z = {}\n", .{ x, y, z });
}
