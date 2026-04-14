const std = @import("std");

pub fn main() !void {
    //f16 - 16-bit float
    const half: f16 = 1.5;

    // f32 - 32-bit float
    const single: f32 = 3.14159;

    // f64
    const double: f64 = 3.141592653589793;
    // f128 - 128-bit float (quad precision)
    const quad: f128 = 3.141592653589793238462643383279502884197;

    std.debug.print("f16: {d:.2}\n", .{half});
    std.debug.print("f32: {d:.5}\n", .{single});
    std.debug.print("f64: {d:.15}\n", .{double});
}
