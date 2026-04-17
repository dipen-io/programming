const std = @import("std");
const net = std.Io.net;

const port: u32 = 5800;

pub fn main(init: std.process.Init) !void {
    var threaded: std.Io.Threaded = .init_single_threaded;
    defer threaded.deinit();

    _ = init;
    const io = threaded.io();

    const addr = try net.IpAddress.parseIp4("127.0.0.1", port);

    var server = try addr.listen(io, .{
        .kernel_backlog = 128,
        .reuse_address = true,
    });
    defer server.deinit(io);

    std.debug.print("Listening on 127.0.0.1: {d}\n", .{port});

    while (true) {
        var conn = try server.accept(io);
        defer conn.close(io);

        std.debug.print("Client connected: {} \n", .{conn});
    }
}
