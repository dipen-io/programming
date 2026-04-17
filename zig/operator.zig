const std = @import("std");
const print = std.debug.print;

pub fn main() void {
    const a: u4 = 15;
    const b: u4 = 15;
    const c: u4 = a + b; // it will overflow
    const c: u4 = a +% b; // This works

    print("{} + {} = {}\n", .{ a, b, c });
}
