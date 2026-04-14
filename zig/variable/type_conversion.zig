const std = @import("std");

pub fn main() !void {
    // Explicit type conversion using @as
    const x: i32 = 42;
    const y: f64 = @as(f64, @floatFromInt(x));

    std.debug.print("Integer: {}\n", .{x});
    std.debug.print("Converted to float: {d:.2}\n", .{y});

    // Converting between integer types
    const big: i32 = 1000;
    const small: i16 = @intCast(big); // Use @intCast for integer conversions
    std.debug.print("i32 to i16: {}\n", .{small});

    // Converting float to integer (truncates)
    const float_val: f64 = 42.9;
    const int_val: i32 = @intFromFloat(float_val);

    std.debug.print("Float {d:.1} to int: {}\n", .{ float_val, int_val });
}
