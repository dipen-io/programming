const std = @import("std");
const net = std.Io.net;

const port: u32 = 5800;

const ClientContext = struct { conn: net.Stream, io: std.Io };

pub fn main(init: std.process.Init) !void {
    _ = init;
    // main single thread
    // var threaded: std.Io.Threaded = .init_single_threaded;

    const T = std.heap.DebugAllocator(.{});
    var debug_alloc_instace = T{ .backing_allocator = std.heap.page_allocator };
    const allocator = debug_alloc_instace.allocator();
    //making mean thread multi thread
    var mThreaded = std.Io.Threaded.init(allocator, .{});
    defer mThreaded.deinit();
    const io = mThreaded.io();

    const addr = try net.IpAddress.parseIp4("127.0.0.1", port);

    var server = try addr.listen(io, .{
        .kernel_backlog = 128,
        .reuse_address = true,
    });
    defer server.deinit(io);

    std.debug.print("Listening on 127.0.0.1: {d}\n", .{port});

    while (true) {
        const conn = try server.accept(io);

        // spawn new connection
        const thread = try std.Thread.spawn(.{}, handleClient, .{ClientContext{
            .conn = conn,
            .io = io,
        }});
        thread.detach();

        std.debug.print("Client connected: {} \n", .{conn});
    }
}

fn handleClient(ctx: ClientContext) void {
    var conn = ctx.conn;
    const io = ctx.io;
    defer {
        conn.close(io);
        std.debug.print("Client disconnected on thread: {}\n", .{std.Thread.getCurrentId()});
    }

    std.debug.print("Client connected on thread: {}\n", .{std.Thread.getCurrentId()});
    var write_buf: [4096]u8 = undefined;
    var writer = conn.writer(io, &write_buf);

    var read_buf: [4096]u8 = undefined;
    var reader = conn.reader(io, &read_buf);

    // Send welcome
    writer.interface.writeAll("Hello from a new thread!\n") catch return;
    writer.interface.flush() catch return;

    // Echo loop
    while (true) {
        const line = reader.interface.takeDelimiterExclusive('\n') catch |err| {
            if (err == error.EndOfStream) {
                std.debug.print("Client disconnected gracefully (EOF).\n", .{});
            } else {
                std.debug.print("Connection dropped with error: {}\n", .{err});
            }
            return;
        };

        // const trimmed = std.mem.trimStart(u8, line, "\r\n ");
        const trimmed = std.mem.trim(u8, line, " \r\n\t");

        if (std.mem.eql(u8, trimmed, "quit")) {
            writer.interface.writeAll("Goodbye!\n") catch return;
            writer.interface.flush() catch |err| {
                std.debug.print("Write error: {}\n", .{err});
                return;
            };
            return;
        }

        writer.interface.writeAll("Echo: ") catch return;
        writer.interface.writeAll(trimmed) catch return;
        writer.interface.writeAll("\n") catch return;
        writer.interface.flush() catch |err| {
            std.debug.print("Write error: {}\n", .{err});
            return;
        };
    }
}
