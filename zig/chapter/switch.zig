const std = @import("std");
const print = std.debug.print;

pub fn main() !void {
    const n_age = 1;
    switch (n_age) {
        0...3 => {
            print("you are baby", .{});
        },
        4...10 => {
            print("you are todder.", .{});
        },
        11...15 => {
            print("you are yong", .{});
        },
        16...17 => {
            print("young but old enough to drive", .{});
        },
        else => {
            print("invalid age", .{});
        },
    }
}
