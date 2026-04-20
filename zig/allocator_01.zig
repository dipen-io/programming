const std = @import("std");

pub fn main(init: std.process.Init) !void {
    // Manual memory management with allocators
    // var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    var gpa = init.arena.allocator();

    // Allocate memory
    // here we allocate memeroy
    const message = try gpa.alloc(u8, 100);
    defer gpa.free(message);

    std.debug.print("Memory allocated! \n", .{});
}
