const std = @import("std");

pub fn main() !void {
    //Undefine - uninitialized value (use with caution)
    var unititialized: i32 = undefined;
    unititialized = 43; // Must initialize before use\
    std.debug.print("Initialized value: {}\n", .{unititialized});

    // Optional types - can be null
    var maybe_number: ?i32 = null;
    std.debug.print("Optional is null: {}\n", .{maybe_number == null});

    maybe_number = 42;
    std.debug.print("Optional has value: {?}\n", .{maybe_number});

    // Unwrap optional with if
    if (maybe_number) |value| {
        std.debug.print("The value is: {}\n", .{value});
    }
}
