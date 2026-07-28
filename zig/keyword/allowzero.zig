const std = @import("std");

pub fn main() void {
    const p: *allowzero i32 = @ptrFromInt(0);
    if (@intFromPtr(p) == 0) {
        std.debug.print("pointer is zero\n", .{});
    }
}

//A normal poiter in zig expect to be point to valid memeroy
//
