const std = @import("std");

pub fn main() !void {
    const is_learning: bool = true;
    const is_expert: bool = false;

    std.debug.print("Learning Zig: {}\n", .{is_learning});
    std.debug.print("Expert yet: {}\n", .{is_expert});

    //Boolean operation
    const both = is_learning and is_expert;
    const either = is_learning or is_expert;

    const not_expert = !is_expert;
    std.debug.print("Both: {}, Either: {}, Not expert: {}\n", .{ both, either, not_expert });
}
