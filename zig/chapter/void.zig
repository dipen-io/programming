const std = @import("std");
const assert = std.debug.assert;

pub fn main() !void {
    const n_x = {}; // void
    const x = n_x; // void
    assert(n_x == x);
    std.debug.print("{}\n", .{x});
    std.debug.print("{}\n", .{n_x});
}
