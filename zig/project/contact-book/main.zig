const std = @import("std");
const Io = std.Io;

const Contact = struct {
    name: []const u8,
    email: []const u8,
    phone: []const u8,
};

const Operation = struct {
    list: []const u8,
    add: []const u8,
    remove: []const u8,
    search: []const u8,
};

const FILE = "contact.csv";

pub fn main(init: std.process.Init) !void {
    const io = init.io;

    // writer: io first, then buffer as empty slice literal
    var stdout_writer = Io.File.stdout().writer(io, &.{});
    const stdout = &stdout_writer.interface;

    var stdin_buf: [256]u8 = undefined;
    // reader: io first, then buffer as empty slice literal
    var stdin_reader = Io.File.stdin().reader(io, &stdin_buf);
    const stdin = &stdin_reader.interface;

    defer stdout.flush() catch {};

    const op = Operation{
        .list   = "list",
        .add    = "add",
        .remove = "remove",
        .search = "search",
    };

    while (true) {
        try stdout.print("\n=== Operations ===\n", .{});
        try stdout.print("1. {s}\n", .{op.list});
        try stdout.print("2. {s}\n", .{op.add});    // bug fixed: was op.list
        try stdout.print("3. {s}\n", .{op.remove});
        try stdout.print("4. {s}\n", .{op.search});
        try stdout.print("5. exit\n", .{});
        try stdout.print("Enter Choice: ", .{});
        try stdout.flush(); // flush before reading so prompt appears

        if (stdin.takeDelimiterExclusive('\n')) |line| {
            const choice = std.mem.trim(u8, line, "\r\n \t");

            if (std.mem.eql(u8, choice, "1")) {
                try stdout.print(">> Listing...\n", .{});
                try stdout.flush();
            } else if (std.mem.eql(u8, choice, "2")) {
                try stdout.print(">> Adding...\n", .{});
                try stdout.flush();
            } else if (std.mem.eql(u8, choice, "3")) {
                try stdout.print(">> Deleting...\n", .{});
                try stdout.flush();
            } else if (std.mem.eql(u8, choice, "4")) {
                try stdout.print(">> Searching...\n", .{});
                try stdout.flush();
            } else if (std.mem.eql(u8, choice, "5")) {
                try stdout.print("Goodbye!\n", .{});
                try stdout.flush();
                break;
            } else {
                try stdout.print("Invalid: '{s}' len={d}\n", .{ choice, choice.len });
                try stdout.flush();
            }
        } else |err| switch (err) {
            error.EndOfStream  => break,
            error.StreamTooLong => try stdout.print("Input too long\n", .{}),
            else => return err,
        }
    }
}
