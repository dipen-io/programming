// full std.Io way — from the official devlog
const std = @import("std");

// passing process info
// init: command line args | env variable
pub fn main(init: std.process.Init.Minimal) !void {
    // new name for GPA
    var debug_allocator: std.heap.DebugAllocator(.{}) = .init;
    const gpa = debug_allocator.allocator();

    var blocking = std.Io.Blocking;
    var threaded: std.Io.Threaded = .init(gpa, .{
        .argv0 = .init(init.args),
        .environ = init.environ,
    });
    defer threaded.deinit();

    const io = threaded.io();
    try std.Io.File.stdout().writeStreamingAll(io, "Hello, Zig!\n");
}
