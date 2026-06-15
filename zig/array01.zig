const std = @import("std");

pub fn main() void {
    const hello = "helloo";
    // _=hello;
    std.debug.print("{s}\n", .{ hello});
    for (hello, 0..) |ele, index| {
        std.debug.print("element: {c}, index: {}\n", .{ele, index });
    }

    var some_int  = [_]usize{ 1, 2, 3, 4, 5 };

    // modify the some_int
    for (&some_int, 0..) |*item, i|  {
        std.debug.print("itemB : {}\n", .{i});
        item.* = i * 2;
    }
    std.debug.print("{any}\n", .{some_int});
    
}
