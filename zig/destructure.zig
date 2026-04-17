const std = @import("std");

pub fn main() !void {
    var x: u32 = undefined;
    var y: u32 = undefined;
    var z: u32 = undefined;

    const tuple = .{ 1, 2, 3 };
    x, y, z = tuple;
    std.debug.print("Tuple: x = {}, y = {}, z = {}\n", .{ x, y, z });

    const array = [_]u32{ 4, 5, 6 };
    x, y, z = array;
    std.debug.print("Array: x = {}, y = {}, z = {}\n", .{ x, y, z });

    const vector: @Vector(3, u32) = .{ 7, 8, 9 };
    x, y, z = vector;
    std.debug.print("Vector: x = {}, y = {}, z = {}\n", .{ x, y, z });
}
