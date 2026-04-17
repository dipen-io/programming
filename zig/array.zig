const expectEqual = @import("std").testing.expectEqual;
const assert = @import("std").debug.assert;
const mem = @import("std").mem;
const print = @import("std").debug.print;

// array literal
const message = [_]u8{ 'h', 'e', 'l', 'l', 'o' };

// alternative initialization using result location
const alt_message: [5]u8 = .{ 'h', 'e', 'l', 'l', 'o' };

comptime {
    assert(mem.eql(u8, &message, &alt_message));
}

// get the size of array
comptime {
    assert(message.len == 5);
}

const same_message = "hello";

comptime {
    assert(mem.eql(u8, &message, same_message));
}

test "iterate over an array " {
    var sum: usize = 0;
    for (message) |byte| {
        sum += byte;
        print("{c}", .{byte});
    }
    print("\n", .{});
    try expectEqual('h' + 'e' + 'l' * 2 + 'o', sum);
}

// modifiable array
var some_integer: [100]i32 = undefined;

test "modify an array" {
    for (&some_integer, 0..) | *item, i| {
        item.* = @intCast(i);
    }

    try expectEqual(10, some_integer[10]);
    try expectEqual(99, some_integer[99]);
}
