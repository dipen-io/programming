const std = @import("std");

pub fn main() !void {
    // Variables 
    const language = "Zig";
    const year  = 2026;

    const newNumnber = 11;
    _=newNumnber; // we can't use this it is discarded

    std.debug.print("Learning {s} in {}\n", .{language, year});

    // basic arithmatic
    const a = 12;
    const b= 21;
    std.debug.print("{} + {} = {}\n", .{a, b, a+b});

    // Arrays
    const number = [_]i32{1,2,3,4,5};
    std.debug.print("First Number: {}\n", .{number[0]});
    std.debug.print("Array Length: {}\n", .{number.len});
}
