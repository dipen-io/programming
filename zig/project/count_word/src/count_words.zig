const std = @import("std");

pub fn countWords (filename: []const u8, io: std.Io) !usize{
    // open file
    const file = try std.Io.Dir.cwd().openFile(io, filename, .{}); 
    defer file.close(io);

    var read_buf: [1024 * 2]u8 = undefined;
    const byte_read = try file.readPositionalAll(io, &read_buf, 0);

    const content = read_buf[0..byte_read];

    var count: usize = 0;
    var tokens = std.mem.tokenizeAny(u8, content, " \t\n\r");
    while (tokens.next() != null) count += 1;
    return count;
}
