const Point = struct { x: i32, y: i32 };
const std = @import("std");

// fancy_array showoff
var fancy_array = init: {
    var initial_value: [10]Point = undefined;

    for (&initial_value, 0..) |*pt, i| {
        pt.* = Point{
            .x =  @intCast(i),
            .y =  @intCast(i * 2),
        };
    }
    break :init initial_value;
};

pub fn main() void {
    std.debug.print("{any}\n", .{fancy_array});
}
