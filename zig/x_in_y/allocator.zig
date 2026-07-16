const std = @import("std");
const print = std.debug.print;

// wring something on the buffer is allocator.dupe
fn makeMessage(allocator: std.mem.Allocator) ![]u8{
    return try allocator.dupe(u8, "hello zig from makeMessage");
}

pub fn main() !void {
    const allocator = std.heap.page_allocator;
    const buf = try allocator.alloc(u8, 5);
    defer allocator.free(buf);

    buf[0] = 'H';
    buf[1] = 'e';
    buf[2] = 'l';

    print("{c}\n", .{buf[0]});
    const message = try makeMessage(allocator);
    defer allocator.free(message);
    print("{s}\n", .{message});


    const name = "my name is dinesh";
    const msg = try allocator.dupe(u8, name);
    print("{s}\n", .{msg});
    defer allocator.free(msg);
}
