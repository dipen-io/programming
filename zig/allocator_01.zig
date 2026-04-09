const std = @import("std");

pub fn main() !void {
    // Manual memory management with allocators
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    // allocator is an interface
    const allocator = gpa.allocator();

    // Allocate memory
    // here we allocate memeroy
    const message = try allocator.alloc(u8, 100);
    defer allocator.free(message); // Explicit cleanup

    std.debug.print("Memory allocated!\n", .{});
}
