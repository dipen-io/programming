const std = @import("std");

// Zig most powerfull feature is comptime
// ability to run code at compile time

fn finonacci(comptime n: u32) u32 {
    if (n <= 1) return n; 
    return finonacci(n-1) + finonacci(n-2);

}

pub fn main() !void {
    std.debug.print("Hellow Comptime\n", .{});
    const fib_10 = finonacci(10);
    std.debug.print("10 Fibonacci number: {}\n", .{fib_10});
}
