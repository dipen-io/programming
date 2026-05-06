const std = @import("std");

// simple function no param/return
fn greet() void {
    std.debug.print("greeting...\n", .{});
}
// with param
fn greetPerson(name: []const u8) void {
    std.debug.print("greeting...{s}\n", .{name});
}
// with return value (explicit return)
fn add(a: i32, b: i32) i32 {
    return a + b;
}

// i don't know about implicit return type yet

pub fn main() void {
    greet();
    const a = 10;
    const b = 10;
    greetPerson("dinesh");
    std.debug.print("Adding {} + {} = {}", .{ a, b, add(a, b) });
}
