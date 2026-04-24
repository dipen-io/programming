const std = @import("std");
const net = std.Io.net;

const PORT: u32 = 8080;
const BUFFER_SIZE = 4096;

pub fn main(init: std.process.Init) !void {
    _ = init;

    var threaded: std.Io.Threaded = .init_single_threaded;
    defer threaded.deinit();
    const io = threaded.io();

    const addr = try net.IpAddress.parseIp4("127.0.0.1", PORT);

    var server = try addr.listen(io, .{
        .kernel_backlog = 128,
        .reuse_address = true,
    });
    defer server.deinit(io);

    std.debug.print("TCP server listening on 127.0.0.1:{d}\n", .{PORT});

    while (true) {
        var conn = try server.accept(io);
        defer conn.close(io);

        std.debug.print("Client connected: {}\n", .{conn});

        handleClient(io, &conn) catch |err| {
            std.debug.print("Client error: {}\n", .{err});
        };

        std.debug.print("Client disconnected\n", .{});
    }
}

fn handleClient(io: std.Io, conn: anytype) !void {
    var write_buf: [BUFFER_SIZE]u8 = undefined;
    var writer = conn.writer(io, &write_buf);

    var read_buf: [BUFFER_SIZE]u8 = undefined;
    var reader = conn.reader(io, &read_buf);

    // Send welcome message
    try writer.interface.writeAll("Welcome to Zig TCP Server! Type 'quit' to disconnect.\n");
    try writer.interface.flush();

    // Read-echo loop
    while (true) {
        var line_buf: [1024]u8 = undefined;
        const line = reader.interface.readUntilDelimiter(&line_buf, '\n') catch |err| switch (err) {
            error.EndOfStream => return,
            else => return err,
        };

        const trimmed = std.mem.trimRight(u8, line, "\r\n ");
        std.debug.print("Received: {s}\n", .{trimmed});

        if (std.mem.eql(u8, trimmed, "quit")) {
            try writer.interface.writeAll("Goodbye!\n");
            try writer.interface.flush();
            return;
        }

        try writer.interface.writeAll("Echo: ");
        try writer.interface.writeAll(trimmed);
        try writer.interface.writeAll("\n");
        try writer.interface.flush();
    }
}
