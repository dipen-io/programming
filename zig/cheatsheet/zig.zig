const std = @import("std");
const print = std.debug.print;

// struct -> custom data types that can contain multiple data
const Point = struct {
    x: i32,
    y: i32,
};

const point: Point = Point {.x = 10, .y = 20 };
 
//Enum define a set of possible value for a variabeonst State = enum {
const State = enum {
    active,
    inactive,
};

const state: State = State.active;

pub fn main() !void {
    print("value of x is: {} \n", .{point.x});
    print("value of y is: {} \n", .{point.y});
    print("state is : {s} \n", .{@tagName(state)});
} 
