const std = @import("std");

// define custorm error 
const MathError = error{
    DivisionBYZero,
    NegativeNumber,
};

// function that my return error
fn devide(a: i32, b: i32) MathError!i32 {
    if (b == 0) {
        return MathError.DivisionBYZero;
    }
    return @divTrunc(a, b);
}

// function with multiple possible error 
fn squareRoot(x: i32) MathError!i32 {
    if (x < 0) {
        return MathError.NegativeNumber;
    }
    // Simplified square root (just for demonstration)
    var i: i32 = 0;
    while (i * i <= x) : (i += 1) {}
    return i - 1;
}


pub fn main() !void {
    const result1 = try devide(10, 2);
    std.debug.print("10 / 2 = {}\n", .{result1});

    // using catch to handle error
    const result2 = devide(10, 0) catch |err|  {
        std.debug.print("Error: {}\n", .{err});
        return;
    };

    std.debug.print("Result: {}\n", .{result2});


    // using if to handle errors conditionally

    if (squareRoot(16)) |root| {
        std.debug.print("Square root of 16: {}\n", .{root});
    } else |err| {
        std.debug.print("Error calculating square root: {}\n", .{err});
    }
}


