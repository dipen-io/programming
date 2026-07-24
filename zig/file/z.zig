const std = @import("std");

pub fn main(init: std.process.Init) !void {
    const io = init.io;
    const cwd = std.Io.Dir.cwd();

    {
        const file = try cwd.createFile(io, "sample.txt", .{});
        defer file.close(io);
        try file.writeStreamingAll(io, "Hello from Zig file handling!\n");
    }

    {
        const file = try cwd.openFile(io, "sample.txt", .{ .mode = .read_only });
        defer file.close(io);

        var buf: [1024]u8 = undefined;
        const n = try file.readStreaming(io, &.{&buf});
        try std.Io.File.stdout().writeStreamingAll(io, buf[0..n]);
    }
}
