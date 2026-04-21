const std = @import("std");
const assert = std.debug.assert;

fn empty() void {}
fn nothing() void {
    return;
}

pub fn main() !void {
    const n_x = {}; // void
    const x = n_x; // void
    assert(n_x == x);
    std.debug.print("{}\n", .{x});
    std.debug.print("{}\n", .{n_x});

    const void_x = empty();
    const void_y = nothing();
    std.debug.print("Returned empty:{} , nothing:{}\n", .{ void_x, void_y });
}
